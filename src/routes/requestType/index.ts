import { Router } from 'express';
import { validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';

export const routerRequestType = Router()

routerRequestType.get('/', (req, res) => res.send('API de Tipos de Solicitações'))

routerRequestType.post('/new', validateJWT, async (req, res) => {
    let { nome, fluxograma, hrs_resolucao, hrs_resposta } = req.body;

    try {
        const request = await prisma.tipo_solicitacao.create({
            data: {
                nome,
                fluxograma,
                hrs_resolucao: Number(hrs_resolucao),
                hrs_resposta: Number(hrs_resposta)
            }
        })
        Logger(`POST - REQUEST TYPE - new`, JSON.stringify(request), "success");
        res.status(200).send(JSON.stringify(request));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao cadastrar tipo de processo:', error.message);
            Logger(`POST - REQUEST TYPE - new`, error.message, "error");
            res.status(500).send({ message: 'Erro ao cadastrar tipo de processo', error: error.message });
        } else {
            console.error('Erro ao cadastrar tipo de processo: Erro desconhecido');
            Logger(`POST - REQUEST TYPE - new`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao cadastrar tipo de processo', error: 'Erro desconhecido' });
        }
    }
});

routerRequestType.get('/id/:id', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const steps = await prisma.tipo_solicitacao.findFirst({
            where: {
                id: id
            }
        })

        if (steps) {
            Logger(`GET - REQUEST TYPE - id/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUEST TYPE - id/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUEST TYPE - id/${id}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});


routerRequestType.get('/all', validateJWT, async (req, res) => {
    try {
        const steps = await prisma.tipo_solicitacao.findMany()

        if (steps) {
            Logger(`GET - REQUEST TYPE - all`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUEST TYPE - all`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Fields not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUEST TYPE - all`, `Error fetching requested Fields. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested fields.' });
    }
});





