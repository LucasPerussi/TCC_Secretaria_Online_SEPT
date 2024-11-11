import { Router } from 'express';
import { validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';
import { codeGenerator, numberGenerator } from '../../middlewares/randomCodeGenerator';

export const routerRequests = Router()

routerRequests.get('/', (req, res) => res.send('API de Solicitações'))

routerRequests.post('/new', validateJWT, async (req, res) => {
    let { titulo, descricao, aluno, servidor_responsavel, professor_avaliador, tipo_solicitacao } = req.body;
    let numero = await Number(numberGenerator(8));
    let identificador = await codeGenerator(60);

    try {
        const field = await prisma.processo.create({
            data: {
                titulo,
                descricao,
                aluno,
                tipo_solicitacao,
                data_abertura: '',
                identificador, 
                numero,
                etapa_atual: 1
            }
        })
        Logger(`POST - REQUESTS - new`, JSON.stringify(field), "success");
        res.status(200).send(JSON.stringify(field));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar estágio:', error.message);
            Logger(`POST - REQUESTS - new`, error.message, "error");
            res.status(500).send({ message: 'Erro ao criar estágio', error: error.message });
        } else {
            console.error('Erro ao criar estágio: Erro desconhecido');
            Logger(`POST - REQUESTS - new`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao criar estágio', error: 'Erro desconhecido' });
        }
    }
});

routerRequests.patch('/add-teacher', validateJWT, async (req, res) => {
    const { id, professor } = req.body;

    try {
        const field = await prisma.processo.update({
            where: {
                id
            },
            data: {
                professor_avaliador: professor,
            }
        });
        
        Logger(`PATCH - REQUESTS - add-teacher`, JSON.stringify(field), "success");
        res.status(200).json(field); 
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao atualizar professor avaliador:', error.message);
            Logger(`PATCH - REQUESTS - add-teacher`, error.message, "error");
            res.status(500).json({ message: 'Erro ao atualizar professor avaliador', error: error.message });
        } else {
            console.error('Erro ao atualizar professor avaliador: Erro desconhecido');
            Logger(`PATCH - REQUESTS - add-teacher`, "Erro desconhecido", "error");
            res.status(500).json({ message: 'Erro ao atualizar professor avaliador', error: 'Erro desconhecido' });
        }
    }
});

routerRequests.patch('/add-server', validateJWT, async (req, res) => {
    const { id, servidor } = req.body;

    try {
        const field = await prisma.processo.update({
            where: {
                id
            },
            data: {
                servidor_responsavel: servidor,
            }
        });
        
        Logger(`PATCH - REQUESTS - add-server`, JSON.stringify(field), "success");
        res.status(200).json(field); 
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao atualizar server avaliador:', error.message);
            Logger(`PATCH - REQUESTS - add-server`, error.message, "error");
            res.status(500).json({ message: 'Erro ao atualizar professor avaliador', error: error.message });
        } else {
            console.error('Erro ao atualizar server avaliador: Erro desconhecido');
            Logger(`PATCH - REQUESTS - add-server`, "Erro desconhecido", "error");
            res.status(500).json({ message: 'Erro ao atualizar server avaliador', error: 'Erro desconhecido' });
        }
    }
});


routerRequests.get('/all', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const steps = await prisma.processo.findFirst({
            where: {
                id: id
            }
        })

        if (steps) {
            Logger(`GET - REQUESTS - all/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - all/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - all/${id}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});