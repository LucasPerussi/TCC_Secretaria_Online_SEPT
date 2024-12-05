import { Router } from 'express';
import { validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';
import { codeGenerator, numberGenerator } from '../../middlewares/randomCodeGenerator';
import { Timeline } from '../../middlewares/timeline';
import { TimelineTypes } from '../../enum/timeline';

export const routerComments = Router()

routerComments.get('/', (req, res) => res.send('API de Solicitações'))

routerComments.post('/new', validateJWT, async (req, res) => {
    const { processo, usuario, comentario } = req.body;

    // Validação básica dos dados recebidos
    if (!processo || !usuario || !comentario) {
        return res.status(400).json({ message: 'Dados incompletos fornecidos.' });
    }

    try {
        const novoComentario = await prisma.comentarios.create({
            data: {
                data: new Date(),
                processo: Number(processo),
                usuario: Number(usuario),
                comentario: comentario.trim(),
            },
            include: {
                usuario_comentarios_usuarioTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
            },
        });
        
        Timeline("Novo comentário", processo, "Um novo comentário foi registrado em seu chamado!", Number(TimelineTypes.NEW_COMMENT), Number(usuario))
        // Log de sucesso
        Logger(`POST - COMENTARIOS - new`, JSON.stringify(novoComentario), "success");

        // Retorna o comentário criado com os dados do usuário incluídos
        res.status(201).json(novoComentario);
    } catch (error) {
        // Tratamento de erros
        if (error instanceof Error) {
            console.error('Erro ao criar comentário:', error.message);
            Logger(`POST - COMENTARIOS - new`, error.message, "error");
            res.status(500).json({ message: 'Erro ao criar comentário.', error: error.message });
        } else {
            console.error('Erro ao criar comentário: Erro desconhecido');
            Logger(`POST - COMENTARIOS - new`, "Erro desconhecido", "error");
            res.status(500).json({ message: 'Erro ao criar comentário.', error: 'Erro desconhecido.' });
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
            console.error('Erro ao deletar comentario:', error.message);
            Logger(`DELETE - COMENTARIOS - ID ${processo}`, error.message, "error");
            res.status(500).send({ message: 'Erro ao criar comentario', error: error.message });
        } else {
            console.error('Erro ao deletar comentario: Erro desconhecido');
            Logger(`DELETE - COMENTARIOS - ID ${processo}`, "Erro desconhecido", "error");
            res.status(500).send({ message: 'Erro ao criar comentario', error: 'Erro desconhecido' });
        }
    }
});

routerComments.get('/all-from-proccess/:processo', validateJWT, async (req, res) => {
    const processo = Number(req.params.processo);
    try {
        const steps = await prisma.comentarios.findMany({
            where: {
                processo: processo,
            }, include: {
                usuario_comentarios_usuarioTousuario: {
                    select: {
                        nome: true,
                        sobrenome: true,
                        email: true,
                        foto: true,
                    },
                },
            },
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

