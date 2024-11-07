import { Router } from 'express';
import { validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';
import { codeGenerator } from '../../middlewares/randomCodeGenerator';

export const routerMural = Router()

routerMural.get('/', (req, res) => res.send('API de Murais'))

routerMural.post('/new', validateJWT, async (req, res) => {
    let { titulo, descricao, autor, curso, visivel } = req.body;

    try {
        // Verifique se o autor existe na tabela de referência
        const autorExiste = await prisma.usuario.findUnique({
            where: { id: autor }
        });

        if (!autorExiste) {
            return res.status(400).send({ message: 'Autor não encontrado' });
        }

        let identificador = await codeGenerator(20);
        const mural = await prisma.mural.create({
            data: {
                titulo,
                descricao,
                identificador,
                autor,
                curso_alvo: curso,
                visivel,
            }
        });
        Logger(`POST - MURAL - new`, JSON.stringify(mural), "success");
        res.status(200).send(JSON.stringify(mural));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar Mural:', error.message);
            Logger(`POST - MURAL - new`, error.message, "error");
            res.status(500).send({ message: 'Erro ao criar Mural', error: error.message });
        } else {
            console.error('Erro ao criar Mural: Erro desconhecido');
            Logger(`POST - MURAL - new`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao criar Mural', error: 'Erro desconhecido' });
        }
    }
});

routerMural.get('/id/:id', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const steps = await prisma.mural.findFirst({
            where: {
                id: id
            }
        })

        if (steps) {
            Logger(`GET - MURAL - id/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - MURAL - id/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Mural not found!' });
        }
    } catch (error) {
        Logger(`GET - MURAL - id/${id}`, `Error fetching requested Mural. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Mural.' });
    }
});

routerMural.get('/identifier/:identifier', validateJWT, async (req, res) => {
    const identifier = req.params.identifier;
    try {
        const steps = await prisma.mural.findFirst({
            where: {
                identificador: identifier
            }
        })

        if (steps) {
            Logger(`GET - MURAL - identifier/${identifier}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - MURAL - identifier/${identifier}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Mural not found!' });
        }
    } catch (error) {
        Logger(`GET - MURAL - identifier/${identifier}`, `Error fetching requested Mural. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Mural.' });
    }
});

routerMural.get('/all', validateJWT, async (req, res) => {
    try {
        const steps = await prisma.mural.findMany()

        if (steps) {
            Logger(`GET - MURAL - all`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - MURAL - all`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Mural not found!' });
        }
    } catch (error) {
        Logger(`GET - MURAL - all`, `Error fetching requested Fields. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Mural.' });
    }
});





