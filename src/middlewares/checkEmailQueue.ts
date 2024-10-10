import mysql, { RowDataPacket } from 'mysql2/promise';
import nodemailer from 'nodemailer';
import { SentMessageInfo } from 'nodemailer';
import { Logger } from './logger';

interface MinhaTabelaRow extends RowDataPacket {
  id: number;
  identificador: string;
  destinatario: string;
  titulo: string;
  operacao: number;
  corpo: string;
  status: string;
  data: Date;
  usuario: number;
  sensivel: number;
}
interface Feedbacker extends RowDataPacket {
  id: number;
  identificador: string;
  destinatario: string;
}

let ultimaVerificacao: Date = new Date();

const pool = mysql.createPool({
    host: '104.131.174.207',
    user: 'geral',
    password: '6@/[sazOBnaN8!gv',
    database: 'tcc',
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
      'SELECT * FROM fila_emails WHERE status = 1 ORDER BY data ASC',
      [ultimaVerificacao]
    );

    if (rows.length > 0) {
      console.log(`Encontrados ${rows.length} novos registros.`);
      Logger('sendEmail', `Encontrados ${rows.length} novos registros.`, "info")

      for (const email of rows) {
        await processarEmail(email);
        ultimaVerificacao = email.data;
      }
    } 
  } catch (error) {
    console.error('Erro durante a verificação de novos registros:', error);
    Logger('sendEmail', `Erro durante a verificação de novos registros ${error}`, "error")

  } finally {
    setTimeout(checkEmailQueue, 30000); // Verifica novamente após 30 segundos
  }
}

async function processarEmail(email: MinhaTabelaRow): Promise<void> {
  try {
    console.log(`Enviando email para ${email.destinatario} com o título "${email.titulo}"...`);
    Logger('sendEmail', `Enviando email para ${email.destinatario} com o título "${email.titulo}"...`, "info")
    sendEmail(email.destinatario, email.titulo, email.corpo, email.id);

  } catch (error) {
    console.error(`Erro ao processar email ${email.id}:`, error);
    Logger('sendEmail', `Erro ao processar email ${email.id}: ${error}`, "error")

  }
}

async function sendEmail(email: string | string[], subject: string, body: string, id: number): Promise<void> {
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
        await transporter.sendMail(mailOptions);
        updateEmailStatus(id, "200");
        Logger('sendEmail', "Email enviado com sucesso!", "success")
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao enviar email:', error.message);
            updateEmailStatus(id, "500");
            Logger('sendEmail', error.message, "error")

        } else {
            console.error('Erro ao enviar email: Erro desconhecido');
            updateEmailStatus(id, "504");
            Logger('sendEmail', "Erro desconhecido", "error")
        }
    }
};

async function updateEmailStatus(id: number, status: string): Promise<void> {
    await pool.execute(
      'UPDATE fila_emails SET status = ? WHERE id = ?',
      [status, id]
    );
}