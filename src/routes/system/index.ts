import { Router } from 'express';
import { PrismaClient } from '@prisma/client';
import { validateJWT } from '../../middlewares/JWTVerifier';
import nodemailer from 'nodemailer';
import { SentMessageInfo } from 'nodemailer';
import { Logger } from '../../middlewares/logger';
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

routerSystem.post('/new-log', validateJWT, async (req, res) => {
    let { funcao, mensagem, status, usuario } = req.body;
  
    try {
      if (usuario) {
        const userExists = await prisma.usuario.findUnique({
          where: { id: usuario }
        });
  
        if (!userExists) {
          // Envie uma resposta de erro ao cliente
          return res.status(404).json({ error: `Usuário com ID ${usuario} não encontrado` });
        }
      }
  
      const registerLog = await prisma.logs.create({
        data: {
          funcao,
          mensagem,
          usuario: usuario ?? null,
          status
        }
      });
  
      // Envie a resposta de sucesso ao cliente
      return res.status(201).json(registerLog);
    } catch (error) {
      if (error instanceof Error) {
        console.error('Erro ao registrar log:', error.message);
        // Envie uma resposta de erro ao cliente
        return res.status(500).json({ error: `Erro ao registrar log: ${error.message}` });
      } else {
        console.error('Erro desconhecido ao registrar log:', error);
        // Envie uma resposta de erro ao cliente
        return res.status(500).json({ error: 'Erro desconhecido ao registrar log' });
      }
    }
  });
  

routerSystem.get('/logs', validateJWT, async (req, res) => {
    try {
        const logs = await prisma.logs.findMany();

        if (logs) {
            Logger(`GET - SYSTEM - logs`, `200 - Found and Authorized`, 'success');
            res.status(200).json(logs);
        } else {
            Logger(`GET - SYSTEM - logs`, `404 - Not Found`, 'error');
            res.status(404).send({ error: true, message: 'Registro não encontrado!' });
        }
    } catch (error) {
        if (error instanceof Error) {
            Logger(`GET - SYSTEM - logs`, `500 - Error fetching record: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar LOGS.', error: error.message });
        } else {
            Logger(`GET - SYSTEM - logs`, '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar LOGS.', error: 'Unknown error' });
        }
    }
});

routerSystem.get('/logs/last50', validateJWT, async (req, res) => {
    try {
        const logs = await prisma.logs.findMany({
            take: 50,
            orderBy: {
                id: 'desc', // Substitua por 'id' se 'created_at' não existir
            },
        });

        if (logs && logs.length > 0) {
            Logger(`GET - SYSTEM - logs/last50`, `200 - Found and Authorized`, 'success');
            res.status(200).json(logs);
        } else {
            Logger(`GET - SYSTEM - logs/last50`, `404 - Not Found`, 'error');
            res.status(404).send({ error: true, message: 'Nenhum registro de log encontrado!' });
        }
    } catch (error) {
        if (error instanceof Error) {
            Logger(`GET - SYSTEM - logs/last50`, `500 - Error fetching logs: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar LOGS.', error: error.message });
        } else {
            Logger(`GET - SYSTEM - logs/last50`, '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar LOGS.', error: 'Erro desconhecido' });
        }
    }
});

routerSystem.get('/logs-user/:user', validateJWT, async (req, res) => {
    const user = Number(req.params.user);
    try {
        const logs = await prisma.logs.findMany({
            where: { usuario: user },
        });

        if (logs) {
            Logger(`GET - SYSTEM - logs-user/${user}`, `200 - Found and Authorized`, 'success');
            res.status(200).json(logs);
        } else {
            Logger(`GET - SYSTEM - logs-user/${user}`, `404 - Not Found`, 'error');
            res.status(404).send({ error: true, message: 'Registro não encontrado!' });
        }
    } catch (error) {
        if (error instanceof Error) {
            Logger(`GET - SYSTEM - logs-user/${user}`, `500 - Error fetching record: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: error.message });
        } else {
            Logger(`GET - SYSTEM - logs-user/${user}`, '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: 'Unknown error' });
        }
    }
});

routerSystem.get('/timelines', validateJWT, async (req, res) => {
    try {
        const timelines = await prisma.timelines.findMany();

        if (timelines) {
            Logger(`GET - SYSTEM - timelines`, `200 - Found and Authorized`, 'success');
            res.status(200).json(timelines);
        } else {
            Logger(`GET - SYSTEM - timelines`, `404 - Not Found`, 'error');
            res.status(404).send({ error: true, message: 'Registro não encontrado!' });
        }
    } catch (error) {
        if (error instanceof Error) {
            Logger(`GET - SYSTEM - timelines`, `500 - Error fetching record: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar LOGS.', error: error.message });
        } else {
            Logger(`GET - SYSTEM - timelines`, '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar LOGS.', error: 'Unknown error' });
        }
    }
});

routerSystem.get('/timelines-user/:user', validateJWT, async (req, res) => {
    const user = Number(req.params.user);
    try {
        const timelines = await prisma.timelines.findMany({
            where: { usuario: user },
        });

        if (timelines) {
            Logger(`GET - SYSTEM - timelines-user/${user}`, `200 - Found and Authorized`, 'success');
            res.status(200).json(timelines);
        } else {
            Logger(`GET - SYSTEM - timelines-user/${user}`, `404 - Not Found`, 'error');
            res.status(404).send({ error: true, message: 'Registro não encontrado!' });
        }
    } catch (error) {
        if (error instanceof Error) {
            Logger(`GET - SYSTEM - timelines-user/${user}`, `500 - Error fetching record: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: error.message });
        } else {
            Logger(`GET - SYSTEM - timelines-user/${user}`, '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: 'Unknown error' });
        }
    }
});

routerSystem.get('/timelines-proccess/:processo', validateJWT, async (req, res) => {
    const processo = req.params.processo;
    try {
        const timelines = await prisma.timelines.findMany({
            where: { referencia: processo },
        });

        if (timelines) {
            Logger(`GET - SYSTEM - timelines-processo/${processo}`, `200 - Found and Authorized`, 'success');
            res.status(200).json(timelines);
        } else {
            Logger(`GET - SYSTEM - timelines-processo/${processo}`, `404 - Not Found`, 'error');
            res.status(404).send({ error: true, message: 'Registro não encontrado!' });
        }
    } catch (error) {
        if (error instanceof Error) {
            Logger(`GET - SYSTEM - timelines-processo/${processo}`, `500 - Error fetching record: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: error.message });
        } else {
            Logger(`GET - SYSTEM - timelines-processo/${processo}`, '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: 'Unknown error' });
        }
    }
});

routerSystem.get('/logins', validateJWT, async (req, res) => {
    try {
        const logins = await prisma.logins.findMany();

        if (logins) {
            Logger(`GET - SYSTEM - logins`, `200 - Found and Authorized`, 'success');
            res.status(200).json(logins);
        } else {
            Logger(`GET - SYSTEM - logins`, `404 - Not Found`, 'error');
            res.status(404).send({ error: true, message: 'Registro não encontrado!' });
        }
    } catch (error) {
        if (error instanceof Error) {
            Logger(`GET - SYSTEM - logins`, `500 - Error fetching record: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar LOGS.', error: error.message });
        } else {
            Logger(`GET - SYSTEM - logins`, '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar LOGS.', error: 'Unknown error' });
        }
    }
});

routerSystem.get('/logins-user/:user', validateJWT, async (req, res) => {
    const user = Number(req.params.user);
    try {
        const logins = await prisma.logins.findMany({
            where: { usuario: user },
        });

        if (logins) {
            Logger(`GET - SYSTEM - logins-user/${user}`, `200 - Found and Authorized`, 'success');
            res.status(200).json(logins);
        } else {
            Logger(`GET - SYSTEM - logins-user/${user}`, `404 - Not Found`, 'error');
            res.status(404).send({ error: true, message: 'Registro não encontrado!' });
        }
    } catch (error) {
        if (error instanceof Error) {
            Logger(`GET - SYSTEM - logins-user/${user}`, `500 - Error fetching record: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: error.message });
        } else {
            Logger(`GET - SYSTEM - logins-user/${user}`, '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: 'Unknown error' });
        }
    }
});

routerSystem.get('/system-roles', validateJWT, async (req, res) => {
    res.status(200).json([
        {
            "role": 1,
            "label": 'Aluno',
        },
        {
            "role": 2,
            "label": 'Servidor',
        },
        {
            "role": 3,
            "label": 'Professor',
        },
        {
            "role": 9,
            "label": 'Admin',
        },
        {
            "role": 0,
            "label": 'Deactivated',
        },
    ])
    });