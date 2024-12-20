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
exports.Timeline = void 0;
const prismaClient_1 = __importDefault(require("../prismaClient")); // Adjust the path as necessary
const Timeline = (titulo, referencia, descricao, tipo, usuario) => __awaiter(void 0, void 0, void 0, function* () {
    const registerTimeline = yield prismaClient_1.default.timelines.create({
        data: {
            titulo,
            referencia,
            descricao,
            tipo,
            usuario
        }
    });
    return registerTimeline;
});
exports.Timeline = Timeline;
