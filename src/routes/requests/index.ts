import { Router } from 'express';
import { extractUserDataFromToken, validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Prisma } from '@prisma/client';
import { Logger } from '../../middlewares/logger';
import { codeGenerator, numberGenerator } from '../../middlewares/randomCodeGenerator';
import { CompanyTypeInfo } from '../../enum/empresas';

export const routerRequests = Router()

routerRequests.get('/', (req, res) => res.send('API de Solicitações'))


routerRequests.post('/new',  validateJWT, async (req, res) => {
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
          aluno:  Number(aluno), // Conecta ao aluno existente
          tipo_solicitacao: Number(tipo_solicitacao),
          data_abertura: new Date(),
          identificador,
          numero,
          etapa_atual: etapaInicialId,
        },
      });
  
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
routerRequests.post('/new-question-reply', validateJWT, async (req, res) => {
    const { campo, resposta, processo, usuario } = req.body; // Certifique-se de que o nome seja 'processo' e não 'process'

    // Validação básica dos campos
    if (
        campo === undefined ||
        typeof resposta !== 'string' ||
        processo === undefined ||
        usuario === undefined
    ) {
        return res.status(400).json({ message: 'Dados de entrada inválidos' });
    }

    const campoNumber = Number(campo);
    const processoNumber = Number(processo);
    const usuarioNumber = Number(usuario);

   
    if (isNaN(campoNumber) || isNaN(processoNumber) || isNaN(usuarioNumber)) {
        return res.status(400).json({ message: 'Campos "campo", "processo" e "usuario" devem ser números válidos' });
    }

    try {
        const field = await prisma.respostas_processo.create({
            data: {
                campo: campoNumber,
                resposta,
                processo: processoNumber, // Atribuindo diretamente o ID
                usuario: usuarioNumber    // Atribuindo diretamente o ID
            }
        });

        Logger(`POST - REQUESTS - new-question-reply`, JSON.stringify(field), "success");
        res.status(200).json(field);
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao atualizar server avaliador:', error.message);
            Logger(`POST - REQUESTS - new-question-reply`, error.message, "error");
            res.status(500).json({ message: 'Erro ao atualizar professor avaliador', error: error.message });
        } else {
            console.error('Erro ao atualizar server avaliador: Erro desconhecido');
            Logger(`POST - REQUESTS - new-question-reply`, "Erro desconhecido", "error");
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

