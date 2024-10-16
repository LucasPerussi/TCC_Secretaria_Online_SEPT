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
jest.mock('axios', () => ({
    get: jest.fn(() => Promise.resolve({ data: 'mocked IP info' })),
}));
const supertest_1 = __importDefault(require("supertest"));
const app_1 = require("../../../src/app");
const prismaClient_1 = __importDefault(require("../../prismaClient"));
// Função para gerar um e-mail único com base na data e um código aleatório
function generateUniqueEmail() {
    const now = new Date();
    const day = String(now.getDate()).padStart(2, '0');
    const hourMin = `${String(now.getHours()).padStart(2, '0')}${String(now.getMinutes()).padStart(2, '0')}`;
    const randomCode = Math.random().toString(36).substring(2, 6);
    return `teste${day}${hourMin}${randomCode}@teste.com`;
}
function generateUniqueRegister() {
    const now = new Date();
    const day = String(now.getDate()).padStart(2, '0');
    const hourMin = `${String(now.getHours()).padStart(2, '0')}${String(now.getMinutes()).padStart(2, '0')}`;
    const randomCode = Math.random().toString(36).substring(2, 6);
    return `GRR${day}${hourMin}${randomCode}`;
}
describe('Auth API', () => {
    let token;
    let uniqueRegister;
    let uniqueEmail;
    const password = 'senha123';
    beforeAll(() => __awaiter(void 0, void 0, void 0, function* () {
        // Primeiro, criar um novo usuário
        uniqueEmail = generateUniqueEmail();
        uniqueRegister = generateUniqueRegister();
        const response = yield (0, supertest_1.default)(app_1.app)
            .post('/auth/create')
            .send({
            email: uniqueEmail,
            senha: password,
            nome: 'Novo',
            sobrenome: 'Usuario',
            nascimento: '1990-01-01',
            registro: uniqueRegister
        });
        expect(response.status).toBe(201);
        expect(response.body).toHaveProperty('user');
        expect(response.body.user).toHaveProperty('id');
    }));
    afterAll(() => __awaiter(void 0, void 0, void 0, function* () {
        // Limpeza após os testes
        yield prismaClient_1.default.$disconnect();
    }));
    it('deve fazer login com o usuário recém-criado e retornar um token JWT', () => __awaiter(void 0, void 0, void 0, function* () {
        const response = yield (0, supertest_1.default)(app_1.app)
            .post('/auth/login')
            .send({
            email: uniqueEmail,
            senha: password
        });
        expect(response.status).toBe(200);
        expect(response.body).toHaveProperty('token');
        token = response.body.token;
    }));
    it('deve retornar erro para credenciais incorretas', () => __awaiter(void 0, void 0, void 0, function* () {
        const response = yield (0, supertest_1.default)(app_1.app)
            .post('/auth/login')
            .send({
            email: uniqueEmail,
            senha: 'senhaIncorreta'
        });
        expect(response.status).toBe(401);
        expect(response.body).toHaveProperty('message', 'Senha incorreta.');
    }));
    it('deve retornar erro ao criar um usuário com email já existente', () => __awaiter(void 0, void 0, void 0, function* () {
        const response = yield (0, supertest_1.default)(app_1.app)
            .post('/auth/create')
            .send({
            email: uniqueEmail,
            senha: 'senha123',
            nome: 'Novo',
            sobrenome: 'Usuario',
            nascimento: '1990-01-01',
            registro: '654321'
        });
        expect(response.status).toBe(400);
        expect(response.body).toHaveProperty('message', 'Email já cadastrado para outro usuário!');
    }));
});
