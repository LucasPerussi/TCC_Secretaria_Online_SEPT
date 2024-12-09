import { Router } from 'express';
import { extractUserDataFromToken, validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Prisma } from '@prisma/client';
import { Logger } from '../../middlewares/logger';
import { codeGenerator, numberGenerator } from '../../middlewares/randomCodeGenerator';
import { CompanyTypeInfo } from '../../enum/empresas';
import { Timeline } from '../../middlewares/timeline';
import { TimelineTypes } from '../../enum/timeline';
import { getNomeStatusById, ProcessStatusTypeInfo } from '../../enum/status';
import { getNomeEtapaById } from '../../enum/proccessStages';

export const routerRequests = Router()

routerRequests.get('/', (req, res) => res.send('API de Solicitações'))


routerRequests.post('/new', validateJWT, async (req, res) => {
    const { titulo, descricao, aluno, tipo_solicitacao } = req.body;

    // Validação básica dos campos de entrada
    if (!titulo || !descricao || !aluno || !tipo_solicitacao) {
        Logger('POST - REQUESTS - new', 'Campos de entrada inválidos', 'error');
        return res.status(400).json({ message: 'Campos de entrada inválidos' });
    }

    try {
        const numero = Number(await numberGenerator(8));
        const identificador = await codeGenerator(60);

        // Verifica se o aluno existe
        const alunoExistente = await prisma.usuario.findUnique({
            where: { id: Number(aluno) },
        });

        if (!alunoExistente) {
            Logger('POST - REQUESTS - new', `Aluno com id ${aluno} não encontrado`, 'error');
            return res.status(404).json({ message: `Aluno com id ${aluno} não encontrado` });
        }

        // Busca a etapa inicial com base no tipo_solicitacao
        const etapaInicial = await prisma.etapas_processo.findFirst({
            where: { tipo: Number(tipo_solicitacao) },
        });

        // Define etapaInicialId com base na existência de etapaInicial
        const etapaInicialId = etapaInicial ? Number(etapaInicial.id) : 1;

        // Cria o novo processo
        const novoProcesso = await prisma.processo.create({
            data: {
                titulo,
                descricao,
                aluno: Number(aluno), // Conecta ao aluno existente
                tipo_solicitacao: Number(tipo_solicitacao),
                data_abertura: new Date(),
                identificador,
                numero,
                etapa_atual: etapaInicialId,
            },
        });
        Timeline("Chamado registrado", novoProcesso.id.toString(), "O chamado número " + numero + " foi registrado com sucesso", Number(TimelineTypes.TICKET_OPEN), Number(aluno))

        Logger('POST - REQUESTS - new', JSON.stringify(novoProcesso), 'success');
        return res.status(201).json(novoProcesso);
    } catch (error: unknown) {
        if (error instanceof Error) {
            console.error('Erro ao criar processo:', error.message);
            Logger('POST - REQUESTS - new', error.message, 'error');
            return res.status(500).json({ message: 'Erro ao criar processo', error: error.message });
        } else {
            console.error('Erro ao criar processo: Erro desconhecido');
            Logger('POST - REQUESTS - new', 'Erro desconhecido', 'error');
            return res.status(500).json({ message: 'Erro ao criar processo', error: 'Erro desconhecido' });
        }
    }
});

routerRequests.patch('/add-teacher', validateJWT, async (req, res) => {
    const { identificador, professor } = req.body;

    // Validação dos dados de entrada
    if (!identificador || !professor) {
        return res.status(400).json({ message: 'Identificador e professor são obrigatórios' });
    }

    try {
        const processoExistente = await prisma.processo.findUnique({
            where: {
                id: Number(identificador),
            },
        });

        if (!processoExistente) {
            console.error('Registro não encontrado para atualizar:', identificador);
            Logger(`PATCH - REQUESTS - add-teacher`, `Registro não encontrado: ${identificador}`, "error");
            return res.status(404).json({ message: 'Registro não encontrado' });
        }

        const field = await prisma.processo.update({
            where: {
                id: Number(identificador),
            },
            data: {
                professor_avaliador: Number(professor),
            },
        });
        Timeline("Professor Vinculado", identificador, "Um professor foi notificado para atuar neste chamado", Number(TimelineTypes.NEW_TEACHER), Number(processoExistente.aluno))

        Logger(`PATCH - REQUESTS - add-teacher`, JSON.stringify(field), "success");
        res.status(200).json(field);
    } catch (error) {
        if (error instanceof Prisma.PrismaClientKnownRequestError) {
            if (error.code === 'P2025') { // Registro não encontrado
                console.error('Registro não encontrado para atualizar:', identificador);
                Logger(`PATCH - REQUESTS - add-teacher`, `Registro não encontrado: ${identificador}`, "error");
                return res.status(404).json({ message: 'Registro não encontrado' });
            }
            // Você pode tratar outros códigos de erro do Prisma aqui, se necessário
        }

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

routerRequests.patch('/change-stage', validateJWT, async (req, res) => {
    const { identificador, stage } = req.body;

    try {
        const processoExistente = await prisma.processo.findUnique({
            where: {
                id: Number(identificador),
            },
        });

        if (!processoExistente) {
            console.error('Registro não encontrado para atualizar:', identificador);
            Logger(`PATCH - REQUESTS - change-stage`, `Registro não encontrado: ${identificador}`, "error");
            return res.status(404).json({ message: 'Registro não encontrado' });
        }

        const field = await prisma.processo.update({
            where: {
                identificador
            },
            data: {
                etapa_atual: Number(stage),
            }
        });

        const stageName = getNomeEtapaById(stage);
        Timeline("Novo Estágio do processo: " + stageName, identificador, "Seu chamado está agora no estágio de '" + stageName + "'!", Number(TimelineTypes.NEW_STAGE), Number(processoExistente.aluno))

        Logger(`PATCH - REQUESTS - change-stage`, JSON.stringify(field), "success");
        res.status(200).json(field);
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao atualizar server avaliador:', error.message);
            Logger(`PATCH - REQUESTS - change-stage`, error.message, "error");
            res.status(500).json({ message: 'Erro ao atualizar professor avaliador', error: error.message });
        } else {
            console.error('Erro ao atualizar server avaliador: Erro desconhecido');
            Logger(`PATCH - REQUESTS - change-stage`, "Erro desconhecido", "error");
            res.status(500).json({ message: 'Erro ao atualizar server avaliador', error: 'Erro desconhecido' });
        }
    }
});

routerRequests.post('/close-ticket', validateJWT, async (req, res) => {
    const { identificador, stage, comentario, usuario } = req.body;

    // Validação de entrada
    if (!identificador || !stage || !comentario) {
        Logger(`POST - REQUESTS - close-ticket`, `Parâmetros ausentes: identificador=${identificador}, stage=${stage}, comentario=${comentario}`, "error");
        return res.status(400).json({ message: 'Parâmetros inválidos ou ausentes' });
    }

    try {
        // Verificar se o processo existe
        const processoExistente = await prisma.processo.findUnique({
            where: {
                id: Number(identificador),
            },
        });

        if (!processoExistente) {
            Logger(`POST - REQUESTS - close-ticket`, `Registro não encontrado: ${identificador}`, "error");
            return res.status(404).json({ message: 'Registro não encontrado' });
        }

        // Criar novo comentário
        const novoComentario = await prisma.comentarios.create({
            data: {
                data: new Date(),
                processo: Number(identificador),
                usuario: Number(usuario),
                comentario: comentario.trim(),
            },
        });
        Logger(`POST - REQUESTS - close-ticket`, `Comentário criado: ${JSON.stringify(novoComentario)}`, "success");

        // Atualizar o processo
        const field = await prisma.processo.update({
            where: {
                id: Number(identificador),
            },
            data: {
                etapa_atual: Number(stage),
                status: 10,
            },
        });
        Logger(`POST - REQUESTS - close-ticket`, `Processo atualizado: ${JSON.stringify(field)}`, "success");

        // Atualizar a timeline
        Timeline(
            "Chamado encerrado!",
            identificador,
            "Seu chamado foi encerrado. Se precisar, estamos à disposição!",
            Number(TimelineTypes.TICKET_CLOSED),
            Number(processoExistente.aluno)
        );

        // Resposta de sucesso
        return res.status(200).json({
            message: 'Chamado encerrado com sucesso',
            processo: field,
            comentario: novoComentario,
        });
    } catch (error) {
        // Tratamento de erros
        if (error instanceof Error) {
            Logger(`POST - REQUESTS - close-ticket`, `Erro interno: ${error.message}`, "error");
            return res.status(500).json({
                message: 'Erro interno ao encerrar chamado',
                error: error.message,
            });
        } else {
            Logger(`POST - REQUESTS - close-ticket`, `Erro desconhecido`, "error");
            return res.status(500).json({
                message: 'Erro interno ao encerrar chamado',
                error: 'Erro desconhecido',
            });
        }
    }
});


routerRequests.patch('/change-status', validateJWT, async (req, res) => {
    const { identificador, status } = req.body;

    try {
        const processoExistente = await prisma.processo.findUnique({
            where: {
                id: Number(identificador),
            },
        });

        if (!processoExistente) {
            console.error('Registro não encontrado para atualizar:', identificador);
            Logger(`PATCH - REQUESTS - change-status`, `Registro não encontrado: ${identificador}`, "error");
            return res.status(404).json({ message: 'Registro não encontrado' });
        }
        const field = await prisma.processo.update({
            where: {
                identificador
            },
            data: {
                status: Number(status),
            }
        });

        const statusName = getNomeStatusById(status);
        Timeline("Novo Status do processo: " + statusName, identificador, "O Status atual de seu processo é '" + statusName + "'!", Number(TimelineTypes.NEW_STATUS), Number(processoExistente.aluno))

        Logger(`PATCH - REQUESTS - change-status`, JSON.stringify(field), "success");
        res.status(200).json(field);
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao atualizar server avaliador:', error.message);
            Logger(`PATCH - REQUESTS - change-status`, error.message, "error");
            res.status(500).json({ message: 'Erro ao atualizar professor avaliador', error: error.message });
        } else {
            console.error('Erro ao atualizar server avaliador: Erro desconhecido');
            Logger(`PATCH - REQUESTS - change-status`, "Erro desconhecido", "error");
            res.status(500).json({ message: 'Erro ao atualizar server avaliador', error: 'Erro desconhecido' });
        }
    }
});

routerRequests.patch('/add-server', validateJWT, async (req, res) => {
    const { identificador, servidor } = req.body;

    try {

        const processoExistente = await prisma.processo.findUnique({
            where: {
                id: Number(identificador),
            },
        });

        if (!processoExistente) {
            console.error('Registro não encontrado para atualizar:', identificador);
            Logger(`PATCH - REQUESTS - add-server`, `Registro não encontrado: ${identificador}`, "error");
            return res.status(404).json({ message: 'Registro não encontrado' });
        }

        const field = await prisma.processo.update({
            where: {
                id: Number(identificador),
            },
            data: {
                servidor_responsavel: Number(servidor),
            }
        });
        Timeline("Servidor UFPR Vinculado", identificador, "Um servidor já acolheu sua solicitação", Number(TimelineTypes.NEW_SERVER), Number(processoExistente.aluno))
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

routerRequests.get('/all-status-types', validateJWT, async (req, res) => {
    return res.status(201).json(ProcessStatusTypeInfo);
});

routerRequests.post('/new-question-reply', validateJWT, async (req, res) => {
    const { campo, resposta, processo, usuario } = req.body;

    // Validação Inicial dos Dados de Entrada
    if (
        campo === undefined ||
        typeof resposta !== 'string' ||
        processo === undefined ||
        usuario === undefined
    ) {
        Logger('POST - REQUESTS - new-question-reply', 'Dados de entrada inválidos', 'error');
        return res.status(400).json({ message: 'Dados de entrada inválidos' });
    }

    const campoNumber = Number(campo);
    const processoNumber = Number(processo);
    const usuarioNumber = Number(usuario);

    // Verificação se os campos numéricos são válidos
    if (isNaN(campoNumber) || isNaN(processoNumber) || isNaN(usuarioNumber)) {
        Logger('POST - REQUESTS - new-question-reply', 'Campos "campo", "processo" e "usuario" devem ser números válidos', 'error');
        return res.status(400).json({ message: 'Campos "campo", "processo" e "usuario" devem ser números válidos' });
    }

    Logger('POST - REQUESTS - new-question-reply', `Dados recebidos: campo=${campoNumber}, resposta=${resposta}, processo=${processoNumber}, usuario=${usuarioNumber}`, 'info');

    try {
        // Verificar se o processo existe
        const processoExists = await prisma.processo.findUnique({
            where: { id: processoNumber }
        });

        if (!processoExists) {
            Logger('POST - REQUESTS - new-question-reply', `Processo com ID ${processoNumber} não encontrado.`, 'error');
            return res.status(404).json({ message: 'O processo fornecido não existe.' });
        }

        // Verificar se o usuário existe
        const usuarioExists = await prisma.usuario.findUnique({
            where: { id: usuarioNumber }
        });

        if (!usuarioExists) {
            Logger('POST - REQUESTS - new-question-reply', `Usuário com ID ${usuarioNumber} não encontrado.`, 'error');
            return res.status(404).json({ message: 'O usuário fornecido não existe.' });
        }

        // Verificar se o campo existe
        const campoExists = await prisma.campos_solicitacao.findUnique({
            where: { id: campoNumber }
        });

        if (!campoExists) {
            Logger('POST - REQUESTS - new-question-reply', `Campo com ID ${campoNumber} não encontrado.`, 'error');
            return res.status(404).json({ message: 'O campo fornecido não existe.' });
        }

        // Criar a nova resposta ao processo
        const novaResposta = await prisma.respostas_processo.create({
            data: {
                campo: campoNumber,
                resposta,
                processo: processoNumber,
                usuario: usuarioNumber
            }
        });

        Logger('POST - REQUESTS - new-question-reply', `Resposta criada: ${JSON.stringify(novaResposta)}`, 'success');
        return res.status(201).json(novaResposta);
    } catch (error) {
        // Tratamento de Erros do Prisma
        // if (error.code && error.code.startsWith('P')) { // Erros do Prisma geralmente começam com 'P'
        //     Logger('POST - REQUESTS - new-question-reply', `Erro do Prisma: ${error.message}`, 'error');
        //     return res.status(500).json({ message: 'Erro interno do servidor ao processar a resposta.' });
        // }

        // Outros Erros
        if (error instanceof Error) {
            Logger('POST - REQUESTS - new-question-reply', `Erro desconhecido: ${error.message}`, 'error');
            return res.status(500).json({ message: 'Erro interno do servidor ao processar a resposta.', error: error.message });
        } else {
            Logger('POST - REQUESTS - new-question-reply', 'Erro desconhecido', 'error');
            return res.status(500).json({ message: 'Erro interno do servidor ao processar a resposta.', error: 'Erro desconhecido' });
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
            },
            include: {
                usuario_processo_alunoTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_professor_avaliadorTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_servidor_responsavelTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                tipo_solicitacao_processo_tipo_solicitacaoTotipo_solicitacao: {
                    select: {
                        nome: true,
                        hrs_resolucao: true,
                        hrs_resposta: true
                    },
                }
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

routerRequests.get('/all-responses-process/:identificador', validateJWT, async (req, res) => {
    const identificador = req.params.identificador;
    try {
        const process = await prisma.processo.findFirst({
            where: {
                identificador: identificador
            },
        })
        if (process) {
            try {
                const listResonses = await prisma.respostas_processo.findMany({
                    where: {
                        processo: process.id
                    },
                })
                if (process) {
                    res.status(200).send(JSON.stringify(listResonses));

                } else {
                    Logger(`GET - REQUESTS - all-responses-process/${identificador}`, `404 - Not Found`, "error");
                    res.status(404).send({ error: true, message: 'Field type not found!' });
                }

            } catch (error) {
                Logger(`GET - REQUESTS - all-responses-process/${identificador}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
                res.status(500).json({ message: 'Error fetching requested Field type.' });
            }
        } else {
            Logger(`GET - REQUESTS - all-responses-process/${identificador}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - all-responses-process/${identificador}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.get('/processes-without-server', validateJWT, async (req, res) => {
    const aluno = Number(req.params.student);
    try {
        const steps = await prisma.processo.findMany({
            where: {
                servidor_responsavel: null,
                status: 1
            },
            include: {
                usuario_processo_alunoTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_professor_avaliadorTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_servidor_responsavelTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                tipo_solicitacao_processo_tipo_solicitacaoTotipo_solicitacao: {
                    select: {
                        nome: true,
                    },
                }
            }

        })

        if (steps) {
            Logger(`GET - REQUESTS - /processes-without-server`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - /processes-without-server`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /processes-without-server`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.get('/processes-student/:student', validateJWT, async (req, res) => {
    const aluno = Number(req.params.student);
    try {
        const steps = await prisma.processo.findMany({
            where: {
                aluno: aluno
            },
            include: {
                usuario_processo_alunoTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_professor_avaliadorTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_servidor_responsavelTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                tipo_solicitacao_processo_tipo_solicitacaoTotipo_solicitacao: {
                    select: {
                        nome: true,
                    },
                }
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

routerRequests.get('/all', validateJWT, async (req, res) => {
    try {
        const steps = await prisma.processo.findMany({
            include: {
                usuario_processo_alunoTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_professor_avaliadorTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_servidor_responsavelTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                tipo_solicitacao_processo_tipo_solicitacaoTotipo_solicitacao: {
                    select: {
                        nome: true,
                    },
                }
            }

        })

        if (steps) {
            Logger(`GET - REQUESTS - /all`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - REQUESTS - /all`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Field type not found!' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /all`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Field type.' });
    }
});

routerRequests.get('/processes-student-open/:student', validateJWT, async (req, res) => {
    const aluno = Number(req.params.student);
    try {
        const steps = await prisma.processo.findMany({
            where: {
                aluno: aluno,
                status: 1
            },
            include: {
                usuario_processo_alunoTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_professor_avaliadorTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_servidor_responsavelTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                tipo_solicitacao_processo_tipo_solicitacaoTotipo_solicitacao: {
                    select: {
                        nome: true,
                    },
                }
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
        const steps = await prisma.processo.findMany({
            where: {
                professor_avaliador: professor
            },
            include: {
                usuario_processo_alunoTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_professor_avaliadorTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_servidor_responsavelTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                tipo_solicitacao_processo_tipo_solicitacaoTotipo_solicitacao: {
                    select: {
                        nome: true,
                    },
                }
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
        const steps = await prisma.processo.findMany({
            where: {
                professor_avaliador: professor,
                status: 1
            },
            include: {
                usuario_processo_alunoTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_professor_avaliadorTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_servidor_responsavelTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                tipo_solicitacao_processo_tipo_solicitacaoTotipo_solicitacao: {
                    select: {
                        nome: true,
                    },
                }
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
        const steps = await prisma.processo.findMany({
            where: {
                servidor_responsavel: servidor
            },
            include: {
                usuario_processo_alunoTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_professor_avaliadorTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_servidor_responsavelTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                tipo_solicitacao_processo_tipo_solicitacaoTotipo_solicitacao: {
                    select: {
                        nome: true,
                    },
                }
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
        const steps = await prisma.processo.findMany({
            where: {
                servidor_responsavel: servidor,
                status: 1
            },
            include: {
                usuario_processo_alunoTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_professor_avaliadorTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_servidor_responsavelTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                tipo_solicitacao_processo_tipo_solicitacaoTotipo_solicitacao: {
                    select: {
                        nome: true,
                    },
                }
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
        const steps = await prisma.processo.findMany({
            where: {
                servidor_responsavel: servidor,
                status: 1
            },
            include: {
                usuario_processo_alunoTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_professor_avaliadorTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_servidor_responsavelTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                tipo_solicitacao_processo_tipo_solicitacaoTotipo_solicitacao: {
                    select: {
                        nome: true,
                    },
                }
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
        const steps = await prisma.processo.findMany({
            where: {
                servidor_responsavel: null,
            },
            include: {
                usuario_processo_alunoTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_professor_avaliadorTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_servidor_responsavelTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                tipo_solicitacao_processo_tipo_solicitacaoTotipo_solicitacao: {
                    select: {
                        nome: true,
                    },
                }
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
        const steps = await prisma.processo.findMany({
            where: {
                professor_avaliador: null,
            },
            include: {
                usuario_processo_alunoTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_professor_avaliadorTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_servidor_responsavelTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                tipo_solicitacao_processo_tipo_solicitacaoTotipo_solicitacao: {
                    select: {
                        nome: true,
                    },
                }
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

routerRequests.get('/all-requests-as-teacher', validateJWT, async (req, res) => {
    try {
        const userData = await extractUserDataFromToken(req, res);
        if (!userData) {
            return;
        }

        const steps = await prisma.processo.findMany({
            where: {
                professor_avaliador: userData.id,
            },
            include: {
                usuario_processo_alunoTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_professor_avaliadorTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_servidor_responsavelTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                tipo_solicitacao_processo_tipo_solicitacaoTotipo_solicitacao: {
                    select: {
                        nome: true,
                    },
                }
            },
        });

        if (steps.length > 0) {
            Logger(`GET - REQUESTS - /all-requests-as-teacher`, `200 - Found and Authorized`, "success");
            res.status(200).json(steps);
        } else {
            Logger(`GET - REQUESTS - /all-requests-as-teacher`, `404 - Not Found`, "error");
            res.status(404).json({ error: true, message: 'No process found' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /all-requests-as-teacher`, `Error fetching processes: ${JSON.stringify(error)}`, "error");
        res.status(500).json({ message: 'Error fetching processes.' });
    }
});

routerRequests.get('/all-requests-as-student', validateJWT, async (req, res) => {
    try {
        const userData = await extractUserDataFromToken(req, res);
        if (!userData) {
            return;
        }

        const steps = await prisma.processo.findMany({
            where: {
                aluno: userData.id,
            },
            include: {
                usuario_processo_alunoTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_professor_avaliadorTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                usuario_processo_servidor_responsavelTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
                tipo_solicitacao_processo_tipo_solicitacaoTotipo_solicitacao: {
                    select: {
                        nome: true,
                    },
                }
            },
        });

        if (steps.length > 0) {
            Logger(`GET - REQUESTS - /all-requests-as-student`, `200 - Found and Authorized`, "success");
            res.status(200).json(steps);
        } else {
            Logger(`GET - REQUESTS - /all-requests-as-student`, `404 - Not Found`, "error");
            res.status(404).json({ error: true, message: 'No process found' });
        }
    } catch (error) {
        Logger(`GET - REQUESTS - /all-requests-as-student`, `Error fetching processes: ${JSON.stringify(error)}`, "error");
        res.status(500).json({ message: 'Error fetching processes.' });
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

