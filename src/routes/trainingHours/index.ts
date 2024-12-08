import { Router } from 'express';
import { validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';
import { AtividadeFormativaTypeInfo, AtividadeFormativaTypes } from '../../enum/formativeHoursTypes';

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
                horas_solicitadas: Number(horas_solicitadas),
                data_evento: new Date(data_evento),
                descricao,
                tipo: Number(tipo),
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


routerTrainingHours.get('/percentual-por-tipo/:aluno', validateJWT, async (req, res) => {
    const aluno = Number(req.params.aluno);

    try {
        // Validação do ID do aluno
        if (isNaN(aluno)) {
            Logger(`GET - PERCENTUAL-POR-TIPO - by-student/${aluno}`, `400 - ID de aluno inválido`, 'error');
            return res.status(400).json({ error: true, message: 'ID de aluno inválido.' });
        }

        // Contagem total de registros para o aluno
        const totalRecords = await prisma.horas_formativas.count({
            where: { aluno: aluno },
        });

        if (totalRecords === 0) {
            Logger(`GET - PERCENTUAL-POR-TIPO - by-student/${aluno}`, `404 - Nenhum registro encontrado`, 'error');
            return res.status(404).json({ error: true, message: 'Nenhum registro encontrado para o aluno especificado.' });
        }

        // Agrupar registros por tipo e contar
        const groupedData = await prisma.horas_formativas.groupBy({
            by: ['tipo'],
            where: { aluno: aluno },
            _count: {
                tipo: true,
            },
        });

        // Construir o response com os percentuais
        const response = Object.values(AtividadeFormativaTypes).map(tipoKey => {
            const tipoId = Number(tipoKey);
            const tipoInfo = AtividadeFormativaTypeInfo[tipoKey as AtividadeFormativaTypes];
            const tipoCount = groupedData.find(item => Number(item.tipo) === tipoId)?._count.tipo || 0;
            const percentual = ((tipoCount / totalRecords) * 100).toFixed(2); // Percentual com 2 casas decimais

            return {
                id: tipoId,
                nome: tipoInfo.nome,
                percentual: Number(percentual),
            };
        });

        Logger(`GET - PERCENTUAL-POR-TIPO - by-student/${aluno}`, `200 - Percentuais calculados com sucesso`, 'success');
        return res.status(200).json(response);

    } catch (error) {
        if (error instanceof Error) {
            Logger(`GET - PERCENTUAL-POR-TIPO - by-student/${aluno}`, `500 - Erro interno: ${error.message}`, 'error');
            return res.status(500).json({ message: 'Erro ao calcular os percentuais dos tipos de registros.', error: error.message });
        } else {
            Logger(`GET - PERCENTUAL-POR-TIPO - by-student/${aluno}`, `500 - Erro desconhecido`, 'error');
            return res.status(500).json({ message: 'Erro desconhecido ao calcular os percentuais dos tipos de registros.', error: 'Erro desconhecido' });
        }
    }
});

routerTrainingHours.get('/horas-aluno/:aluno', validateJWT, async (req, res) => {
    const aluno = Number(req.params.aluno);

    try {
        // Buscar aluno pelo ID
        const student = await prisma.usuario.findFirst({
            where: { id: aluno },
        });

        if (!student) {
            Logger(`GET - HORAS-ALUNO - by-student/${aluno}`, `404 - Aluno não encontrado`, 'error');
            return res.status(404).json({ error: true, message: 'Aluno não encontrado!' });
        }

        // Buscar curso associado ao aluno
        const course = await prisma.curso.findFirst({
            where: { id: Number(student.curso) },
        });

        if (!course) {
            Logger(`GET - HORAS-ALUNO - by-student/${aluno}`, `404 - Curso não encontrado`, 'error');
            return res.status(404).json({ error: true, message: 'Curso não encontrado para o aluno!' });
        }

        const horasCurso = course.horas_formativas ?? 0; // Total de horas solicitadas pelo curso

        // Buscar registros de horas formativas para o aluno
        const recordData = await prisma.horas_formativas.findMany({
            where: { aluno: aluno },
        });

        // Calcular total de horas solicitadas e concedidas
        const totalHorasSolicitadas = recordData.reduce((acc, record) => acc + (record.horas_solicitadas || 0), 0);
        const totalHorasConcedidas = recordData.reduce((acc, record) => acc + (record.horas_concedidas || 0), 0);

        // Construir resposta
        const response = {
            aluno: {
                id: student.id,
                nome: student.nome,
            },
            curso: {
                id: course.id,
                nome: course.nome,
                totalHorasCurso: horasCurso,
            },
            horas: {
                solicitadas: totalHorasSolicitadas,
                concedidas: totalHorasConcedidas,
                restante: Math.max(horasCurso - totalHorasConcedidas, 0),
                percentualConcluido: ((totalHorasConcedidas / horasCurso) * 100).toFixed(2), // Em porcentagem
            },
            registros: recordData.map(record => ({
                id: record.id,
                descricao: record.descricao,
                horasSolicitadas: record.horas_solicitadas,
                horasConcedidas: record.horas_concedidas,
                dataEnvio: record.data_envio,
                dataEvento: record.data_evento,
                statusAprovacao: record.status_aprovacao,
            })),
        };

        Logger(`GET - HORAS-ALUNO - by-student/${aluno}`, `200 - Relação de horas calculada com sucesso`, 'success');
        return res.status(200).json(response);

    } catch (error) {
        Logger(`GET - HORAS-ALUNO - by-student/${aluno}`, `500 - Erro interno: ${error}`, 'error');
        return res.status(500).json({ message: 'Erro ao recuperar a relação de horas.', error: error });
    }
});


routerTrainingHours.get('/types/:id', validateJWT, (req, res) => {
    const { id } = req.params;

    // Verifica se o ID é um valor válido do enum
    if (!Object.values(AtividadeFormativaTypes).includes(id as AtividadeFormativaTypes)) {
        return res.status(400).json({ error: 'ID inválido fornecido' });
    }

    const typeInfo = AtividadeFormativaTypeInfo[id as AtividadeFormativaTypes];

    if (typeInfo) {
        res.json(typeInfo);
    } else {
        res.status(404).json({ error: 'Tipo de hora formativa não encontrado' });
    }
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
