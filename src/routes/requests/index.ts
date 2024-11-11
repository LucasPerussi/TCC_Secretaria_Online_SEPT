import { Router } from 'express';
import { validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';
import { numberGenerator } from '../../middlewares/randomCodeGenerator';

export const routerRequests = Router()

routerRequests.get('/', (req, res) => res.send('API de Solicitações'))

// routerRequests.post('/new', validateJWT, async (req, res) => {
//     let { titulo, descricao, aluno, servidor_responsavel, professor_avaliador, tipo_solicitacao } = req.body;
//     let identificador = await Number(numberGenerator(20));

//     try {
//         const field = await prisma.processo.create({
//             data: {
//                 titulo,
//                 descricao,
//                 aluno,
//                 servidor_responsavel,
//                 tipo_solicitacao,
//                 data_abertura: '',
//                 identificador, 
//                 etapa_atual: 1,
//                 professor_avaliador
//             }
//         })
//         Logger(`POST - FIELDS - new-type`, JSON.stringify(field), "success");
//         res.status(200).send(JSON.stringify(field));
//     } catch (error) {
//         if (error instanceof Error) {
//             console.error('Erro ao criar estágio:', error.message);
//             Logger(`POST - FIELDS - new-type`, error.message, "error");
//             res.status(500).send({ message: 'Erro ao criar estágio', error: error.message });
//         } else {
//             console.error('Erro ao criar estágio: Erro desconhecido');
//             Logger(`POST - FIELDS - new-type`, "Erro desconhecido", "error");
//             res.status(500).send({ message: 'Erro ao criar estágio', error: 'Erro desconhecido' });
//         }
//     }
// });

// routerFields.get('/field-type-id/:id', validateJWT, async (req, res) => {
//     const id = Number(req.params.id);
//     try {
//         const steps = await prisma.tipos_campos.findFirst({
//             where: {
//                 id: id
//             }
//         })

//         if (steps) {
//             Logger(`GET - FIELDS - field-type-id/${id}`, `200 - Found and Authorized`, "success");
//             res.status(200).send(JSON.stringify(steps));
//         } else {
//             Logger(`GET - FIELDS - field-type-id/${id}`, `404 - Not Found`, "error");
//             res.status(404).send({ error: true, message: 'Field type not found!' });
//         }
//     } catch (error) {
//         Logger(`GET - FIELDS - field-type-id/${id}`, `Error fetching requested Field type. ${JSON.stringify(error)} `, "error");
//         res.status(500).json({ message: 'Error fetching requested Field type.' });
//     }
// });