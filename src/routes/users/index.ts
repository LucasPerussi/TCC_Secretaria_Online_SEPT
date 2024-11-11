import { Router } from 'express';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { validateJWT } from '../../middlewares/JWTVerifier';
import { Logger } from '../../middlewares/logger';

export const routerUsers = Router()

routerUsers.get('/', (req, res) => res.send('API de usuários'))

routerUsers.get('/id/:id', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const steps = await prisma.usuario.findFirst({
            where: {
                id: id
            }
        })

        if (steps) {
            Logger(`GET - USERS - id/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - USERS - id/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'User not found!' });
        }
    } catch (error) {
        Logger(`GET - USERS - id/${id}`, `Error fetching requested user. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested user.' });
    }
});

routerUsers.get('/email/:email', validateJWT, async (req, res) => {
    const email = req.params.email;
    try {
        const steps = await prisma.usuario.findFirst({
            where: {
                email: email
            }
        })

        if (steps) {
            Logger(`GET - USERS - email/${email}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - USERS - email/${email}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'User not found!' });
        }
    } catch (error) {
        Logger(`GET - USERS - email/${email}`, `Error fetching requested user. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested user.' });
    }
});

routerUsers.get('/role/:role', validateJWT, async (req, res) => {
    const role = Number(req.params.role);
    try {
        const steps = await prisma.usuario.findMany({
            where: {
                funcao: role
            }
        })

        if (steps) {
            Logger(`GET - USERS - role/${role}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - USERS - role/${role}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'User not found!' });
        }
    } catch (error) {
        Logger(`GET - USERS - role/${role}`, `Error fetching requested user. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested user.' });
    }
});

routerUsers.get('/all', validateJWT, async (req, res) => {
    try {
        const steps = await prisma.usuario.findMany()

        if (steps) {
            Logger(`GET - USERS - all`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(steps));
        } else {
            Logger(`GET - USERS - all`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Users not found!' });
        }
    } catch (error) {
        Logger(`GET - USERS - all`, `Error fetching requested user. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested user.' });
    }
});


