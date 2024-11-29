import { Router } from 'express';
import { validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';
import { codeGenerator, numberGenerator } from '../../middlewares/randomCodeGenerator';

export const routerComments = Router()

routerComments.get('/', (req, res) => res.send('API de Solicitações'))

routerComments.post('/new', validateJWT, async (req, res) => {
    let { processo, usuario, comentario } = req.body;
    try {
        const field = await prisma.comentarios.create({
            data: {
                data: new Date(),
                processo,
                usuario,
                comentario
            }
        })
        Logger(`POST - COMENTARIOS - new`, JSON.stringify(field), "success");
        res.status(200).send(JSON.stringify(field));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar comentario:', error.message);
            Logger(`POST - COMENTARIOS - new`, error.message, "error");
            res.status(500).send({ message: 'Erro ao criar comentario', error: error.message });
        } else {
            console.error('Erro ao criar comentario: Erro desconhecido');
            Logger(`POST - COMENTARIOS - new`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao criar comentario', error: 'Erro desconhecido' });
        }
    }
});

routerComments.delete('/:id', validateJWT, async (req, res) => {

    const processo = Number(req.params.id);
    try {
        const field = await prisma.comentarios.delete({
           where: {
            id: processo
           }
        })
        Logger(`DELETE - COMENTARIOS - ID ${processo}`, JSON.stringify(field), "success");
        res.status(200).send(JSON.stringify(field));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar comentario:', error.message);
            Logger(`DELETE - COMENTARIOS - ID ${processo}`, error.message, "error");
            res.status(500).send({ message: 'Erro ao criar comentario', error: error.message });
        } else {
            console.error('Erro ao criar comentario: Erro desconhecido');
            Logger(`DELETE - COMENTARIOS - ID ${processo}`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao criar comentario', error: 'Erro desconhecido' });
        }
    }
});

routerComments.get('/all-from-proccess/:processo', validateJWT, async (req, res) => {
    const processo = Number(req.params.processo);
    try {
        const steps = await prisma.comentarios.findFirst({
            where: {
                processo: processo, 
            }
        })

        if (steps) {
            Logger(`GET - COMENTARIOS - /all-from-proccess/${processo}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - COMENTARIOS - /all-from-proccess/${processo}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Proccess type not found!' });
        }
    } catch (error) {
        Logger(`GET - COMENTARIOS - /all-from-proccess/${processo}`, `Error fetching requested Proccess type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Proccess type.' });
    }
});

