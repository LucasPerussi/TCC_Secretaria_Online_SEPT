import { Router } from 'express';
import { PrismaClient } from '@prisma/client';
import { validateJWT } from '../../middlewares/JWTVerifier';
import nodemailer from 'nodemailer';
import { SentMessageInfo } from 'nodemailer';
const osUtils = require('os-utils');


const prisma = new PrismaClient();
export const routerSystem = Router();

routerSystem.get('/', (req, res) => res.send('API de Sistema'));

let transporter = nodemailer.createTransport({
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

routerSystem.get('/server-status', validateJWT, async (req, res) => {
    osUtils.cpuUsage((cpuPercent: number) => {
        const serverStatus = {
            cpuUsage: cpuPercent.toFixed(2),
            freeMemory: osUtils.freemem(),
            totalMemory: osUtils.totalmem(),
            freeMemoryPercentage: osUtils.freememPercentage().toFixed(2),
            systemUptime: osUtils.sysUptime() 
        };

        res.json(serverStatus);
    });
});

routerSystem.post('/send-email', validateJWT, async (req, res) => {
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
        await transporter.sendMail(mailOptions);
        res.status(200).send({ message: 'Email enviado com sucesso' });
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao enviar email:', error.message);
            res.status(500).send({ message: 'Erro ao enviar email', error: error.message });
        } else {
            console.error('Erro ao enviar email: Erro desconhecido');
            res.status(500).send({ message: 'Erro ao enviar email', error: 'Erro desconhecido' });
        }
    }
});
