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
exports.routerCompanies = void 0;
const express_1 = require("express");
const JWTVerifier_1 = require("../../middlewares/JWTVerifier");
const prismaClient_1 = __importDefault(require("../../../prismaClient")); // Adjust the path as necessary
const logger_1 = require("../../middlewares/logger");
exports.routerCompanies = (0, express_1.Router)();
exports.routerCompanies.get('/', (req, res) => res.send('API de empresas'));
exports.routerCompanies.post('/new', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    let { nome, cnpj, emailContato, tipo } = req.body;
    if (!nome || nome.trim() === '') {
        return res.status(400).send({ message: 'Nome é obrigatório.' });
    }
    if (!cnpj || cnpj.trim() === '') {
        return res.status(400).send({ message: 'CNPJ é obrigatório.' });
    }
    try {
        const newCompany = yield prismaClient_1.default.empresas.create({
            data: {
                nome,
                cnpj: cnpj ? cnpj : 'Não informado',
                email_contato: emailContato ? emailContato : 'Não informado',
                tipo: tipo ? tipo : 99
            }
        });
        (0, logger_1.Logger)('GET - COMPANY -/new', `200 - Nova empresa cadastrada: ${newCompany.nome}`, "success");
        res.status(200).send({ message: 'Empresa criada com sucesso!', empresa: { newCompany } });
    }
    catch (error) {
        if (error instanceof Error) {
            (0, logger_1.Logger)('GET - COMPANY - /new', `500 - Erro ao cadastrar nova empresa: ${error.message}`, "error");
            console.error('Erro ao cadastrar empresa:', error.message);
            res.status(500).send({ message: 'Erro ao enviar email', error: error.message });
        }
        else {
            (0, logger_1.Logger)('GET - COMPANY - /new', `500 - Erro ao cadastrar nova empresa: ${JSON.stringify(error)}`, "error");
            console.error('Erro ao ecadastrar empresa: Erro desconhecido');
            res.status(500).send({ message: 'Erro ao enviar email', error: 'Erro desconhecido' });
        }
    }
}));
exports.routerCompanies.get('/id/:id', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const companyId = Number(req.params.id);
    try {
        const companyData = yield prismaClient_1.default.empresas.findFirst({
            where: {
                id: companyId
            }
        });
        if (companyData) {
            (0, logger_1.Logger)(`GET - COMPANY - id/${companyId}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(companyData));
        }
        else {
            (0, logger_1.Logger)(`GET - COMPANY - id/${companyId}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Company not found!' });
        }
    }
    catch (error) {
        (0, logger_1.Logger)(`GET - COMPANY - id/${companyId}`, `Error fetching requested company. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested company.' });
    }
}));
exports.routerCompanies.get('/all', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const companyData = yield prismaClient_1.default.empresas.findMany();
        if (companyData) {
            (0, logger_1.Logger)(`GET - COMPANY - all-companies`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(companyData));
        }
        else {
            (0, logger_1.Logger)(`GET - COMPANY - all-companies`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'No company found' });
        }
    }
    catch (error) {
        (0, logger_1.Logger)(`GET - COMPANY - all-companies`, `Error fetching companies. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching companies.' });
    }
}));
