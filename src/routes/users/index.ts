import { Router } from 'express';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { PrismaClient, Prisma } from '@prisma/client';  
import { extractUserDataFromToken, isAllowed, validateJWT } from '../../middlewares/JWTVerifier';
import { TimelineTypes, TimelineTypeInfo, getNomeTimelinesById } from '../../enum/timeline';



const crypto = require('crypto');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

import axios from 'axios';
import { Logger } from '../../middlewares/logger';
import { Timeline } from '../../middlewares/timeline';
import { SendEmail } from '../../middlewares/sendEmail';
import { EmailTypes } from '../../enum/emails';

// Definição do tipo para o corpo da requisição
interface ChangePasswordRequest {
    currentPassword: string;
    newPassword: string;
    confirmPassword: string;
}

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

routerUsers.patch('/id/:id/change-password', validateJWT, async (req, res) => {
    const id = Number(req.params.id);

    try {
        const userData = await extractUserDataFromToken(req, res);
        if (!userData) { 
            return;
        }

        if (userData.id !== id && userData.funcao < 9) { 
            Logger('USERS/PATCH - change-password', `403 - Erro - Acesso negado. Usuário ID: ${userData.id} tentou alterar a senha de ID: ${id}`, "error");
            return res.status(403).json({ message: 'Acesso negado.' });
        }

        // Extrai os campos necessários do corpo da requisição
        const { currentPassword, newPassword, confirmPassword }: ChangePasswordRequest = req.body;

        // Verificação de campos obrigatórios
        if (!currentPassword || !newPassword || !confirmPassword) {
            Logger('USERS/PATCH - change-password', `400 - Erro - Campos obrigatórios faltando. ID: ${id}`, "error");
            return res.status(400).json({ message: 'Todos os campos são obrigatórios.' });
        }

        // Verifica se a nova senha e a confirmação correspondem
        if (newPassword !== confirmPassword) {
            Logger('USERS/PATCH - change-password', `400 - Erro - As novas senhas não correspondem. ID: ${id}`, "error");
            return res.status(400).json({ message: 'As novas senhas não correspondem.' });
        }

        // Opcional: Verificar se a nova senha atende a certos critérios de segurança
        if (newPassword.length < 6) { // Exemplo de critério
            Logger('USERS/PATCH - change-password', `400 - Erro - A nova senha deve ter pelo menos 6 caracteres. ID: ${id}`, "error");
            return res.status(400).json({ message: 'A nova senha deve ter pelo menos 6 caracteres.' });
        }

        // Recupera o usuário do banco de dados, incluindo a senha atual
        const user = await prisma.usuario.findUnique({
            where: { id: id },
            select: {
                id: true,
                email: true,
                senha: true,
                nome: true,
                sobrenome: true,
                funcao: true, 
            },
        });

        // Verifica se o usuário existe
        if (!user) {
            Logger('USERS/PATCH - change-password', `404 - Erro - Usuário não encontrado. ID: ${id}`, "error");
            return res.status(404).json({ message: 'Usuário não encontrado.' });
        }

        // Verifica se a senha atual está correta
        const isPasswordValid = await bcrypt.compare(currentPassword, user.senha);
        if (!isPasswordValid) {
            Logger('USERS/PATCH - change-password', `400 - Erro - Senha atual inválida. ID: ${id}`, "error");
            return res.status(400).json({ message: 'Senha atual inválida.' });
        }

        // Hash da nova senha
        const hashedNewPassword = await bcrypt.hash(newPassword, 10);

        // Atualiza a senha no banco de dados
        await prisma.usuario.update({
            where: { id: id },
            data: { senha: hashedNewPassword },
        });

        // Log da ação
        Logger('USERS/PATCH - change-password', `200 - Senha atualizada com sucesso para o usuário ID: ${id}`, "success", id);
        Timeline(
            'Senha alterada com sucesso!',
            id.toString(),
            'A senha da sua conta foi alterada.',
            Number(TimelineTypes.PASSWORD_CHANGE),
            id
        );
        SendEmail(
            user.email,
            'Senha Alterada',
            'Sua senha foi alterada com sucesso.',
            Number(user.id),
            Number(EmailTypes.PASSWORD_CHANGE)
        );

        // Responde com uma mensagem de sucesso
        res.status(200).json({ message: 'Senha atualizada com sucesso.' });
    } catch (error) {
        if (error instanceof Prisma.PrismaClientKnownRequestError) {
            Logger('USERS/PATCH - change-password', `400 - Erro - ${error.message}`, "error", id);
            res.status(400).json({ message: error.message });
        } else {
            Logger('USERS/PATCH - change-password', `500 - Erro - ${error}`, "error", id);
            console.error('Erro durante a troca de senha:', error);
            res.status(500).json({ message: 'Erro interno do servidor.' });
        }
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

        let roleText ="";
        switch (user.funcao) {
            case 1:
                roleText = 'Aluno';
                break;
            case 2:
                roleText = 'Servidor';
                break;
            case 3:
                roleText = 'Professor';
                break;
            case 9:
                roleText = 'Admin';
                break;
            default:
                roleText = 'Deactivated';
                break;
        }

        Timeline("Você é agora um  " + roleText, user, "Sua função no sistema foi alterada para '" + roleText + "'!", Number(TimelineTypes.ROLE_UPDATE), Number(user))

        
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
        
        Timeline("Alteração de curso" , user, "Você foi vinculado a um novo curso de graduação", Number(TimelineTypes.COURSE_UPDATE), Number(user))

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

routerUsers.patch('/email/:id', validateJWT, async (req, res) => {
    const { id } = req.params;
    const { email } = req.body;

    if (!email) {
        return res.status(400).json({ error: true, message: 'Email é obrigatório.' });
    }

    try {
        const existingUser = await prisma.usuario.findUnique({
            where: { id: parseInt(id) },
        });

        if (!existingUser) {
            Logger(`PATCH - USERS - EMAIL - ${id}`, `404 - Usuário não encontrado`, "error");
            return res.status(404).json({ error: true, message: 'Usuário não encontrado!' });
        }

        const updatedUser = await prisma.usuario.update({
            where: { id: parseInt(id) },
            data: { email },
        });
        Timeline("Alteração de email" , id, "Seu email foi alterado", Number(TimelineTypes.EMAIL_UPDATE), Number(id))
        Logger(`PATCH - USERS - EMAIL - ${id}`, `200 - Email atualizado com sucesso`, "success");
        res.status(200).json(updatedUser);
    } catch (error) {
        Logger(`PATCH - USERS - EMAIL - ${id}`, `Erro ao atualizar email. ${JSON.stringify(error)}`, "error");
        res.status(500).json({ message: 'Erro ao atualizar email.' });
    }
});

routerUsers.patch('/registro/:id', validateJWT, async (req, res) => {
    const { id } = req.params;
    const { registro } = req.body;

    if (!registro) {
        return res.status(400).json({ error: true, message: 'Registro é obrigatório.' });
    }

    try {
        const existingUser = await prisma.usuario.findUnique({
            where: { id: parseInt(id) },
        });

        if (!existingUser) {
            Logger(`PATCH - USERS - REGISTRO - ${id}`, `404 - Usuário não encontrado`, "error");
            return res.status(404).json({ error: true, message: 'Usuário não encontrado!' });
        }

        const updatedUser = await prisma.usuario.update({
            where: { id: parseInt(id) },
            data: { registro },
        });
        Timeline("Alteração de registro" , id, "Seu registro foi alterado", Number(TimelineTypes.REGISTRATION_UPDATE), Number(id))

        Logger(`PATCH - USERS - REGISTRO - ${id}`, `200 - Registro atualizado com sucesso`, "success");
        res.status(200).json(updatedUser);
    } catch (error) {
        Logger(`PATCH - USERS - REGISTRO - ${id}`, `Erro ao atualizar registro. ${JSON.stringify(error)}`, "error");
        res.status(500).json({ message: 'Erro ao atualizar registro.' });
    }
});

routerUsers.patch('/nome/:id', validateJWT, async (req, res) => {
    const { id } = req.params;
    const { nome } = req.body;

    if (!nome) {
        return res.status(400).json({ error: true, message: 'Nome é obrigatório. recived' + JSON.stringify(req.body) });
    }

    try {
        const existingUser = await prisma.usuario.findUnique({
            where: { id: parseInt(id) },
        });

        if (!existingUser) {
            Logger(`PATCH - USERS - NOME - ${id}`, `404 - Usuário não encontrado`, "error");
            return res.status(404).json({ error: true, message: 'Usuário não encontrado!' });
        }

        const updatedUser = await prisma.usuario.update({
            where: { id: parseInt(id) },
            data: { nome },
        });
        Timeline("Alteração de nome" , id, "Seu nome foi alterado", Number(TimelineTypes.NAME_UPDATE), Number(id))

        Logger(`PATCH - USERS - NOME - ${id}`, `200 - Nome atualizado com sucesso`, "success");
        res.status(200).json(updatedUser);
    } catch (error) {
        Logger(`PATCH - USERS - NOME - ${id}`, `Erro ao atualizar nome. ${JSON.stringify(error)}`, "error");
        res.status(500).json({ message: 'Erro ao atualizar nome.' });
    }
});

routerUsers.patch('/sobrenome/:id', validateJWT, async (req, res) => {
    const { id } = req.params;
    const { sobrenome } = req.body;

    if (!sobrenome) {
        return res.status(400).json({ error: true, message: 'Sobrenome é obrigatório.' });
    }

    try {
        const existingUser = await prisma.usuario.findUnique({
            where: { id: parseInt(id) },
        });

        if (!existingUser) {
            Logger(`PATCH - USERS - SOBRENOME - ${id}`, `404 - Usuário não encontrado`, "error");
            return res.status(404).json({ error: true, message: 'Usuário não encontrado!' });
        }

        const updatedUser = await prisma.usuario.update({
            where: { id: parseInt(id) },
            data: { sobrenome },
        });
        Timeline("Alteração de sobrenome" , id, "Seu sobrenome foi alterado", Number(TimelineTypes.SURNAME_UPDATE), Number(id))


        Logger(`PATCH - USERS - SOBRENOME - ${id}`, `200 - Sobrenome atualizado com sucesso`, "success");
        res.status(200).json(updatedUser);
    } catch (error) {
        Logger(`PATCH - USERS - SOBRENOME - ${id}`, `Erro ao atualizar sobrenome. ${JSON.stringify(error)}`, "error");
        res.status(500).json({ message: 'Erro ao atualizar sobrenome.' });
    }
});

routerUsers.patch('/nascimento/:id', validateJWT, async (req, res) => {
    const { id } = req.params;
    const { nascimento } = req.body;

    if (!nascimento) {
        return res.status(400).json({ error: true, message: 'Data de nascimento é obrigatória.' });
    }

    const dataNascimento = new Date(nascimento);

    try {
        const existingUser = await prisma.usuario.findUnique({
            where: { id: parseInt(id) },
        });

        if (!existingUser) {
            Logger(`PATCH - USERS - NASCIMENTO - ${id}`, `404 - Usuário não encontrado`, "error");
            return res.status(404).json({ error: true, message: 'Usuário não encontrado!' });
        }

        const updatedUser = await prisma.usuario.update({
            where: { id: parseInt(id) },
            data: { nascimento: dataNascimento },
        });
        Timeline("Alteração de nascimento" , id, "Seu nascimento foi alterado", Number(TimelineTypes.BIRTHDATE_UPDATE), Number(id))

        Logger(`PATCH - USERS - NASCIMENTO - ${id}`, `200 - Data de nascimento atualizada com sucesso`, "success");
        res.status(200).json(updatedUser);
    } catch (error) {
        Logger(`PATCH - USERS - NASCIMENTO - ${id}`, `Erro ao atualizar data de nascimento. ${JSON.stringify(error)}`, "error");
        res.status(500).json({ message: 'Erro ao atualizar data de nascimento.' });
    }
});

routerUsers.patch('/foto/:id', validateJWT, async (req, res) => {
    const { id } = req.params;
    const { foto } = req.body;

    if (!foto) {
        return res.status(400).json({ error: true, message: 'URL da foto é obrigatória.' });
    }

    try {
        const existingUser = await prisma.usuario.findUnique({
            where: { id: parseInt(id) },
        });

        if (!existingUser) {
            Logger(`PATCH - USERS - FOTO - ${id}`, `404 - Usuário não encontrado`, "error");
            return res.status(404).json({ error: true, message: 'Usuário não encontrado!' });
        }

        const updatedUser = await prisma.usuario.update({
            where: { id: parseInt(id) },
            data: { foto },
        });
        Timeline("Alteração de fototo de perfil" , id, "Seu nascimento foi alterado", Number(TimelineTypes.PHOTO_UPDATE), Number(id))

        Logger(`PATCH - USERS - FOTO - ${id}`, `200 - Foto atualizada com sucesso`, "success");
        res.status(200).json(updatedUser);
    } catch (error) {
        Logger(`PATCH - USERS - FOTO - ${id}`, `Erro ao atualizar foto. ${JSON.stringify(error)}`, "error");
        res.status(500).json({ message: 'Erro ao atualizar foto.' });
    }
});


routerUsers.patch('/status_usuario/:id', validateJWT, async (req, res) => {
    const { id } = req.params;
    const { status_usuario } = req.body;

    if (status_usuario === undefined) {
        return res.status(400).json({ error: true, message: 'Status do usuário é obrigatório.' });
    }

    const statusInt = parseInt(status_usuario);
    if (isNaN(statusInt)) {
        return res.status(400).json({ error: true, message: 'Status do usuário deve ser um número inteiro.' });
    }

    try {
        const existingUser = await prisma.usuario.findUnique({
            where: { id: parseInt(id) },
        });

        if (!existingUser) {
            Logger(`PATCH - USERS - STATUS_USUARIO - ${id}`, `404 - Usuário não encontrado`, "error");
            return res.status(404).json({ error: true, message: 'Usuário não encontrado!' });
        }

        const updatedUser = await prisma.usuario.update({
            where: { id: parseInt(id) },
            data: { status_usuario: statusInt },
        });
        Timeline("Alteração de status de conta" , id, "Seu status de conta foi alterado", Number(TimelineTypes.USER_STATUS_UPDATE), Number(id))

        Logger(`PATCH - USERS - STATUS_USUARIO - ${id}`, `200 - Status do usuário atualizado com sucesso`, "success");
        res.status(200).json(updatedUser);
    } catch (error) {
        Logger(`PATCH - USERS - STATUS_USUARIO - ${id}`, `Erro ao atualizar status do usuário. ${JSON.stringify(error)}`, "error");
        res.status(500).json({ message: 'Erro ao atualizar status do usuário.' });
    }
});

// PATCH /curso/:id
routerUsers.patch('/curso/:id', validateJWT, async (req, res) => {
    const { id } = req.params;
    const { curso } = req.body;

    if (curso === undefined) {
        return res.status(400).json({ error: true, message: 'Curso é obrigatório.' });
    }

    const cursoInt = parseInt(curso);
    if (isNaN(cursoInt)) {
        return res.status(400).json({ error: true, message: 'Curso deve ser um número inteiro.' });
    }

    try {
        const existingUser = await prisma.usuario.findUnique({
            where: { id: parseInt(id) },
        });

        if (!existingUser) {
            Logger(`PATCH - USERS - CURSO - ${id}`, `404 - Usuário não encontrado`, "error");
            return res.status(404).json({ error: true, message: 'Usuário não encontrado!' });
        }

        const updatedUser = await prisma.usuario.update({
            where: { id: parseInt(id) },
            data: { curso: cursoInt },
        });
        Timeline("Alteração de curso" , id, "Você foi vinculado a um novo curso de graduação", Number(TimelineTypes.COURSE_UPDATE), Number(id))

        Logger(`PATCH - USERS - CURSO - ${id}`, `200 - Curso atualizado com sucesso`, "success");
        res.status(200).json(updatedUser);
    } catch (error) {
        Logger(`PATCH - USERS - CURSO - ${id}`, `Erro ao atualizar curso. ${JSON.stringify(error)}`, "error");
        res.status(500).json({ message: 'Erro ao atualizar curso.' });
    }
});


routerUsers.patch('/status_curso/:id', validateJWT, async (req, res) => {
    const { id } = req.params;
    const { status_curso } = req.body;

    if (status_curso === undefined) {
        return res.status(400).json({ error: true, message: 'Status do curso é obrigatório.' });
    }

    const statusCursoInt = parseInt(status_curso);
    if (isNaN(statusCursoInt)) {
        return res.status(400).json({ error: true, message: 'Status do curso deve ser um número inteiro.' });
    }

    try {
        const existingUser = await prisma.usuario.findUnique({
            where: { id: parseInt(id) },
        });

        if (!existingUser) {
            Logger(`PATCH - USERS - STATUS_CURSO - ${id}`, `404 - Usuário não encontrado`, "error");
            return res.status(404).json({ error: true, message: 'Usuário não encontrado!' });
        }

        const updatedUser = await prisma.usuario.update({
            where: { id: parseInt(id) },
            data: { status_curso: statusCursoInt },
        });
        Timeline("Alteração de status de curso" , id, "Seu status de curso foi atualizado", Number(TimelineTypes.COURSE_STATUS_UPDATE), Number(id))

        Logger(`PATCH - USERS - STATUS_CURSO - ${id}`, `200 - Status do curso atualizado com sucesso`, "success");
        res.status(200).json(updatedUser);
    } catch (error) {
        Logger(`PATCH - USERS - STATUS_CURSO - ${id}`, `Erro ao atualizar status do curso. ${JSON.stringify(error)}`, "error");
        res.status(500).json({ message: 'Erro ao atualizar status do curso.' });
    }
});




