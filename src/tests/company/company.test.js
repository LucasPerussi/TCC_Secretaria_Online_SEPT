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
const prismaClient_1 = __importDefault(require("../../../prismaClient"));
// Função de delay
function delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}
describe('Company API', () => {
    let token;
    let createdCompanyId; // Declarar fora para ser usada nos testes seguintes
    beforeAll(() => __awaiter(void 0, void 0, void 0, function* () {
        // Primeiro, faça login para obter o token JWT
        const loginResponse = yield (0, supertest_1.default)(app_1.app)
            .post('/auth/login')
            .send({
            email: 'teste@teste.com',
            senha: 'senha123'
        });
        expect(loginResponse.status).toBe(200);
        token = loginResponse.body.token;
        // Limpar a tabela de empresas antes dos testes
        yield prismaClient_1.default.empresas.deleteMany({});
    }));
    afterAll(() => __awaiter(void 0, void 0, void 0, function* () {
        // Desconecta o Prisma ao final dos testes
        yield prismaClient_1.default.$disconnect();
    }));
    describe('POST /companies/new', () => {
        it('deve criar uma nova empresa e depois retornar essa empresa pelo ID', () => __awaiter(void 0, void 0, void 0, function* () {
            // Cria uma nova empresa
            const createResponse = yield (0, supertest_1.default)(app_1.app)
                .post('/companies/new')
                .set('Authorization', `${token}`)
                .send({
                nome: 'Empresa Teste',
                cnpj: '12345678901234',
                emailContato: 'contato@empresa.com',
                tipo: 1,
            });
            console.log('Response da criação:', createResponse.body);
            createdCompanyId = createResponse.body.empresa.newCompany.id; // Armazena o ID fora do teste
            // Adiciona um delay de 1 segundo para garantir que o dado esteja disponível
            yield delay(1000);
            // Tenta buscar a empresa recém-criada pelo ID
            const response = yield (0, supertest_1.default)(app_1.app)
                .get(`/companies/id/${createdCompanyId}`)
                .set('Authorization', `${token}`);
            console.log('Response da empresa específica:', response.body);
            expect(response.status).toBe(200);
            expect(response.body).toHaveProperty('id', createdCompanyId); // Verifique se o ID é o correto
        }));
        it('deve retornar erro ao criar empresa com dados inválidos', () => __awaiter(void 0, void 0, void 0, function* () {
            const response = yield (0, supertest_1.default)(app_1.app)
                .post('/companies/new')
                .set('Authorization', `${token}`)
                .send({
                nome: '',
                cnpj: '12345678901234',
                emailContato: 'contato@empresa.com',
                tipo: 1
            });
            expect(response.status).toBe(400); // Verifique se sua API realmente retorna 400 para validação de campos
            expect(response.body).toHaveProperty('message');
        }));
    });
    // describe('GET /companies/id/:id', () => {
    //   it('deve retornar os dados de uma empresa específica', async () => {
    //     const response = await request(app)
    //       .get(`/companies/id/${createdCompanyId}`)
    //       .set('Authorization', `${token}`);
    //     console.log('Response da empresa específica:', response.body); // Depuração
    //     expect(response.status).toBe(200);
    //     expect(response.body).toHaveProperty('id', createdCompanyId); // Verificar o ID correto
    //   });
    //   it('deve retornar erro ao buscar uma empresa inexistente', async () => {
    //     const invalidId = 999999; // ID que não existe
    //     const response = await request(app)
    //       .get(`/companies/id/${invalidId}`)
    //       .set('Authorization', `${token}`);
    //     expect(response.status).toBe(404);
    //     expect(response.body).toHaveProperty('message', 'Company not found!');
    //   });
    // });
    // describe('GET /companies/all', () => {
    //   it('deve retornar todas as empresas', async () => {
    //     const response = await request(app)
    //       .get('/companies/all')
    //       .set('Authorization', `${token}`);
    //     // Exibe a resposta para depuração
    //     console.log('Response Body:', response.body);
    //     // Verifica o status
    //     expect(response.status).toBe(200);
    //     // Verifica se a resposta é um array (o que você espera)
    //     expect(Array.isArray(response.body)).toBe(true);
    //     // Verifica se há pelo menos uma empresa no array
    //     expect(response.body.length).toBeGreaterThan(0);
    //     // Verifica a estrutura de um item no array
    //     expect(response.body[0]).toHaveProperty('id');
    //     expect(response.body[0]).toHaveProperty('nome');
    //   });
    // });
});
