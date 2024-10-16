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
exports.routerInternship = void 0;
const express_1 = require("express");
const JWTVerifier_1 = require("../../middlewares/JWTVerifier");
const prismaClient_1 = __importDefault(require("../../prismaClient")); // Adjust the path as necessary
const logger_1 = require("../../middlewares/logger");
const randomCodeGenerator_1 = require("../../middlewares/randomCodeGenerator");
const date_fns_1 = require("date-fns");
const checkUserExists_1 = require("../../middlewares/checkUserExists");
const checkCompanyExists_1 = require("../../middlewares/checkCompanyExists");
exports.routerInternship = (0, express_1.Router)();
exports.routerInternship.get('/', (req, res) => res.send('API de Estágio'));
exports.routerInternship.post('/new', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    let { aluno, professor_orientador, empresa, area_atuacao, data_inicio, duracaoMeses } = req.body;
    const codigoEstagio = yield (0, randomCodeGenerator_1.numberGenerator)(10);
    const dataInicioDate = (0, date_fns_1.parseISO)(data_inicio);
    if (!dataInicioDate || isNaN(dataInicioDate.getTime())) {
        return res.status(400).json({ message: 'Data de início inválida.' });
    }
    duracaoMeses = Number(duracaoMeses);
    if (isNaN(duracaoMeses)) {
        return res.status(400).json({ message: 'Duração em meses inválida.' });
    }
    aluno = Number(aluno);
    professor_orientador = Number(professor_orientador);
    empresa = Number(empresa);
    if (isNaN(aluno) || isNaN(professor_orientador) || isNaN(empresa)) {
        return res.status(400).json({ message: 'IDs inválidos fornecidos.' });
    }
    const [studentExists, teacherExists] = yield Promise.all([
        (0, checkUserExists_1.CheckUserExists)(aluno),
        (0, checkUserExists_1.CheckUserExists)(professor_orientador),
    ]);
    if (!studentExists) {
        return res.status(404).json({ message: 'Aluno não encontrado.' });
    }
    if (!teacherExists) {
        return res.status(404).json({ message: 'Professor não encontrado.' });
    }
    const empresaExists = yield (0, checkCompanyExists_1.CheckEmpresaExists)(empresa);
    if (!empresaExists) {
        return res.status(404).json({ message: 'Empresa não encontrada.' });
    }
    const dataRenovacaoDate = (0, date_fns_1.addMonths)(dataInicioDate, duracaoMeses);
    try {
        const newInternship = yield prismaClient_1.default.estagio.create({
            data: {
                aluno,
                professor_orientador,
                empresa,
                area_atuacao,
                data_inicio: dataInicioDate,
                data_renovacao: dataRenovacaoDate,
                codigo_estagio: Number(codigoEstagio)
            }
        });
        res.status(200).send({ message: 'Estágio criado com sucesso', estagio: newInternship });
    }
    catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar estágio:', error.message);
            res.status(500).send({ message: 'Erro ao criar estágio', error: error.message });
        }
        else {
            console.error('Erro ao criar estágio: Erro desconhecido');
            res.status(500).send({ message: 'Erro ao criar estágio', error: 'Erro desconhecido' });
        }
    }
}));
exports.routerInternship.get('/id/:id', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const id = Number(req.params.id);
    try {
        const internshipData = yield prismaClient_1.default.estagio.findFirst({
            where: {
                id: id
            }
        });
        if (internshipData) {
            (0, logger_1.Logger)(`GET - INTERNSHIP - id/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(internshipData));
        }
        else {
            (0, logger_1.Logger)(`GET - INTERNSHIP - id/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Internship not found!' });
        }
    }
    catch (error) {
        (0, logger_1.Logger)(`GET - INTERNSHIP - id/${id}`, `Error fetching requested Internship. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Internship.' });
    }
}));
exports.routerInternship.get('/code/:code', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const code = Number(req.params.code);
    try {
        const internshipData = yield prismaClient_1.default.estagio.findFirst({
            where: {
                codigo_estagio: code
            }
        });
        if (internshipData) {
            (0, logger_1.Logger)(`GET - INTERNSHIP - code/${code}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(internshipData));
        }
        else {
            (0, logger_1.Logger)(`GET - INTERNSHIP - code/${code}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Internship not found!' });
        }
    }
    catch (error) {
        (0, logger_1.Logger)(`GET - INTERNSHIP - code/${code}`, `Error fetching requested Internship. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Internship.' });
    }
}));
exports.routerInternship.get('/all-internships', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const internshipData = yield prismaClient_1.default.estagio.findMany();
        if (internshipData) {
            (0, logger_1.Logger)(`GET - INTERNSHIPS - all-internships`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(internshipData));
        }
        else {
            (0, logger_1.Logger)(`GET - INTERNSHIPS - all-internships`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'No internship found' });
        }
    }
    catch (error) {
        (0, logger_1.Logger)(`GET - INTERNSHIPS - all-internships`, `Error fetching internships. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching internships.' });
    }
}));
exports.routerInternship.get('/all/:user', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const user = Number(req.params.user);
    try {
        const InternshipData = yield prismaClient_1.default.estagio.findMany({
            where: {
                aluno: user
            }
        });
        if (InternshipData) {
            (0, logger_1.Logger)(`GET - INTERNSHIP - internships/${user}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(InternshipData));
        }
        else {
            (0, logger_1.Logger)(`GET - INTERNSHIP - internships/${user}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Internship not found!' });
        }
    }
    catch (error) {
        (0, logger_1.Logger)(`GET - INTERNSHIP - internships/${user}`, `Error fetching requested user. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested user.' });
    }
}));
