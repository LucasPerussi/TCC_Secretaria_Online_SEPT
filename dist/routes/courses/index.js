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
exports.routerCourses = void 0;
const express_1 = require("express");
const JWTVerifier_1 = require("../../middlewares/JWTVerifier");
const prismaClient_1 = __importDefault(require("../../prismaClient")); // Adjust the path as necessary
const logger_1 = require("../../middlewares/logger");
const randomCodeGenerator_1 = require("../../middlewares/randomCodeGenerator");
exports.routerCourses = (0, express_1.Router)();
exports.routerCourses.get('/', (req, res) => res.send('API de Cursos'));
exports.routerCourses.post('/new', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { nome, descricao, coordenador, horas_formativas, semestres } = req.body;
    try {
        const identificador = yield (0, randomCodeGenerator_1.codeGenerator)(8);
        const newCourse = yield prismaClient_1.default.curso.create({
            data: {
                nome,
                descricao,
                coordenador: Number(coordenador),
                identificador,
                horas_formativas: Number(horas_formativas),
                semestres,
                criado_em: new Date(),
            }
        });
        (0, logger_1.Logger)('GET - COURSES - /new', `200 - novo curso cadastrado: ${newCourse.nome}`, "success");
        res.status(200).send({ message: 'curso criado com sucesso!', curso: { newCourse } });
    }
    catch (error) {
        if (error instanceof Error) {
            (0, logger_1.Logger)('GET - COURSES - /new', `500 - Erro ao cadastrar novo curso: ${error.message}`, "error");
            console.error('Erro ao cadastrar curso:', error.message);
            res.status(500).send({ message: 'Erro ao enviar email', error: error.message });
        }
        else {
            (0, logger_1.Logger)('GET - COURSES - /new', `500 - Erro ao cadastrar novo curso: ${JSON.stringify(error)}`, "error");
            console.error('Erro ao cadastrar curso: Erro desconhecido');
            res.status(500).send({ message: 'Erro ao enviar email', error: 'Erro desconhecido' });
        }
    }
}));
exports.routerCourses.get('/id/:id', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const id = Number(req.params.id);
    try {
        const courseData = yield prismaClient_1.default.curso.findFirst({
            where: {
                id: id
            }
        });
        if (courseData) {
            (0, logger_1.Logger)(`GET - COURSES - id/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(courseData));
        }
        else {
            (0, logger_1.Logger)(`GET - COURSES - id/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Course not found!' });
        }
    }
    catch (error) {
        (0, logger_1.Logger)(`GET - COURSES - id/${id}`, `Error fetching requested course. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested course.' });
    }
}));
exports.routerCourses.delete('/id/:id', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const id = Number(req.params.id);
    try {
        const courseData = yield prismaClient_1.default.curso.delete({
            where: {
                id: id
            }
        });
        if (courseData) {
            (0, logger_1.Logger)(`DELETE - COURSES - id/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(courseData));
        }
        else {
            (0, logger_1.Logger)(`DELETE - COURSES - id/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Course not found!' });
        }
    }
    catch (error) {
        (0, logger_1.Logger)(`DELETE - COURSES - id/${id}`, `Error deleting requested course. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error deleting requested course.' });
    }
}));
exports.routerCourses.delete('/identifier/:identifier', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const identifier = req.params.identifier;
    try {
        const courseData = yield prismaClient_1.default.curso.delete({
            where: {
                identificador: identifier
            }
        });
        if (courseData) {
            (0, logger_1.Logger)(`DELETE - COURSES - id/${identifier}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(courseData));
        }
        else {
            (0, logger_1.Logger)(`DELETE - COURSES - id/${identifier}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Course not found!' });
        }
    }
    catch (error) {
        (0, logger_1.Logger)(`DELETE - COURSES - id/${identifier}`, `Error deleting requested course. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error deleting requested course.' });
    }
}));
exports.routerCourses.get('/identifier/:identifier', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const identifier = req.params.identifier;
    try {
        const courseData = yield prismaClient_1.default.curso.findFirst({
            where: {
                identificador: identifier
            }
        });
        if (courseData) {
            (0, logger_1.Logger)(`GET - COURSES - id/${identifier}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(courseData));
        }
        else {
            (0, logger_1.Logger)(`GET - COURSES - id/${identifier}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Course not found!' });
        }
    }
    catch (error) {
        (0, logger_1.Logger)(`GET - COURSES - id/${identifier}`, `Error fetching requested course. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested course.' });
    }
}));
exports.routerCourses.get('/all', JWTVerifier_1.validateJWT, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const CourseData = yield prismaClient_1.default.curso.findMany();
        if (CourseData) {
            (0, logger_1.Logger)(`GET - Course - all-courses`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(CourseData));
        }
        else {
            (0, logger_1.Logger)(`GET - Course - all-courses`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'No Course found' });
        }
    }
    catch (error) {
        (0, logger_1.Logger)(`GET - Course - all-courses`, `Error fetching courses. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching courses.' });
    }
}));
