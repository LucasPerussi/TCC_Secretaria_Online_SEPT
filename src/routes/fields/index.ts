import { Router } from 'express';
import { validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';
import { InputTypeInfo } from '../../enum/input';

export const routerFields = Router()

routerFields.get('/', (req, res) => res.send('API de Campos'))

routerFields.post('/new-type', validateJWT, async (req, res) => {
    let { nome, label, obrigatorio, tipo_dado, padrao } = req.body;

    try {
        const field = await prisma.tipos_campos.create({
            data: {
                nome,
                etiqueta: label,
                obrigatorio: Number(obrigatorio),
                tipo_dado: Number(tipo_dado),
                campo_padrao: Number(padrao)
            }
        })
        Logger(`POST - FIELDS - new-type`, JSON.stringify(field), "success");
        res.status(200).send(JSON.stringify(field));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar estágio:', error.message);
            Logger(`POST - FIELDS - new-type`, error.message, "error");
            res.status(500).send({ message: 'Erro ao criar estágio', error: error.message });
        } else {
            console.error('Erro ao criar estágio: Erro desconhecido');
            Logger(`POST - FIELDS - new-type`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao criar estágio', error: 'Erro desconhecido' });
        }
    }
});

routerFields.delete('/type/:id', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const steps = await prisma.tipos_campos.delete({
            where: {
                id: id
            }
        })

        if (steps) {
            Logger(`DELETE - FIELDS - type/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`DELETE - FIELDS - type/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`DELETE - FIELDS - type/${id}`, `Error DELETING requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error DELETING requested Field type.' });
    }
});

routerFields.get('/field-type-id/:id', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const steps = await prisma.tipos_campos.findFirst({
            where: {
                id: id
            }
        })

        if (steps) {
            Logger(`GET - FIELDS - field-type-id/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - FIELDS - field-type-id/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - FIELDS - field-type-id/${id}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});


routerFields.get('/all-field-types', validateJWT, async (req, res) => {
    try {
        const steps = await prisma.tipos_campos.findMany()

        if (steps) {
            Logger(`GET - FIELDS - all-field-types`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - FIELDS - all-field-types`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Fields not found!' });
        }
    } catch (error) {
        Logger(`GET - FIELDS - all-field-types`, `Error fetching requested Fields. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested fields.' });
    }
});

routerFields.post('/new-option', validateJWT, async (req, res) => {
    let { nome, label, tipo, campo_pai } = req.body;

    try {
        const field = await prisma.opcoes_de_campos.create({
            data: {
                nome,
                label,
                tipo : Number(tipo),
                campo_pai
            }
        })
        Logger(`POST - FIELDS - new-option`, JSON.stringify(field), "success");
        res.status(200).send(JSON.stringify(field));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar opção de campo:', error.message);
            Logger(`POST - FIELDS - new-option`, error.message, "error");
            res.status(500).send({ message: 'Erro ao criar opção de campo', error: error.message });
        } else {
            console.error('Erro ao criar opção de campo: Erro desconhecido');
            Logger(`POST - FIELDS - new-option`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao criar opção de campo', error: 'Erro desconhecido' });
        }
    }
});


routerFields.get('/field-options-by-father/:id', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const steps = await prisma.opcoes_de_campos.findMany({
            where: {
                campo_pai: id
            }
        })

        if (steps) {
            Logger(`GET - FIELDS - field-options-by-father/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - FIELDS - field-options-by-father/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - FIELDS - field-options-by-father/${id}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerFields.get('/all-default-fields', validateJWT, async (req, res) => {
    try {
        const steps = await prisma.tipos_campos.findMany({
            where: {
                campo_padrao: 1
            }
        })

        if (steps) {
            Logger(`GET - FIELDS - all-default-fields`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - FIELDS - all-default-fields`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - FIELDS - all-default-fields`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerFields.post('/link-field-to-request', validateJWT, async (req, res) => {
    const { tipo, tipo_processo } = req.body;

    try {
        const tipoCampo = await prisma.tipos_campos.findUnique({
            where: {
                id: tipo
            },
            select: {
                nome: true,
                etiqueta: true
            }
        });

        if (!tipoCampo) {
            const message = `Tipo com ID ${tipo} não encontrado.`;
            Logger(`POST - FIELDS - new-request-field`, message, "error");
            return res.status(404).send({ message });
        }

        // Criar o campo na tabela campos_solicitacao
        const field = await prisma.campos_solicitacao.create({
            data: {
                nome: tipoCampo.nome,
                nome_exibicao: tipoCampo.etiqueta,
                tipo,
                tipo_processo
            }
        });

        Logger(`POST - FIELDS - new-request-field`, JSON.stringify(field), "success");
        res.status(200).send(JSON.stringify(field));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar campo de solicitação:', error.message);
            Logger(`POST - FIELDS - new-request-field`, error.message, "error");
            res.status(500).send({ message: 'Erro ao criar campo de solicitação', error: error.message });
        } else {
            console.error('Erro ao criar campo de solicitação: Erro desconhecido');
            Logger(`POST - FIELDS - new-request-field`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao criar campo de solicitação', error: 'Erro desconhecido' });
        }
    }
});

routerFields.post('/new-request-field', validateJWT, async (req, res) => {
    let { nome, nome_exibicao, tipo, tipo_processo } = req.body;

    try {
        const field = await prisma.campos_solicitacao.create({
            data: {
                nome,
                nome_exibicao,
                tipo,
                tipo_processo
            }
        })
        Logger(`POST - FIELDS - new-request-field`, JSON.stringify(field), "success");
        res.status(200).send(JSON.stringify(field));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar opção de campo:', error.message);
            Logger(`POST - FIELDS - new-request-field`, error.message, "error");
            res.status(500).send({ message: 'Erro ao criar opção de campo', error: error.message });
        } else {
            console.error('Erro ao criar opção de campo: Erro desconhecido');
            Logger(`POST - FIELDS - new-request-field`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao criar opção de campo', error: 'Erro desconhecido' });
        }
    }
});

routerFields.get('/request-field-by-process-type/:id', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const steps = await prisma.campos_solicitacao.findMany({
            where: {
                tipo_processo: id
            }
        })

        if (steps) {
            Logger(`GET - FIELDS - request-field-by-process-type/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - FIELDS - request-field-by-process-type/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - FIELDS - request-field-by-process-type/${id}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerFields.get('/input-types', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const steps = await prisma.campos_solicitacao.findMany({
            where: {
                tipo_processo: id
            }
        })

        if (steps) {
            Logger(`GET - FIELDS - request-field-by-process-type/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - FIELDS - request-field-by-process-type/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - FIELDS - request-field-by-process-type/${id}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerFields.get('/input-types-enum', validateJWT, async (req, res) => {
    try {
        if (!InputTypeInfo || Object.keys(InputTypeInfo).length === 0) {
            throw new Error('InputTypeInfo is empty or undefined.');
        }

        res.json(InputTypeInfo); // Retorna o objeto JSON
    } catch (error) {
        console.error('Error fetching InputTypeInfo:', JSON.stringify(error));
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});




