import { Router } from 'express';
import { validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';
import { codeGenerator, numberGenerator } from '../../middlewares/randomCodeGenerator';

export const routerRequests = Router()

routerRequests.get('/', (req, res) => res.send('API de Solicitações'))

routerRequests.post('/new', validateJWT, async (req, res) => {
    let { titulo, descricao, aluno, professor_avaliador = null, tipo_solicitacao } = req.body;
    let numero = await Number(numberGenerator(8));
    let identificador = await codeGenerator(60);

    try {
        const field = await prisma.processo.create({
            data: {
                titulo,
                descricao,
                aluno,
                tipo_solicitacao,
                professor_avaliador : professor_avaliador ?? null,
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
    const { identificador, professor } = req.body;

    try {
        const field = await prisma.processo.update({
            where: {
                identificador
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
    const { identificador, servidor } = req.body;

    try {
        const field = await prisma.processo.update({
            where: {
                identificador
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


routerRequests.get('/process-id/:id', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const steps = await prisma.processo.findFirst({
            where: {
                id: id
            }
        })

        if (steps) {
            Logger(`GET - REQUESTS - /process-id/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - /process-id/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /process-id/${id}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.get('/process-number/:number', validateJWT, async (req, res) => {
    const numero = Number(req.params.number);
    try {
        const steps = await prisma.processo.findFirst({
            where: {
                numero: numero
            }
        })

        if (steps) {
            Logger(`GET - REQUESTS - /process-number/${numero}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - /process-number/${numero}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /process-number/${numero}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.get('/process-identificador/:identificador', validateJWT, async (req, res) => {
    const identificador = req.params.identificador;
    try {
        const steps = await prisma.processo.findFirst({
            where: {
                identificador: identificador
            }
        })

        if (steps) {
            Logger(`GET - REQUESTS - process-identificador/${identificador}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - process-identificador/${identificador}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - process-identificador/${identificador}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.get('/processes-student/:student', validateJWT, async (req, res) => {
    const aluno = Number(req.params.student);
    try {
        const steps = await prisma.processo.findFirst({
            where: {
                aluno: aluno
            }
        })

        if (steps) {
            Logger(`GET - REQUESTS - /processes-student/${aluno}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - /processes-student/${aluno}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /processes-student/${aluno}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.get('/processes-student-open/:student', validateJWT, async (req, res) => {
    const aluno = Number(req.params.student);
    try {
        const steps = await prisma.processo.findFirst({
            where: {
                aluno: aluno, 
                status: 1
            }
        })

        if (steps) {
            Logger(`GET - REQUESTS - /processes-student-open/${aluno}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - /processes-student-open/${aluno}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /processes-student-open/${aluno}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.get('/processes-professor/:professor', validateJWT, async (req, res) => {
    const professor = Number(req.params.professor);
    try {
        const steps = await prisma.processo.findFirst({
            where: {
                professor_avaliador: professor
            }
        })

        if (steps) {
            Logger(`GET - REQUESTS - /processes-professor/${professor}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - /processes-professor/${professor}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /processes-professor/${professor}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.get('/processes-professor-open/:professor', validateJWT, async (req, res) => {
    const professor = Number(req.params.professor);
    try {
        const steps = await prisma.processo.findFirst({
            where: {
                professor_avaliador: professor, 
                status: 1
            }
        })

        if (steps) {
            Logger(`GET - REQUESTS - /processes-professor-open/${professor}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - /processes-professor-open/${professor}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /processes-professor-open/${professor}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.get('/processes-servidor/:servidor', validateJWT, async (req, res) => {
    const servidor = Number(req.params.servidor);
    try {
        const steps = await prisma.processo.findFirst({
            where: {
                servidor_responsavel: servidor
            }
        })

        if (steps) {
            Logger(`GET - REQUESTS - /processes-servidor/${servidor}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - /processes-servidor/${servidor}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /processes-servidor/${servidor}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.get('/processes-servidor-open/:servidor', validateJWT, async (req, res) => {
    const servidor = Number(req.params.servidor);
    try {
        const steps = await prisma.processo.findFirst({
            where: {
                servidor_responsavel: servidor, 
                status: 1
            }
        })

        if (steps) {
            Logger(`GET - REQUESTS - /processes-servidor-open/${servidor}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - /processes-servidor-open/${servidor}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /processes-servidor-open/${servidor}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.get('/res-servidor-open/:servidor', validateJWT, async (req, res) => {
    const servidor = Number(req.params.servidor);
    try {
        const steps = await prisma.processo.findFirst({
            where: {
                servidor_responsavel: servidor, 
                status: 1
            }
        })

        if (steps) {
            Logger(`GET - REQUESTS - /processes-servidor-open/${servidor}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - /processes-servidor-open/${servidor}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /processes-servidor-open/${servidor}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.get('/all-without-server', validateJWT, async (req, res) => {
    try {
        const steps = await prisma.processo.findFirst({
            where: {
                servidor_responsavel: null, 
            }
        })

        if (steps) {
            Logger(`GET - REQUESTS - /all-without-server`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - /all-without-server`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /all-without-server`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.get('/all-without-professor', validateJWT, async (req, res) => {
    try {
        const steps = await prisma.processo.findFirst({
            where: {
                professor_avaliador: null, 
            }
        })

        if (steps) {
            Logger(`GET - REQUESTS - /all-without-professor`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - /all-without-professor`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /all-without-professor`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});


routerRequests.post('/reply-proccess', validateJWT, async (req, res) => {
    let { processo, campo, usuario, resposta } = req.body;

    try {
        const field = await prisma.respostas_processo.create({
            data: {
              processo,
              campo,
              resposta,
              usuario
            }
        })
        Logger(`POST - REQUESTS - reply-proccess`, JSON.stringify(field), "success");
        res.status(200).send(JSON.stringify(field));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar resposta:', error.message);
            Logger(`POST - REQUESTS - reply-proccess`, error.message, "error");
            res.status(500).send({ message: 'Erro ao criar resposta', error: error.message });
        } else {
            console.error('Erro ao criar resposta: Erro desconhecido');
            Logger(`POST - REQUESTS - reply-proccess`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao criar resposta', error: 'Erro desconhecido' });
        }
    }
});


routerRequests.get('/replies/:processo', validateJWT, async (req, res) => {
    const processo = Number(req.params.processo);
    try {
        const steps = await prisma.respostas_processo.findFirst({
            where: {
                processo: processo, 
            }
        })

        if (steps) {
            Logger(`GET - REQUESTS - /replies/${processo}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - /replies/${processo}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /replies/${processo}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.delete('/reply/:id', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const steps = await prisma.respostas_processo.delete({
            where: {
                id: id, 
            }
        })

        if (steps) {
            Logger(`DELETE - REQUESTS - /reply/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`DELETE - REQUESTS - /reply/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`DELETE - REQUESTS - /reply/${id}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.delete('/clear-replies-process/:processo', validateJWT, async (req, res) => {
    const processo = Number(req.params.processo);
    try {
        const steps = await prisma.respostas_processo.deleteMany({
            where: {
                processo: processo, 
            }
        })

        if (steps) {
            Logger(`DELETE - REQUESTS - /clear-replies-process/${processo}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`DELETE - REQUESTS - /clear-replies-process/${processo}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`DELETE - REQUESTS - /clear-replies-process/${processo}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});