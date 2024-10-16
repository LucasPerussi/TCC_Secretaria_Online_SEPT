jest.mock('axios', () => ({
  get: jest.fn(() => Promise.resolve({ data: 'mocked IP info' })),
}));

import request from 'supertest';
import { app } from '../../../src/app';
import prisma from '../../prismaClient';

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
  let token: string;
  let uniqueRegister: string;
  let uniqueEmail: string;
  const password = 'senha123';

  beforeAll(async () => {
    // Primeiro, criar um novo usuário
    uniqueEmail = generateUniqueEmail();
    uniqueRegister = generateUniqueRegister();
    const response = await request(app)
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
  });

  afterAll(async () => {
    // Limpeza após os testes
    await prisma.$disconnect();
  });

  it('deve fazer login com o usuário recém-criado e retornar um token JWT', async () => {
    const response = await request(app)
      .post('/auth/login')
      .send({
        email: uniqueEmail,
        senha: password
      });

    expect(response.status).toBe(200);
    expect(response.body).toHaveProperty('token');
    token = response.body.token;
  });

  it('deve retornar erro para credenciais incorretas', async () => {
    const response = await request(app)
      .post('/auth/login')
      .send({
        email: uniqueEmail,
        senha: 'senhaIncorreta'
      });

    expect(response.status).toBe(401);
    expect(response.body).toHaveProperty('message', 'Senha incorreta.');
  });

  it('deve retornar erro ao criar um usuário com email já existente', async () => {
    const response = await request(app)
      .post('/auth/create')
      .send({
        email: uniqueEmail, // Tentando criar usuário com email já existente
        senha: 'senha123',
        nome: 'Novo',
        sobrenome: 'Usuario',
        nascimento: '1990-01-01',
        registro: '654321'
      });

    expect(response.status).toBe(400);
    expect(response.body).toHaveProperty('message', 'Email já cadastrado para outro usuário!');
  });
});
