import { Router } from 'express';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { isAllowed, validateJWT } from '../../middlewares/JWTVerifier';
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

routerUsers.patch('/role', validateJWT, isAllowed, async (req, res) => {

    const { user, role } = req.body;

    try {
        const field = await prisma.usuario.update({
            where: {
                id : user
            },
            data: {
                funcao: role,
            }
        });
        
        Logger(`PATCH - USER - role`, JSON.stringify(field), "success");
        res.status(200).json(field); 
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao atualizar role:', error.message);
            Logger(`PATCH - USER - role`, error.message, "error");
            res.status(500).json({ message: 'Erro ao atualizar ROLE', error: error.message });
        } else {
            console.error('Erro ao atualizar role: Erro desconhecido');
            Logger(`PATCH - USER - role`, "Erro desconhecido", "error");
            res.status(500).json({ message: 'Erro ao atualizar role', error: 'Erro desconhecido' });
        }
    }
});

routerUsers.patch('/link-user-course', validateJWT, isAllowed, async (req, res) => {

    const { user, curso } = req.body;

    try {
        const field = await prisma.usuario.update({
            where: {
                id : user
            },
            data: {
                curso: curso,
            }
        });
        
        Logger(`PATCH - USER - link-user-course`, JSON.stringify(field), "success");
        res.status(200).json(field); 
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao atualizar link-user-course:', error.message);
            Logger(`PATCH - USER - link-user-course`, error.message, "error");
            res.status(500).json({ message: 'Erro ao atualizar ROLE', error: error.message });
        } else {
            console.error('Erro ao atualizar link-user-course: Erro desconhecido');
            Logger(`PATCH - USER - link-user-course`, "Erro desconhecido", "error");
            res.status(500).json({ message: 'Erro ao atualizar role', error: 'Erro desconhecido' });
        }
    }
});

routerUsers.get('/all', validateJWT, async (req, res) => {
    try {
        const users = await prisma.usuario.findMany()

        if (users) {
            Logger(`GET - USERS - all`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(users));
        } else {
            Logger(`GET - USERS - all`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Users not found!' });
        }
    } catch (error) {
        Logger(`GET - USERS - all`, `Error fetching requested user. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested user.' });
    }
});

routerUsers.get('/all-teachers', validateJWT, async (req, res) => {
    try {
        const users = await prisma.usuario.findMany({
            where:{
                funcao: 3
            }
        })

        if (users) {
            Logger(`GET - USERS - all-teachers`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(users));
        } else {
            Logger(`GET - USERS - all-teachers`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Users not found!' });
        }
    } catch (error) {
        Logger(`GET - USERS - all-teachers`, `Error fetching requested user. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested user.' });
    }
});

routerUsers.get('/all-students', validateJWT, async (req, res) => {
    try {
        const users = await prisma.usuario.findMany({
            where:{
                funcao: 1
            }
        })

        if (users) {
            Logger(`GET - USERS - all-students`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(users));
        } else {
            Logger(`GET - USERS - all-students`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Users not found!' });
        }
    } catch (error) {
        Logger(`GET - USERS - all-students`, `Error fetching requested user. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested user.' });
    }
});

routerUsers.get('/all-students-course/:course', validateJWT, async (req, res) => {
    const course = Number(req.params.course);

    try {
        const users = await prisma.usuario.findMany({
            where:{
                funcao: 1,
                curso: course
            }
        })

        if (users) {
            Logger(`GET - USERS - all-students-course`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(users));
        } else {
            Logger(`GET - USERS - all-students-course`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Users not found!' });
        }
    } catch (error) {
        Logger(`GET - USERS - all-students-course`, `Error fetching requested user. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested user.' });
    }
});

routerUsers.get('/all-servers', validateJWT, async (req, res) => {
    try {
        const users = await prisma.usuario.findMany({
            where:{
                funcao: 2
            }
        })

        if (users) {
            Logger(`GET - USERS - all-servers`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(users));
        } else {
            Logger(`GET - USERS - all-servers`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Users not found!' });
        }
    } catch (error) {
        Logger(`GET - USERS - all-servers`, `Error fetching requested user. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested user.' });
    }
});

routerUsers.get('/all-admins', validateJWT, async (req, res) => {
    try {
        const users = await prisma.usuario.findMany({
            where:{
                funcao: 9
            }
        })

        if (users) {
            Logger(`GET - USERS - all-admins`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(users));
        } else {
            Logger(`GET - USERS - all-admins`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Users not found!' });
        }
    } catch (error) {
        Logger(`GET - USERS - all-admins`, `Error fetching requested user. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested user.' });
    }
});

routerUsers.get('/all-deactivated', validateJWT, async (req, res) => {
    try {
        const users = await prisma.usuario.findMany({
            where:{
                funcao: 0
            }
        })

        if (users) {
            Logger(`GET - USERS - all-deactivated`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(users));
        } else {
            Logger(`GET - USERS - all-deactivated`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Users not found!' });
        }
    } catch (error) {
        Logger(`GET - USERS - all-deactivated`, `Error fetching requested user. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested user.' });
    }
});

