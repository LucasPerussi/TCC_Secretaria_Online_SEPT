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
exports.SendEmail = void 0;
const prismaClient_1 = __importDefault(require("../../prismaClient")); // Adjust the path as necessary
const randomCodeGenerator_1 = require("./randomCodeGenerator");
const SendEmail = (destinatario, titulo, corpo, usuario, operacao) => __awaiter(void 0, void 0, void 0, function* () {
    const emailIdentifier = yield (0, randomCodeGenerator_1.codeGenerator)(15);
    const QueueEmail = yield prismaClient_1.default.fila_emails.create({
        data: {
            destinatario,
            titulo,
            corpo,
            identificador: emailIdentifier,
            usuario: usuario !== null && usuario !== void 0 ? usuario : null,
            operacao
        }
    });
    return QueueEmail;
});
exports.SendEmail = SendEmail;
