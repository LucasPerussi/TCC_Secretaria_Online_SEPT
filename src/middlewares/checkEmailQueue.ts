import mysql, { RowDataPacket } from 'mysql2/promise';
import nodemailer from 'nodemailer';
import { SentMessageInfo } from 'nodemailer';

interface MinhaTabelaRow extends RowDataPacket {
  fem_id: number;
  fem_identifier: string;
  fem_receiver: string;
  fem_title: string;
  fem_operation: number;
  fem_body: string;
  fem_status: number;
  fem_date: Date;
  fem_user: number;
  fem_sensitive: number;
  fem_priority: number;
}
interface Feedbacker extends RowDataPacket {
  fem_id: number;
  fem_identifier: string;
  fem_receiver: string;
 
}

let ultimaVerificacao: Date = new Date();

const pool = mysql.createPool({
    host: '104.131.174.207',
    user: 'wwweta_api',
    password: 'dtp9SNSppdkkjLnDseGSQgavuPszXVD3VWSsugMMczE9JULQianyAxozxQZqJPK3k5XytFQ9UEiSz',
    database: 'wwweta_suporte',
  });  

let transporter = nodemailer.createTransport({
    service: 'Outlook365',
    auth: {
        user: 'wejourney@wetalkit.com.br',
        pass: 'lvdpfsxltqbvtbys'
    },
    tls: {
        ciphers: 'SSLv3'
    },
    pool: true,
    maxConnections: 5,
    maxMessages: 100,
});

export async function checkEmailQueue(): Promise<void> {
  try {
    const [rows] = await pool.query<MinhaTabelaRow[]>(
      'SELECT * FROM fila_emails WHERE fem_status = 1 ORDER BY fem_date ASC',
      [ultimaVerificacao]
    );

    if (rows.length > 0) {
      console.log(`Encontrados ${rows.length} novos registros.`);
      for (const email of rows) {
        await processarEmail(email);
        ultimaVerificacao = email.fem_date;
      }
    } 
    // else {
    //   console.log('Nenhum novo registro encontrado.');
    // }
  } catch (error) {
    console.error('Erro durante a verificação de novos registros:', error);
  } finally {
    setTimeout(checkEmailQueue, 60000); // Verifica novamente após 1 minuto
  }
}

async function processarEmail(email: MinhaTabelaRow): Promise<void> {
  try {
    console.log(`Enviando email para ${email.fem_receiver} com o título "${email.fem_title}"...`);
    sendEmail(email.fem_receiver, email.fem_title, email.fem_body, email.fem_id);

    // await pool.execute(
    //   'UPDATE fila_emails SET fem_status = ? WHERE fem_id = ?',
    //   [2, email.fem_id] // Supondo que '2' signifique "enviado"
    // );
    // console.log(`Email ${email.fem_id} enviado com sucesso.`);
  } catch (error) {
    console.error(`Erro ao processar email ${email.fem_id}:`, error);
  }
}

async function sendEmail(email: string | string[], subject: string, body: string, id: number): Promise<void> {
  console.log("caiu no sendEmail");
    if (typeof email === 'string') {
        email = email.split(',').map(e => e.trim());
    }

    const mailOptions = {
        from: 'wejourney@wetalkit.com.br',
        to: email,
        subject: subject,
        html: body
    };
    try {
        console.log("caiu no try");

        await transporter.sendMail(mailOptions);
        updateEmailStatus(id, "200", "Email enviado com sucesso!");
    } catch (error) {
        if (error instanceof Error) {

            console.error('Erro ao enviar email:', error.message);
            updateEmailStatus(id, "500", error.message);
        } else {
            console.error('Erro ao enviar email: Erro desconhecido');
            updateEmailStatus(id, "504", "Erro desconhecido");
        }
    }
};

async function updateEmailStatus(id: number, status: string, message: string): Promise<void> {
    await pool.execute(
      'UPDATE fila_emails SET fem_status = ?, fem_status_message = ? WHERE fem_id = ?',
      [status, message, id]
    );
}