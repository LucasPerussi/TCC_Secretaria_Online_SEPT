import { Router } from 'express';
import { validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';

export const routerFields = Router()

routerFields.get('/', (req, res) => res.send('API de Campos'))

routerFields.post('/new-type', validateJWT, async (req, res) => {
    let { nome, label, obrigatorio, tipo_dado, padrao } = req.body;

    try {
        const field = await prisma.tipos_campos.create({
            data: {
                nome,
                etiqueta: label,
                obrigatorio,
                tipo_dado,
                campo_padrao: padrao
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







// routerFields.post('/new', validateJWT, async (req, res) => {
//     let { nome, label, padrao } = req.body;

//     try {
//         const step = await prisma.enum_etapas.create({
//             data: {
//                 nome,
//                 label,
//                 padrao
//             }
//         })
//         Logger(`POST - FIELDS - NEW`, JSON.stringify(step), "success");
//         res.status(200).send(JSON.stringify(step));
//     } catch (error) {
//         if (error instanceof Error) {
//             console.error('Erro ao criar estágio:', error.message);
//             Logger(`POST - FIELDS - NEW`, error.message, "error");
//             res.status(500).send({ message: 'Erro ao criar estágio', error: error.message });
//         } else {
//             console.error('Erro ao criar estágio: Erro desconhecido');
//             Logger(`POST - FIELDS - NEW`, "Erro desconhecido", "error");
//             res.status(500).send({ message: 'Erro ao criar estágio', error: 'Erro desconhecido' });
//         }
//     }
// });



// routerFields.get('/id/:id', validateJWT, async (req, res) => {
//     const id = Number(req.params.id);
//     try {
//         const steps = await prisma.enum_etapas.findFirst({
//             where: {
//                 id: id
//             }
//         })

//         if (steps) {
//             Logger(`GET - FIELDS - id/${id}`, `200 - Found and Authorized`, "success");
//             res.status(200).send(JSON.stringify(steps));
//         } else {
//             Logger(`GET - FIELDS - id/${id}`, `404 - Not Found`, "error");
//             res.status(404).send({ error: true, message: 'Step not found!' });
//         }
//     } catch (error) {
//         Logger(`GET - FIELDS - id/${id}`, `Error fetching requested Step. ${JSON.stringify(error)} `, "error");
//         res.status(500).json({ message: 'Error fetching requested Step.' });
//     }
// });

// routerFields.get('/all', validateJWT, async (req, res) => {
//     try {
//         const steps = await prisma.enum_etapas.findMany()

//         if (steps) {
//             Logger(`GET - FIELDS - all`, `200 - Found and Authorized`, "success");
//             res.status(200).send(JSON.stringify(steps));
//         } else {
//             Logger(`GET - FIELDS - all`, `404 - Not Found`, "error");
//             res.status(404).send({ error: true, message: 'Fields not found!' });
//         }
//     } catch (error) {
//         Logger(`GET - FIELDS - all`, `Error fetching requested Fields. ${JSON.stringify(error)} `, "error");
//         res.status(500).json({ message: 'Error fetching requested Step.' });
//     }
// });

// routerFields.get('/all-default', validateJWT, async (req, res) => {
//     try {
//         const steps = await prisma.enum_etapas.findMany({
//             where: {
//                 padrao : 1
//             }
//         })

//         if (steps) {
//             Logger(`GET - FIELDS - all-default`, `200 - Found and Authorized`, "success");
//             res.status(200).send(JSON.stringify(steps));
//         } else {
//             Logger(`GET - FIELDS - all-default`, `404 - Not Found`, "error");
//             res.status(404).send({ error: true, message: 'Fields not found!' });
//         }
//     } catch (error) {
//         Logger(`GET - FIELDS - all-default`, `Error fetching requested Fields. ${JSON.stringify(error)} `, "error");
//         res.status(500).json({ message: 'Error fetching requested Step.' });
//     }
// });








