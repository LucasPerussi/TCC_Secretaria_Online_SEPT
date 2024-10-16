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
exports.routerTrainingHours = void 0;
const express_1 = require("express");
const JWTVerifier_1 = require("../../middlewares/JWTVerifier");
const prismaClient_1 = __importDefault(require("../../prismaClient")); // Adjust the path as necessary
const logger_1 = require("../../middlewares/logger");
// const prisma = new PrismaClient();
exports.routerTrainingHours = (0, express_1.Router)();
exports.routerTrainingHours.get('/', (req, res) => res.send('API de Registro de horas formativas'));
exports.routerTrainingHours.post('/new', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { aluno, data_evento, horas_solicitadas, descricao, tipo, comprovante } = req.body;
    const data_envio = new Date();
    try {
        const newRecord = yield prismaClient_1.default.horas_formativas.create({
            data: {
                aluno,
                data_envio,
                horas_solicitadas,
                data_evento: new Date(data_evento),
                descricao,
                tipo,
                comprovante,
            },
        });
        (0, logger_1.Logger)('POST - HOURS - /new', `200 - New training hours record created: ID ${newRecord.id}`, 'success');
        res.status(200).send({ message: 'Horas formativas criadas com sucesso!', record: newRecord });
    }
    catch (error) {
        if (error instanceof Error) {
            (0, logger_1.Logger)('POST - HOURS - /new', `500 - Error creating training hours record: ${error.message}`, 'error');
            console.error('Error creating training hours record:', error.message);
            res.status(500).send({ message: 'Erro ao criar horas formativas', error: error.message });
        }
        else {
            (0, logger_1.Logger)('POST - HOURS - /new', '500 - Unknown error occurred', 'error');
            console.error('Unknown error:', error);
            res.status(500).send({ message: 'Erro ao criar horas formativas', error: 'Unknown error' });
        }
    }
}));
exports.routerTrainingHours.delete('/id/:id', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const recordId = Number(req.params.id);
    try {
        const recordData = yield prismaClient_1.default.horas_formativas.delete({
            where: { id: recordId },
        });
        if (recordData) {
            (0, logger_1.Logger)(`DELETE - HOURS - id/${recordId}`, `200 - Found and Authorized`, 'success');
            res.status(200).json(recordData);
        }
        else {
            (0, logger_1.Logger)(`DELETE - HOURS - id/${recordId}`, `404 - Not Found`, 'error');
            res.status(404).send({ error: true, message: 'Registro não encontrado!' });
        }
    }
    catch (error) {
        if (error instanceof Error) {
            (0, logger_1.Logger)(`DELETE - HOURS - id/${recordId}`, `500 - Error fetching record: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: error.message });
        }
        else {
            (0, logger_1.Logger)(`DELETE - HOURS - id/${recordId}`, '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: 'Unknown error' });
        }
    }
}));
exports.routerTrainingHours.get('/id/:id', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const recordId = Number(req.params.id);
    try {
        const recordData = yield prismaClient_1.default.horas_formativas.findFirst({
            where: { id: recordId },
        });
        if (recordData) {
            (0, logger_1.Logger)(`GET - HOURS - id/${recordId}`, `200 - Found and Authorized`, 'success');
            res.status(200).json(recordData);
        }
        else {
            (0, logger_1.Logger)(`GET - HOURS - id/${recordId}`, `404 - Not Found`, 'error');
            res.status(404).send({ error: true, message: 'Registro não encontrado!' });
        }
    }
    catch (error) {
        if (error instanceof Error) {
            (0, logger_1.Logger)(`GET - HOURS - id/${recordId}`, `500 - Error fetching record: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: error.message });
        }
        else {
            (0, logger_1.Logger)(`GET - HOURS - id/${recordId}`, '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar o registro solicitado.', error: 'Unknown error' });
        }
    }
}));
exports.routerTrainingHours.get('/all', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const records = yield prismaClient_1.default.horas_formativas.findMany();
        (0, logger_1.Logger)('GET - HOURS - all', `200 - Records fetched successfully`, 'success');
        res.status(200).json(records);
    }
    catch (error) {
        if (error instanceof Error) {
            (0, logger_1.Logger)('GET - HOURS - all', `500 - Error fetching records: ${error.message}`, 'error');
            res.status(500).json({ message: 'Erro ao buscar os registros.', error: error.message });
        }
        else {
            (0, logger_1.Logger)('GET - HOURS - all', '500 - Unknown error occurred', 'error');
            res.status(500).json({ message: 'Erro ao buscar os registros.', error: 'Unknown error' });
        }
    }
}));
