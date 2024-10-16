"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.routerAuth = void 0;
const express_1 = require("express");
const prismaClient_1 = __importDefault(require("../../../prismaClient"));
const client_1 = require("@prisma/client");
const timeline_1 = require("../../enum/timeline");
const axios_1 = __importDefault(require("axios"));
const logger_1 = require("../../middlewares/logger");
const timeline_2 = require("../../middlewares/timeline");
const sendEmail_1 = require("../../middlewares/sendEmail");
const emails_1 = require("../../enum/emails");
const crypto = require('crypto');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
exports.routerAuth = (0, express_1.Router)();
exports.routerAuth.get('/', (req, res) => res.send('API de Autenticação'));
exports.routerAuth.post('/login', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { email, senha } = req.body;
    try {
        const user = yield prismaClient_1.default.usuario.findUnique({
            where: { email },
        });
        if (!user) {
            return res.status(404).json({ message: 'Usuário não encontrado.' });
        }
        const passwordMatch = yield bcrypt.compare(senha, user.senha);
        if (!passwordMatch) {
            return res.status(401).json({ message: 'Senha incorreta.' });
        }
        const deleteSessionsUser = yield prismaClient_1.default.logins.deleteMany({
            where: {
                usuario: user.id
            }
        });
        const code = yield sessionGenerator(Number(user.id), req);
        if (code === "Error") {
            res.status(505).json({ message: 'Erro interno do servidor. Entre em contato com o suporte' });
            console.log(code);
        }
        const token = jwt.sign({
            user: user.id.toString(),
            role: user.funcao,
            client: 'API'
        }, code, {
            expiresIn: '24h',
        });
        var roleText = '';
        switch (user.funcao) {
            case 1:
                roleText = 'Member';
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
                name: user.nome + ' ' + user.sobrenome,
                email: user.email,
                role: roleText,
                picture: user.foto
            }
        });
    }
    catch (error) {
        console.error('Erro durante o login:', error);
        res.status(500).json({ message: 'Erro interno do servidor.' });
    }
}));
exports.routerAuth.post('/create', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b;
    const { email, senha, nome, sobrenome, nascimento, registro } = req.body;
    try {
        const canCreateUser = yield checkCanCreateuser(email, registro);
        if (!canCreateUser.canCreate) {
            (0, logger_1.Logger)('auth/create', `400 - Erro - Motivo: ${canCreateUser.reason} | email: ${email} | registro: ${registro}`, "error");
            console.log(`Motivo: ${canCreateUser.reason} | email: ${email} | registro: ${registro}`);
            return res.status(400).json({ message: canCreateUser.reason });
        }
        const hashedPassword = yield bcrypt.hash(senha, 10);
        const createdUser = yield prismaClient_1.default.usuario.create({
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
        (0, logger_1.Logger)('auth/create', `Usuário criado com sucesso! ${JSON.stringify({ user: createdUser })}`, "success", createdUser.id);
        (0, timeline_2.Timeline)('Bem vindo(a) à secretaria online do SEPT!', createdUser.id.toString(), 'Sua conta foi registrada com sucesso e atrelada ao registro ' + registro, Number(timeline_1.TimelineTypes.ACCOUNT_CREATION), createdUser.id);
        (0, sendEmail_1.SendEmail)(createdUser.email, 'Bem-vindo(a) à secretaria online do SEPT!', 'Este é um teste!', Number(createdUser.id), Number(emails_1.EmailTypes.ACCOUNT_CREATION));
        res.status(201).json({ user: createdUser });
    }
    catch (error) {
        if (error instanceof client_1.Prisma.PrismaClientKnownRequestError && error.code === 'P2002') {
            (0, logger_1.Logger)('auth/create', `400 - Erro - O ${(_a = error.meta) === null || _a === void 0 ? void 0 : _a.target} já está em uso.`, "error");
            res.status(400).json({ message: `O ${(_b = error.meta) === null || _b === void 0 ? void 0 : _b.target} já está em uso.` });
        }
        else {
            (0, logger_1.Logger)('auth/create', `500 - Erro - O ${error}`, "error");
            console.error('Erro durante a criação de usuário:', error);
            res.status(500).json({ message: 'Erro interno do servidor.' });
        }
    }
}));
function checkCanCreateuser(email, registro) {
    return __awaiter(this, void 0, void 0, function* () {
        const hasEmail = yield prismaClient_1.default.usuario.findFirst({
            where: {
                email
            }
        });
        const hasRegister = yield prismaClient_1.default.usuario.findFirst({
            where: {
                registro
            }
        });
        if (hasEmail) {
            return {
                'canCreate': false,
                'reason': 'Email já cadastrado para outro usuário!'
            };
        }
        else {
            if (hasRegister) {
                return {
                    'canCreate': false,
                    'reason': 'Registro já atrelado a outro usuário!'
                };
            }
            else {
                return {
                    'canCreate': true,
                    'reason': 'Registro já atrelado a outro usuário!'
                };
            }
        }
    });
}
function sessionGenerator(usuario, req) {
    return __awaiter(this, void 0, void 0, function* () {
        const randomCode = generateRandomCode(8);
        try {
            const dataAtual = new Date();
            let ip = req.headers['x-forwarded-for'] || req.socket.remoteAddress;
            if (Array.isArray(ip)) {
                ip = ip[0];
            }
            const ipInfo = yield getIpInfo(ip);
            const saveSession = yield prismaClient_1.default.logins.create({
                data: {
                    chave_sessao: randomCode,
                    usuario,
                    data: dataAtual,
                    local: ipInfo,
                    ip: ip !== null && ip !== void 0 ? ip : 'unset'
                }
            });
            return randomCode;
        }
        catch (error) {
            console.log(error);
            return 'Error';
        }
    });
}
// Função para pegar as informações do IP usando a API ipinfo.io
function getIpInfo(ip) {
    var _a;
    return __awaiter(this, void 0, void 0, function* () {
        // Verifica se o IP é localhost (IPv4 ou IPv6)
        if (ip === '::1' || ip === '127.0.0.1') {
            return 'Localhost';
        }
        try {
            const response = yield axios_1.default.get(`https://ipinfo.io/${ip}/json?token=YOUR_TOKEN_HERE`);
            const { city, region, country } = response.data;
            return `${city}, ${region}, ${country}`;
        }
        catch (error) {
            if (axios_1.default.isAxiosError(error)) {
                console.error('Erro ao buscar informações do IP (Axios):', ((_a = error.response) === null || _a === void 0 ? void 0 : _a.data) || error.message);
            }
            else {
                console.error('Erro ao buscar informações do IP:', error.message);
            }
            return 'Informações de IP não disponíveis';
        }
    });
}
function generateRandomCode(length) {
    return crypto.randomBytes(length).toString('hex');
}
