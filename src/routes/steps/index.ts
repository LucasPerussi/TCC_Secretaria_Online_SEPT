import { Router } from 'express';
import { validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';

export const routerSteps = Router()

routerSteps.get('/', (req, res) => res.send('API de Enum de Etapas'))

routerSteps.post('/new', validateJWT, async (req, res) => {
    let { nome, label, padrao } = req.body;

    try {
        const step = await prisma.enum_etapas.create({
            data: {
                nome,
                label,
                padrao
            }
        })
        Logger(`POST - STEPS - NEW`, JSON.stringify(step), "success");
        res.status(200).send(JSON.stringify(step));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar estágio:', error.message);
            Logger(`POST - STEPS - NEW`, error.message, "error");
            res.status(500).send({ message: 'Erro ao criar estágio', error: error.message });
        } else {
            console.error('Erro ao criar estágio: Erro desconhecido');
            Logger(`POST - STEPS - NEW`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao criar estágio', error: 'Erro desconhecido' });
        }
    }
});

routerSteps.get('/id/:id', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const steps = await prisma.enum_etapas.findFirst({
            where: {
                id: id
            }
        })

        if (steps) {
            Logger(`GET - STEPS - id/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - STEPS - id/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Step not found!' });
        }
    } catch (error) {
        Logger(`GET - STEPS - id/${id}`, `Error fetching requested Step. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Step.' });
    }
});

routerSteps.get('/all', validateJWT, async (req, res) => {
    try {
        const steps = await prisma.enum_etapas.findMany()

        if (steps) {
            Logger(`GET - STEPS - all`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - STEPS - all`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Steps not found!' });
        }
    } catch (error) {
        Logger(`GET - STEPS - all`, `Error fetching requested Steps. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Step.' });
    }
});

routerSteps.get('/all-default', validateJWT, async (req, res) => {
    try {
        const steps = await prisma.enum_etapas.findMany({
            where: {
                padrao : 1
            }
        })

        if (steps) {
            Logger(`GET - STEPS - all-default`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - STEPS - all-default`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Steps not found!' });
        }
    } catch (error) {
        Logger(`GET - STEPS - all-default`, `Error fetching requested Steps. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Step.' });
    }
});








