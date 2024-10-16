jest.mock('axios', () => ({
  get: jest.fn(() => Promise.resolve({ data: 'mocked IP info' })),
}));

import request from 'supertest';
import { app } from '../../../src/app';
import prisma from '../../prismaClient';

// Função de delay
function delay(ms: number) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

describe('Company API', () => {
  let token: string;
  let createdCompanyId: number; // Declarar fora para ser usada nos testes seguintes

  beforeAll(async () => {
    // Primeiro, faça login para obter o token JWT
    const loginResponse = await request(app)
      .post('/auth/login')
      .send({
        email: 'teste@teste.com',
        senha: 'senha123'
      });

    expect(loginResponse.status).toBe(200);
    token = loginResponse.body.token;

    // Limpar a tabela de empresas antes dos testes
    await prisma.empresas.deleteMany({});
  });

  afterAll(async () => {
    // Desconecta o Prisma ao final dos testes
    await prisma.$disconnect();
  });

  describe('POST /companies/new', () => {
    it('deve criar uma nova empresa e depois retornar essa empresa pelo ID', async () => {
      // Cria uma nova empresa
      const createResponse = await request(app)
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
      await delay(1000);

      // Tenta buscar a empresa recém-criada pelo ID
      const response = await request(app)
        .get(`/companies/id/${createdCompanyId}`)
        .set('Authorization', `${token}`);

      console.log('Response da empresa específica:', response.body);

      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('id', createdCompanyId); // Verifique se o ID é o correto
    });

    it('deve retornar erro ao criar empresa com dados inválidos', async () => {
      const response = await request(app)
        .post('/companies/new')
        .set('Authorization', `${token}`)
        .send({
          nome: '', // Nome é obrigatório
          cnpj: '12345678901234',
          emailContato: 'contato@empresa.com',
          tipo: 1
        });

      expect(response.status).toBe(400); // Verifique se sua API realmente retorna 400 para validação de campos
      expect(response.body).toHaveProperty('message');
    });
  });

  describe('GET /companies/id/:id', () => {
    it('deve retornar os dados de uma empresa específica', async () => {
      const response = await request(app)
        .get(`/companies/id/${createdCompanyId}`)
        .set('Authorization', `${token}`);

      console.log('Response da empresa específica:', response.body); // Depuração
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('id', createdCompanyId); // Verificar o ID correto
    });

    it('deve retornar erro ao buscar uma empresa inexistente', async () => {
      const invalidId = 999999; // ID que não existe
      const response = await request(app)
        .get(`/companies/id/${invalidId}`)
        .set('Authorization', `${token}`);

      expect(response.status).toBe(404);
      expect(response.body).toHaveProperty('message', 'Company not found!');
    });
  });

  describe('GET /companies/all', () => {
    it('deve retornar todas as empresas', async () => {
      const response = await request(app)
        .get('/companies/all')
        .set('Authorization', `${token}`);

      // Exibe a resposta para depuração
      console.log('Response Body:', response.body);

      // Verifica o status
      expect(response.status).toBe(200);

      // Verifica se a resposta é um array (o que você espera)
      expect(Array.isArray(response.body)).toBe(true);

      // Verifica se há pelo menos uma empresa no array
      expect(response.body.length).toBeGreaterThan(0);

      // Verifica a estrutura de um item no array
      expect(response.body[0]).toHaveProperty('id');
      expect(response.body[0]).toHaveProperty('nome');
    });
  });
});
