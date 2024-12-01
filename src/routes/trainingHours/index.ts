import { Router } from 'express';
import { validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';
import { AtividadeFormativaTypeInfo } from '../../enum/formativeHoursTypes';

interface CreateHours {
    aluno: number;
    data_evento: string;
    horas_solicitadas: number;
    descricao: string;
    tipo: number;
    comprovante: string;
}

// const prisma = new PrismaClient();

export const routerTrainingHours = Router();

routerTrainingHours.get('/', (req, res) => res.send('API de Registro de horas formativas'));

routerTrainingHours.post('/new', validateJWT, async (req, res) => {
    const { aluno, data_evento, horas_solicitadas, descricao, tipo, comprovante }: CreateHours = req.body;

    const data_envio = new Date();

    try {
        const newRecord = await prisma.horas_formativas.create({
            data: {
                aluno,
                data_envio,
                horas_solicitadas,
                data_evento: new Date(data_evento),
                descricao,
                tipo,
                comprovante,
            },
        });
        Logger('POST - HOURS - /new', `200 - New training hours record created: ID ${newRecord.id}`, 'success');
        res.status(200).send({ message: 'Horas formativas criadas com sucesso!', record: newRecord });
    } catch (error) {
        if (error instanceof Error) {
            Logger('POST - HOURS - /new', `500 - Error creating training hours record: ${error.message}`, 'error');
            console.error('Error creating training hours record:', error.message);
            res.status(500).send({ message: 'Erro ao criar horas formativas', error: error.message });
        } else {
            Logger('POST - HOURS - /new', '500 - Unknown error occurred', 'error');
            console.error('Unknown error:', error);
            res.status(500).send({ message: 'Erro ao criar horas formativas', error: 'Unknown error' });
        }
    }
});

routerTrainingHours.delete('/id/:id', validateJWT, async (req, res) => {
    const recordId = Number(req.params.id);
    try {
        const recordData = await prisma.horas_formativas.delete({
            where: { id: recordId },
        });

        if (recordData) {
            Logger(`DELETE - HOURS - id/${recordId}`, `200 - Found and Authorized`, 'success');
            res.status(200).json(recordData);
        } else {
            Logger(`DELETE - HOURS - id/${recordId}`, `404 - Not Found`, 'error');
            res.status(404).send({ error: true, message: 'Registro não encontrado!' });
        }
    } catch (error) {
        if (error instanceof Error) {
            Logger(`DELETE - HOURS - id/${recordId}`, `500 - Error fetching record: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: error.message });
        } else {
            Logger(`DELETE - HOURS - id/${recordId}`, '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: 'Unknown error' });
        }
    }
});

routerTrainingHours.get('/types', validateJWT, async (req, res) => {
    res.json(AtividadeFormativaTypeInfo);
});

routerTrainingHours.get('/id/:id', validateJWT, async (req, res) => {
    const recordId = Number(req.params.id);
    try {
        const recordData = await prisma.horas_formativas.findFirst({
            where: { id: recordId },
        });

        if (recordData) {
            Logger(`GET - HOURS - id/${recordId}`, `200 - Found and Authorized`, 'success');
            res.status(200).json(recordData);
        } else {
            Logger(`GET - HOURS - id/${recordId}`, `404 - Not Found`, 'error');
            res.status(404).send({ error: true, message: 'Registro não encontrado!' });
        }
    } catch (error) {
        if (error instanceof Error) {
            Logger(`GET - HOURS - id/${recordId}`, `500 - Error fetching record: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: error.message });
        } else {
            Logger(`GET - HOURS - id/${recordId}`, '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: 'Unknown error' });
        }
    }
});

routerTrainingHours.get('/by-student/:aluno', validateJWT, async (req, res) => {
    const aluno = Number(req.params.aluno);
    try {
        const recordData = await prisma.horas_formativas.findMany({
            where: { aluno: aluno },
        });

        if (recordData) {
            Logger(`GET - HOURS - by-student/${aluno}`, `200 - Found and Authorized`, 'success');
            res.status(200).json(recordData);
        } else {
            Logger(`GET - HOURS - by-student/${aluno}`, `404 - Not Found`, 'error');
            res.status(404).send({ error: true, message: 'Registro não encontrado!' });
        }
    } catch (error) {
        if (error instanceof Error) {
            Logger(`GET - HOURS - by-student/${aluno}`, `500 - Error fetching record: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: error.message });
        } else {
            Logger(`GET - HOURS - by-student/${aluno}`, '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: 'Unknown error' });
        }
    }
});

routerTrainingHours.get('/all', validateJWT, async (req, res) => {
    try {
        const records = await prisma.horas_formativas.findMany();
        Logger('GET - HOURS - all', `200 - Records fetched successfully`, 'success');
        res.status(200).json(records);
    } catch (error) {
        if (error instanceof Error) {
            Logger('GET - HOURS - all', `500 - Error fetching records: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar os registros.', error: error.message });
        } else {
            Logger('GET - HOURS - all', '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar os registros.', error: 'Unknown error' });
        }
    }
});
