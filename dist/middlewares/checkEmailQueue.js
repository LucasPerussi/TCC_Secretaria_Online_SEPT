"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.checkEmailQueue = void 0;
const promise_1 = __importDefault(require("mysql2/promise"));
const nodemailer_1 = __importDefault(require("nodemailer"));
const logger_1 = require("./logger");
let ultimaVerificacao = new Date();
const pool = promise_1.default.createPool({
    host: '104.131.174.207',
    user: 'geral',
    password: '6@/[sazOBnaN8!gv',
    database: 'tcc',
});
let transporter = nodemailer_1.default.createTransport({
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
function checkEmailQueue() {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const [rows] = yield pool.query('SELECT * FROM fila_emails WHERE status = 1 ORDER BY data ASC', [ultimaVerificacao]);
            if (rows.length > 0) {
                console.log(`Encontrados ${rows.length} novos registros.`);
                (0, logger_1.Logger)('sendEmail', `Encontrados ${rows.length} novos registros.`, "info");
                for (const email of rows) {
                    yield processarEmail(email);
                    ultimaVerificacao = email.data;
                }
            }
        }
        catch (error) {
            console.error('Erro durante a verificação de novos registros:', error);
            (0, logger_1.Logger)('sendEmail', `Erro durante a verificação de novos registros ${error}`, "error");
        }
        finally {
            setTimeout(checkEmailQueue, 30000); // Verifica novamente após 30 segundos
        }
    });
}
exports.checkEmailQueue = checkEmailQueue;
function processarEmail(email) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            console.log(`Enviando email para ${email.destinatario} com o título "${email.titulo}"...`);
            (0, logger_1.Logger)('sendEmail', `Enviando email para ${email.destinatario} com o título "${email.titulo}"...`, "info");
            sendEmail(email.destinatario, email.titulo, email.corpo, email.id);
        }
        catch (error) {
            console.error(`Erro ao processar email ${email.id}:`, error);
            (0, logger_1.Logger)('sendEmail', `Erro ao processar email ${email.id}: ${error}`, "error");
        }
    });
}
function sendEmail(email, subject, body, id) {
    return __awaiter(this, void 0, void 0, function* () {
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
            yield transporter.sendMail(mailOptions);
            updateEmailStatus(id, "200");
            (0, logger_1.Logger)('sendEmail', "Email enviado com sucesso!", "success");
        }
        catch (error) {
            if (error instanceof Error) {
                console.error('Erro ao enviar email:', error.message);
                updateEmailStatus(id, "500");
                (0, logger_1.Logger)('sendEmail', error.message, "error");
            }
            else {
                console.error('Erro ao enviar email: Erro desconhecido');
                updateEmailStatus(id, "504");
                (0, logger_1.Logger)('sendEmail', "Erro desconhecido", "error");
            }
        }
    });
}
;
function updateEmailStatus(id, status) {
    return __awaiter(this, void 0, void 0, function* () {
        yield pool.execute('UPDATE fila_emails SET status = ? WHERE id = ?', [status, id]);
    });
}
