import { Router } from 'express';
import { validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';
import { ProcessoEtapaInfo } from '../../enum/proccessStages';

export const routerSteps = Router()

routerSteps.get('/', (req, res) => res.send('API de Enum de Etapas'))

routerSteps.post('/new', validateJWT, async (req, res) => {
    let { nome, label, padrao, estimativaHoras, cor } = req.body;

    try {
        const step = await prisma.enum_etapas.create({
            data: {
                nome,
                label,
                estimativaHoras: Number(estimativaHoras),
                cor,
                padrao: Number(padrao)
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


routerSteps.delete('/remove-link-stage-to-request/:stage/:processo', validateJWT, async (req, res) => {
    const stage = Number(req.params.stage);
    const processo = Number(req.params.processo);

    try {
        const removeField = await prisma.etapas_processo.deleteMany({
            where: {
                id: stage,
                proccessTypeId: processo,
            }
        });

        Logger(`POST - FIELDS - remove-link-stage-to-request/${stage}/${processo}`, JSON.stringify(removeField), "success");
        res.status(200).send(JSON.stringify(removeField));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao remover campo de solicitação:', error.message);
            Logger(`POST - FIELDS - remove-link-stage-to-request/${stage}/${processo}`, error.message, "error");
            res.status(500).send({ message: 'Erro ao remover campo de solicitação', error: error.message });
        } else {
            console.error('Erro ao remover campo de solicitação: Erro desconhecido');
            Logger(`POST - FIELDS - remove-link-stage-to-request/${stage}/${processo}`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao remover campo de solicitação', error: 'Erro desconhecido' });
        }
    }
});


routerSteps.post('/new-default', validateJWT, async (req, res) => {
    let { nome, label, estimativaHoras, cor } = req.body;

    try {
        const step = await prisma.enum_etapas.create({
            data: {
                nome,
                label,
                estimativaHoras: Number(estimativaHoras),
                cor,
                padrao: 1
            }
        })
        Logger(`POST - STEPS - new-default`, JSON.stringify(step), "success");
        res.status(200).send(JSON.stringify(step));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar estágio:', error.message);
            Logger(`POST - STEPS - new-default`, error.message, "error");
            res.status(500).send({ message: 'Erro ao criar estágio', error: error.message });
        } else {
            console.error('Erro ao criar estágio: Erro desconhecido');
            Logger(`POST - STEPS - new-default`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao criar estágio', error: 'Erro desconhecido' });
        }
    }
});

routerSteps.post('/new-customized', validateJWT, async (req, res) => {
    let { nome, label, estimativaHoras, cor } = req.body;

    try {
        const step = await prisma.enum_etapas.create({
            data: {
                nome,
                label,
                estimativaHoras: Number(estimativaHoras),
                cor,
                padrao: 0
            }
        })
        Logger(`POST - STEPS - new-customized`, JSON.stringify(step), "success");
        res.status(200).send(JSON.stringify(step));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar stage:', error.message);
            Logger(`POST - STEPS - new-customized`, error.message, "error");
            res.status(500).send({ message: 'Erro ao criar stage', error: error.message });
        } else {
            console.error('Erro ao criar stage: Erro desconhecido');
            Logger(`POST - STEPS - new-customized`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao criar stage', error: 'Erro desconhecido' });
        }
    }
});

routerSteps.post('/link-step-to-proccess', validateJWT, async (req, res) => {
    let { tipo, obrigatorio, proccess } = req.body;

    try {
        const step = await prisma.etapas_processo.create({
            data: {
                tipo: Number(tipo),
                obrigatorio: Number(obrigatorio),
                proccessTypeId: Number(proccess)
            }
        })
        Logger(`POST - STEPS - /link-step-to-proccess`, JSON.stringify(step), "success");
        res.status(200).send(JSON.stringify(step));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar estágio:', error.message);
            Logger(`POST - STEPS - /link-step-to-proccess`, error.message, "error");
            res.status(500).send({ message: 'Erro ao criar estágio', error: error.message });
        } else {
            console.error('Erro ao criar estágio: Erro desconhecido');
            Logger(`POST - STEPS - /link-step-to-proccess`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao criar estágio', error: 'Erro desconhecido' });
        }
    }
});

routerSteps.get('/link-step-to-proccess/:proccess', validateJWT, async (req, res) => {
    const id = Number(req.params.proccess);
    try {
        const steps = await prisma.etapas_processo.findMany({
            where: {
                proccessTypeId: Number(id)
            }
        })

        if (steps) {
            Logger(`GET - STEPS - link-step-to-proccess/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - STEPS - link-step-to-proccess/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Step not found!' });
        }
    } catch (error) {
        Logger(`GET - STEPS - link-step-to-proccess/${id}`, `Error fetching requested Step. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Step.' });
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

routerSteps.get('/all-customized', validateJWT, async (req, res) => {
    try {
        const steps = await prisma.enum_etapas.findMany({
            where: {
                padrao : 0
            }
        })

        if (steps) {
            Logger(`GET - STEPS - all-customized`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - STEPS - all-customized`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Steps not found!' });
        }
    } catch (error) {
        Logger(`GET - STEPS - all-customized`, `Error fetching requested Steps. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Step.' });
    }
});

routerSteps.get('/stages', validateJWT, async (req, res) => {
    res.json(ProcessoEtapaInfo);
});







