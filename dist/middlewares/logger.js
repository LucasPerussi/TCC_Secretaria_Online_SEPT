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
exports.Logger = void 0;
const prismaClient_1 = __importDefault(require("../prismaClient")); // Adjust the path as necessary
const Logger = (funcao, mensagem, status, usuario) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        if (usuario) {
            const userExists = yield prismaClient_1.default.usuario.findUnique({
                where: { id: usuario }
            });
            if (!userExists) {
                throw new Error(`Usuário com ID ${usuario} não encontrado`);
            }
        }
        const registerLog = yield prismaClient_1.default.logs.create({
            data: {
                funcao,
                mensagem,
                usuario: usuario !== null && usuario !== void 0 ? usuario : null,
                status
            }
        });
        return registerLog;
    }
    catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao registrar log:', error.message);
            throw new Error(`Erro ao registrar log: ${error.message}`);
        }
        else {
            console.error('Erro desconhecido ao registrar log:', error);
            throw new Error('Erro desconhecido ao registrar log');
        }
    }
});
exports.Logger = Logger;
