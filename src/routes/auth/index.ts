import { Router, Request } from 'express';
import prisma from '../../prismaClient';
import { PrismaClient, Prisma } from '@prisma/client';
import { extractUserDataFromToken, validateJWT } from '../../middlewares/JWTVerifier';
import { TimelineTypes, TimelineTypeInfo } from '../../enum/timeline';

import axios from 'axios';
import { Logger } from '../../middlewares/logger';
import { Timeline } from '../../middlewares/timeline';
import { SendEmail } from '../../middlewares/sendEmail';
import { EmailTypes } from '../../enum/emails';

const crypto = require('crypto');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

interface CreateUserRequest {
    email: string;
    senha: string;
    nome: string;
    sobrenome: string;
    nascimento: string;
    registro: string;
}

export const routerAuth = Router()

routerAuth.get('/', (req, res) => res.send('API de Autenticação'))

routerAuth.post('/login', async (req, res) => {
    let { email, senha } = req.body;
    email = email.toLowerCase();
    try {
        let user = await prisma.usuario.findUnique({
            where: { email },
        });

        if (!user) {
            user = await prisma.usuario.findUnique({
                where: { registro: email },
            });
        }

        if (!user) {
            return res.status(404).json({ message: 'Usuário não encontrado.' });
        }

        const passwordMatch = await bcrypt.compare(senha, user.senha);

        if (!passwordMatch) {
            return res.status(401).json({ message: 'Senha incorreta.' });
        }

        // await prisma.logins.deleteMany({
        //     where: {
        //         usuario: user.id,
        //     },
        // });

        const code = await sessionGenerator(Number(user.id), req);
        if (code === "Error") {
            console.log(code);
            return res.status(505).json({ message: 'Erro interno do servidor. Entre em contato com o suporte' });
        }

        const token = jwt.sign(
            {
                user: user.id.toString(),
                role: user.funcao,
                client: 'API',
            },
            code,
            { expiresIn: '24h' }
        );

        let roleText = '';
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

        res.status(200).json({
            token,
            user: {
                id: user.id,
                name: `${user.nome} ${user.sobrenome}`,
                email: user.email,
                role: roleText,
                picture: user.foto,
                registro: user.registro
            },
        });
    } catch (error) {
        console.error('Erro durante o login:', error);
        res.status(500).json({ message: 'Erro interno do servidor.' });
    }
});


const generateRandomCodeSize = (length: number) => {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let code = '';
    for (let i = 0; i < length; i++) {
        code += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return code;
};

routerAuth.post('/check-recovery', async (req, res) => {
    const { email, registro, nascimento } = req.body;

    // Validação básica dos campos de entrada
    if (!email || !registro || !nascimento) {
        return res.status(400).json({
            success: false,
            message: 'Todos os campos (email, registro, nascimento) são obrigatórios.'
        });
    }

    try {
        // Busca o usuário pelo email (convertido para minúsculas)
        const userExist = await prisma.usuario.findFirst({
            where: {
                email: email.toLowerCase()
            }
        });

        if (!userExist) {
            return res.status(404).json({
                success: false,
                message: 'Usuário não encontrado.'
            });
        }

        // Normaliza os dados para comparação
        const inputRegistro = registro.toLowerCase();
        const inputNascimento = new Date(nascimento).toISOString().split('T')[0]; // Formato YYYY-MM-DD

        const userRegistro = userExist.registro.toLowerCase();
        const userNascimento = new Date(userExist.nascimento).toISOString().split('T')[0]; // Assegura o mesmo formato

        // Verifica se registro e nascimento correspondem
        if (inputRegistro !== userRegistro || inputNascimento !== userNascimento) {
            return res.status(400).json({
                success: false,
                message: 'Registro ou data de nascimento incorretos.'
            });
        }

        const recoveryCode = generateRandomCodeSize(60);

        // Cria um hash do código para armazenar no banco de dados
        const recoveryCodeHash = await bcrypt.hash(recoveryCode, 10);

        // Cria um novo registro na tabela 'codigos' usando a relação correta
        const novoCodigo = await prisma.codigos.create({
            data: { 
                codigo: recoveryCodeHash, // Armazena o hash
                status: 1,
                data_solicitacao: new Date(), // Campo obrigatório
                usuario_codigos_usuarioTousuario: { 
                    connect: { id: userExist.id } 
                }
            }
        });

        console.log('Novo código de recuperação criado:', novoCodigo);

        // Retorna o código simples (não hasheado) para o cliente
        return res.status(200).json({
            success: true,
            message: 'Informações validadas com sucesso.',
            data: {
                userId: userExist.id,
                recoveryCode: recoveryCode // Retorna o código simples
            }
        });

    } catch (error) {
        console.error('Erro na verificação de recuperação:', error);
        return res.status(500).json({
            success: false,
            message: 'Ocorreu um erro ao processar sua solicitação. Por favor, tente novamente mais tarde.'
        });
    }
});



routerAuth.post('/create', async (req, res) => {
    const { email, senha, nome, sobrenome, nascimento, registro } = req.body;

    try {
        const emailLC = email.toLowerCase();
        const registroLC = registro.toLowerCase();

        // Verifica se pode criar o usuário
        const canCreateUser = await checkCanCreateuser(email, registro);

        if (!canCreateUser.canCreate) {
            Logger('auth/create', `400 - Erro - Motivo: ${canCreateUser.reason} | email: ${email} | registro: ${registro}`, "error");
            console.log(`Motivo: ${canCreateUser.reason} | email: ${email} | registro: ${registro}`);
            return res.status(400).json({ message: canCreateUser.reason });
        }

        // Hash da senha
        const hashedPassword = await bcrypt.hash(senha, 10);

        // Criação do usuário no banco de dados
        const createdUser = await prisma.usuario.create({
            data: {
                email: emailLC,
                senha: hashedPassword,
                nome,
                sobrenome,
                nascimento: new Date(nascimento),
                criado_em: new Date(),
                funcao: 1,
                registro: registroLC,
                foto: 'src/img/avatars/generic.webp',
                status_usuario: 1,
                status_curso: 1,
            },
            select: {
                id: true,
                email: true,
                nome: true,
                sobrenome: true,
                nascimento: true,
                registro: true,
                funcao: true,
                status_usuario: true,
                foto: true,
            },
        });

        // Registro no Logger e Timeline
        Logger('auth/create', `Usuário criado com sucesso! ${JSON.stringify({ user: createdUser })}`, "success", createdUser.id);
        Timeline('Bem vindo(a) à secretaria online do SEPT!', createdUser.id.toString(), 'Sua conta foi registrada com sucesso e atrelada ao registro ' + registro, Number(TimelineTypes.ACCOUNT_CREATION), createdUser.id);
        SendEmail(createdUser.email, 'Bem-vindo(a) à secretaria online do SEPT!', 'Este é um teste!', Number(createdUser.id), Number(EmailTypes.ACCOUNT_CREATION));

        // Geração da sessão e do token JWT, semelhante à rota de login
        const code = await sessionGenerator(Number(createdUser.id), req);
        if (code === "Error") {
            console.log(code);
            return res.status(505).json({ message: 'Erro interno do servidor. Entre em contato com o suporte' });
        }

        const token = jwt.sign(
            {
                user: createdUser.id.toString(),
                role: createdUser.funcao,
                client: 'API',
            },
            code,
            { expiresIn: '24h' }
        );

        // Determinação do texto da função do usuário
        let roleText = '';
        switch (createdUser.funcao) {
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

        // Envio da resposta com o token e informações do usuário
        res.status(201).json({
            token,
            user: {
                id: createdUser.id,
                name: `${createdUser.nome} ${createdUser.sobrenome}`,
                email: createdUser.email,
                role: roleText,
                picture: createdUser.foto,
                registro: createdUser.registro
            }
        });
    } catch (error) {
        if (error instanceof Prisma.PrismaClientKnownRequestError && error.code === 'P2002') {
            Logger('auth/create', `400 - Erro - O ${error.meta?.target} já está em uso.`, "error");
            res.status(400).json({ message: `O ${error.meta?.target} já está em uso.` });
        } else {
            Logger('auth/create', `500 - Erro - O ${error}`, "error");
            console.error('Erro durante a criação de usuário:', error);
            res.status(500).json({ message: 'Erro interno do servidor.' });
        }
    }
});

routerAuth.post('/change-password-validate', async (req, res) => {
    const { codigo, senha, confirmacaoSenha } = req.body;

    try {
        // Validação básica dos campos
        if (!codigo || !senha || !confirmacaoSenha) {
            return res.status(400).json({ message: 'Todos os campos são obrigatórios.' });
        }

        if (senha !== confirmacaoSenha) {
            return res.status(400).json({ message: 'As senhas não conferem.' });
        }

        // Buscar todos os códigos ativos (status: 1)
        const codigosAtivos = await prisma.codigos.findMany({
            where: {
                status: 1, // Considerando que status 1 significa ativo
            },
            include: {
                usuario_codigos_usuarioTousuario: true, // Inclui informações do usuário relacionado
            }
        });

        // Encontrar o código que corresponde ao fornecido usando bcrypt.compare
        let codigoRegistro = null;
        for (const codigoDB of codigosAtivos) {
            const isMatch = await bcrypt.compare(codigo, codigoDB.codigo);
            if (isMatch) {
                codigoRegistro = codigoDB;
                break;
            }
        }

        if (!codigoRegistro) {
            return res.status(400).json({ message: 'Código de recuperação inválido ou já utilizado.' });
        }

        const usuarioId = codigoRegistro.usuario_codigos_usuarioTousuario.id;

        // Atualizar a senha do usuário
        const hashedPassword = await bcrypt.hash(senha, 10);

        await prisma.usuario.update({
            where: { id: usuarioId }, 
            data: {
                senha: hashedPassword,
            },
        });

        // Marcar o código como usado
        await prisma.codigos.update({
            where: { id: codigoRegistro.id },
            data: {
                status: 0, // Considerando que status 0 significa usado/inativo
            },
        });

        // Opcional: Registrar no Logger e Timeline
        Logger('auth/change-password-validate', `Senha alterada com sucesso para o usuário ID: ${usuarioId}`, "success", usuarioId);
        Timeline(
            'Senha alterada com sucesso.',
            usuarioId.toString(),
            'A senha do usuário foi alterada através do código de recuperação.',
            Number(TimelineTypes.PASSWORD_CHANGE),
            usuarioId
        );

        res.status(200).json({ message: 'Senha alterada com sucesso.' });

    } catch (error) {
        Logger('auth/change-password-validate', `500 - Erro - ${error}`, "error");
        console.error('Erro ao validar e alterar a senha:', error);
        res.status(500).json({ message: 'Erro interno do servidor.' });
    }
});

async function checkCanCreateuser(email: string, registro: string) {

    const hasEmail = await prisma.usuario.findFirst({
        where: {
            email
        }
    });

    const hasRegister = await prisma.usuario.findFirst({
        where: {
            registro
        }
    });

    if (hasEmail) {
        return {
            'canCreate': false,
            'reason': 'Email já cadastrado para outro usuário!'
        };
    } else {
        if (hasRegister) {
            return {
                'canCreate': false,
                'reason': 'Registro já atrelado a outro usuário!'
            };
        } else {
            return {
                'canCreate': true,
                'reason': 'Registro já atrelado a outro usuário!'
            };
        }
    }
}

async function sessionGenerator(usuario: number, req: Request) {
    const randomCode: string = generateRandomCode(8);

    try {
        const dataAtual = new Date();

        let ip = req.headers['x-forwarded-for'] || req.socket.remoteAddress;

        if (Array.isArray(ip)) {
            ip = ip[0];
        }

        const ipInfo = await getIpInfo(ip as string);

        const saveSession = await prisma.logins.create({
            data: {
                chave_sessao: randomCode,
                usuario,
                data: dataAtual,
                local: ipInfo,
                ip: ip ?? 'unset'
            }
        });

        return randomCode;
    } catch (error) {
        console.log(error);
        return 'Error';
    }
}

// Função para pegar as informações do IP usando a API ipinfo.io
async function getIpInfo(ip: string): Promise<string> {
    // Verifica se o IP é localhost (IPv4 ou IPv6)
    if (ip === '::1' || ip === '127.0.0.1') {
        return 'Localhost';
    }

    try {
        const response = await axios.get(`https://ipinfo.io/${ip}/json?token=YOUR_TOKEN_HERE`);
        const { city, region, country } = response.data;
        return `${city}, ${region}, ${country}`;
    } catch (error) {
        if (axios.isAxiosError(error)) {
            console.error('Erro ao buscar informações do IP (Axios):', error.response?.data || error.message);
        } else {
            console.error('Erro ao buscar informações do IP:', (error as Error).message);
        }
        return 'Informações de IP não disponíveis';
    }
}

function generateRandomCode(length: number) {
    return crypto.randomBytes(length).toString('hex');
}