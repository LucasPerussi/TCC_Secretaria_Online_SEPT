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
exports.routerSystem = void 0;
const express_1 = require("express");
const client_1 = require("@prisma/client");
const JWTVerifier_1 = require("../../middlewares/JWTVerifier");
const nodemailer_1 = __importDefault(require("nodemailer"));
const osUtils = require('os-utils');
const prisma = new client_1.PrismaClient();
exports.routerSystem = (0, express_1.Router)();
exports.routerSystem.get('/', (req, res) => res.send('API de Sistema'));
let transporter = nodemailer_1.default.createTransport({
    service: 'Outlook365',
    auth: {
        user: 'lucas@wetalkit.com.br',
        pass: 'sqjdrdksdzljmzmp'
    },
    tls: {
        ciphers: 'SSLv3'
    },
    pool: true,
    maxConnections: 5,
    maxMessages: 100,
});
exports.routerSystem.get('/server-status', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    osUtils.cpuUsage((cpuPercent) => {
        const serverStatus = {
            cpuUsage: cpuPercent.toFixed(2),
            freeMemory: osUtils.freemem(),
            totalMemory: osUtils.totalmem(),
            freeMemoryPercentage: osUtils.freememPercentage().toFixed(2),
            systemUptime: osUtils.sysUptime()
        };
        res.json(serverStatus);
    });
}));
exports.routerSystem.post('/send-email', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    let { email, subject, body } = req.body;
    if (typeof email === 'string') {
        email = email.split(',').map(e => e.trim());
    }
    const mailOptions = {
        from: 'lucas@wetalkit.com.br',
        to: email,
        subject: subject,
        html: body
    };
    try {
        yield transporter.sendMail(mailOptions);
        res.status(200).send({ message: 'Email enviado com sucesso' });
    }
    catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao enviar email:', error.message);
            res.status(500).send({ message: 'Erro ao enviar email', error: error.message });
        }
        else {
            console.error('Erro ao enviar email: Erro desconhecido');
            res.status(500).send({ message: 'Erro ao enviar email', error: 'Erro desconhecido' });
        }
    }
}));
