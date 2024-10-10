import { Router, Request } from 'express';
import { PrismaClient } from '@prisma/client'
import { extractUserDataFromToken, validateJWT } from '../../middlewares/JWTVerifier';
import axios from 'axios';

const prisma = new PrismaClient()
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
    const { email, senha } = req.body;

    try {
        const user = await prisma.usuario.findUnique({
            where: { email },
        });

        if (!user) {
            return res.status(404).json({ message: 'Usuário não encontrado.' });
        }

        const passwordMatch = await bcrypt.compare(senha, user.senha);

        if (!passwordMatch) {
            return res.status(401).json({ message: 'Senha incorreta.' });
        }

        const code: string = await sessionGenerator(Number(user.id), req)
        if (code === "Error") {
            res.status(505).json({ message: 'Erro interno do servidor. Entre em contato com o suporte' });
            console.log(code)
        }
        const token = jwt.sign({
            user: user.id.toString(), 
            role: user.funcao, 
            client: 'API'
          }, code, {
            expiresIn: '2h',
          });

        var roleText = ''
        switch (user.funcao) {
            case 1:
                roleText = 'Member'
                break;
            case 2:
                roleText = 'Servidor'
                break;
            case 3:
                roleText = 'Professor'
                break;
            case 9:
                roleText = 'Admin'
                break;
            default:
                roleText = 'Deactivated'
                break;
        }

        res.status(200).json({
            token,
            user: {
                id: user.id,
                name: user.nome + ' ' + user.sobrenome,
                email: user.email,
                role: roleText,
                picture: user.foto
            }
        });
    } catch (error) {
        console.error('Erro durante o login:', error);
        res.status(500).json({ message: 'Erro interno do servidor.' });
    }
});


routerAuth.post('/create', async (req, res) => {
    const { email, senha, nome, sobrenome, nascimento, registro }: CreateUserRequest = req.body;

    try {
        const canCreateUser = await checkCanCreateuser(email, registro);

        if (!canCreateUser.canCreate) {
            console.log(canCreateUser.reason + ' email:' + email + ' registro: ' + registro);
            return res.status(400).json({ message: canCreateUser.reason });
        }

        // Hash da senha
        const hashedPassword = await bcrypt.hash(senha, 10);

        const createdUser = await prisma.usuario.create({
            data: {
                email,
                senha: hashedPassword,
                nome,
                sobrenome,
                nascimento: new Date(nascimento),
                criado_em: new Date(),
                funcao: 1,
                registro,
                foto: '',
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
            },
        });

        res.status(201).json({ user: createdUser });
    } catch (error) {
        console.error('Erro durante a criação de usuário:', error);
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
  
      const ipInfo = await getIpInfo(ip as string); // Garantir que o ip é uma string
  
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
        // Trata o erro específico do Axios
        console.error('Erro ao buscar informações do IP (Axios):', error.response?.data || error.message);
      } else {
        // Trata erros genéricos
        console.error('Erro ao buscar informações do IP:', (error as Error).message);
      }
      return 'Informações de IP não disponíveis';
    }
  }
  

function generateRandomCode(length: number) {
    return crypto.randomBytes(length).toString('hex');
}