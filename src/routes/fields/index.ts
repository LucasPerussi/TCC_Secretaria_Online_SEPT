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
                tipo: Number(tipo),
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
                id: Number(tipo)
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
                tipo: Number(tipo),
                tipo_processo: Number(tipo_processo)
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

routerFields.post('/new-type-for-process', validateJWT, async (req, res) => {
    const { nome, label, obrigatorio, tipo_dado, padrao, processo } = req.body;

    try {
        // Inicia uma transação interativa
        const result = await prisma.$transaction(async (prisma) => {
            // Primeiro, cria o novo campo em tipos_campos
            const newField = await prisma.tipos_campos.create({
                data: {
                    nome,
                    etiqueta: label,
                    obrigatorio: Number(obrigatorio),
                    tipo_dado: Number(tipo_dado),
                    campo_padrao: 0
                }
            });

            // Em seguida, cria o registro em campos_solicitacao usando o id do newField
            const proccessField = await prisma.campos_solicitacao.create({
                data: {
                    nome: newField.nome,
                    nome_exibicao: newField.etiqueta,
                    tipo: newField.id, // Aqui usamos o id do newField
                    tipo_processo: Number(processo)
                }
            });

            // Retorna os dados para uso fora da transação
            return { newField, proccessField };
        });

        // Log de sucesso para ambas as operações
        Logger(`POST - FIELDS - new-type-for-process`, JSON.stringify(result.newField), "success");
        Logger(`POST - FIELDS - new-type-for-process`, JSON.stringify(result.proccessField), "success");

        // Resposta bem-sucedida com os dados criados
        return res.status(201).json({
            message: 'Campo personalizado cadastrado com sucesso!',
            data: result
        });

    } catch (error) {
        // Verifica se o erro é uma instância de Error
        if (error instanceof Error) {
            console.error('Erro ao criar campo personalizado:', error.message);
            Logger(`POST - FIELDS - new-type-for-process`, error.message, "error");
            return res.status(500).json({ message: 'Erro ao criar campo personalizado', error: error.message });
        } else {
            console.error('Erro desconhecido ao criar campo personalizado');
            Logger(`POST - FIELDS - new-type-for-process`, "Erro desconhecido", "error");
            return res.status(500).json({ message: 'Erro desconhecido ao criar campo personalizado' });
        }
    }
});

routerFields.delete('/remove-link-field-to-request/:field/:processo', validateJWT, async (req, res) => {
    const field = Number(req.params.field);
    const processo = Number(req.params.processo);

    try {
        const removeField = await prisma.campos_solicitacao.deleteMany({
            where: {
                tipo: field,
                tipo_processo: processo,
            }
        });

        Logger(`POST - FIELDS - remove-link-field-to-request`, JSON.stringify(removeField), "success");
        res.status(200).send(JSON.stringify(removeField));
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao remover campo de solicitação:', error.message);
            Logger(`POST - FIELDS - remove-link-field-to-request`, error.message, "error");
            res.status(500).send({ message: 'Erro ao remover campo de solicitação', error: error.message });
        } else {
            console.error('Erro ao remover campo de solicitação: Erro desconhecido');
            Logger(`POST - FIELDS - remove-link-field-to-request`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao remover campo de solicitação', error: 'Erro desconhecido' });
        }
    }
});

// routerFields.delete('/remove-field/:field/', validateJWT, async (req, res) => {
//     const field = Number(req.params.field);

//     try {
//         const removeField = await prisma.campos_solicitacao.deleteMany({
//             where: {
//                 id: field,
//             }
//         });

//         Logger(`POST - FIELDS - remove-field`, JSON.stringify(removeField), "success");
//         res.status(200).send(JSON.stringify(removeField));
//     } catch (error) {
//         if (error instanceof Error) {
//             console.error('Erro ao remover campo pelo id:', error.message);
//             Logger(`POST - FIELDS - remove-field`, error.message, "error");
//             res.status(500).send({ message: 'Erro ao remover campo pelo id', error: error.message });
//         } else {
//             console.error('Erro ao remover campo pelo id: Erro desconhecido');
//             Logger(`POST - FIELDS - remove-field`, "Erro desconhecido", "error");
//             res.status(500).send({ message: 'Erro ao remover campo pelo id', error: 'Erro desconhecido' });
//         }
//     }
// });


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




