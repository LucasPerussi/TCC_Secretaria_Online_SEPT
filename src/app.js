"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.app = void 0;
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const morgan_1 = __importDefault(require("morgan"));
const index_1 = require("./routes/index");
const index_2 = require("./routes/users/index");
const index_3 = require("./routes/auth/index");
const index_4 = require("./routes/system/index");
const index_5 = require("./routes/internship/index");
const index_6 = require("./routes/company/index");
const index_7 = require("./routes/courses/index");
const index_8 = require("./routes/trainingHours/index");
const checkEmailQueue_1 = require("./middlewares/checkEmailQueue");
// cria o app
exports.app = (0, express_1.default)();
// Executa a função de verificação de e-mails
(0, checkEmailQueue_1.checkEmailQueue)();
// ***** Configuração dos middlewares
exports.app.use(express_1.default.json());
// app.use(bigIntMiddleware); // Middleware para conversão de BigInt para string
exports.app.use((0, cors_1.default)());
exports.app.use((0, morgan_1.default)('dev'));
// Integra os endpoints na aplicação
exports.app.use('/', index_1.router);
exports.app.use('/users', index_2.routerUsers);
exports.app.use('/auth', index_3.routerAuth);
exports.app.use('/system', index_4.routerSystem);
exports.app.use('/internship', index_5.routerInternship);
exports.app.use('/companies', index_6.routerCompanies);
exports.app.use('/courses', index_7.routerCourses);
exports.app.use('/hours', index_8.routerTrainingHours);
