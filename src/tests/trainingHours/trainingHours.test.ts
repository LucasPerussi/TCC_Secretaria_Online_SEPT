import request from 'supertest';
import { app } from '../../../src/app';
import prisma from '../../../prismaClient';

describe('Training Hours API', () => {
  let token: string;
  let createdRecordId: number;

  beforeAll(async () => {
    token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiMjQiLCJyb2xlIjoxLCJjbGllbnQiOiJBUEkiLCJpYXQiOjE3Mjg2NzgxMTMsImV4cCI6MTcyODc2NDUxM30.B291uGeaz4BtxfrI5CuioPHl2qrUalk-JKEInajY88Q';
    // Limpar a tabela antes dos testes
    await prisma.horas_formativas.deleteMany({});
  });

  afterAll(async () => {
    // Limpeza após os testes
    await prisma.$disconnect();
  });

  describe('POST /hours/new', () => {
    it('deve criar um novo registro de horas formativas', async () => {
      const response = await request(app)
        .post('/hours/new')
        .set('Authorization', `${token}`)
        .send({
          aluno: 1,
          data_evento: '2023-10-12',
          horas_solicitadas: 5,
          descricao: 'Participação em workshop',
          tipo: 2,
          comprovante: 'comprovante_base64',
        });

      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('record');
      expect(response.body.record).toHaveProperty('id');

      // Salvar o ID para usar em outros testes
      createdRecordId = response.body.record.id;
    });

    it('deve retornar erro ao criar registro com campos faltando', async () => {
      const response = await request(app)
        .post('/hours/new')
        .set('Authorization', `${token}`)
        .send({
          // Campos obrigatórios estão faltando
          aluno: 1,
          data_evento: '2023-10-12',
          // horas_solicitadas está faltando
          descricao: 'Participação em workshop',
          tipo: 2,
          comprovante: 'comprovante_base64',
        });

      expect(response.status).toBe(400); // Ou o código de status que sua API retorna para erros de validação
      expect(response.body).toHaveProperty('message');
    });
  });

  describe('GET /hours/id/:id', () => {
    it('deve retornar um registro específico de horas formativas', async () => {
      const response = await request(app)
        .get(`/hours/id/${createdRecordId}`)
        .set('Authorization', `${token}`);

      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('id', createdRecordId);
    });

    it('deve retornar erro ao buscar registro inexistente', async () => {
      const invalidId = 999999; // ID que não existe
      const response = await request(app)
        .get(`/hours/id/${invalidId}`)
        .set('Authorization', `${token}`);

      expect(response.status).toBe(404);
      expect(response.body).toHaveProperty('message', 'Registro não encontrado!');
    });
  });

  describe('GET /hours/all', () => {
    it('deve retornar todos os registros de horas formativas', async () => {
      const response = await request(app)
        .get('/hours/all')
        .set('Authorization', `${token}`);

      expect(response.status).toBe(200);
      expect(Array.isArray(response.body)).toBe(true);
      expect(response.body.length).toBeGreaterThanOrEqual(1);
    });
  });

  describe('DELETE /hours/id/:id', () => {
    it('deve deletar um registro de horas formativas', async () => {
      const response = await request(app)
        .delete(`/hours/id/${createdRecordId}`)
        .set('Authorization', `${token}`);

      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('id', createdRecordId);
    });

    it('deve retornar erro ao deletar registro inexistente', async () => {
      const invalidId = 999999; // ID que não existe
      const response = await request(app)
        .delete(`/hours/id/${invalidId}`)
        .set('Authorization', `${token}`);

      expect(response.status).toBe(500); // Ou 404, dependendo de como sua API lida com isso
      expect(response.body).toHaveProperty('message');
    });
  });

  describe('Autenticação', () => {
    it('deve retornar erro ao acessar endpoint sem token JWT', async () => {
      const response = await request(app)
        .get('/hours/all');

      expect(response.status).toBe(401); // Código de status para não autorizado
      expect(response.body).toHaveProperty('message', 'Token não fornecido');
    });
  });
});
