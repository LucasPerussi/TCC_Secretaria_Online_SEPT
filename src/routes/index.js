"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.router = void 0;
const express_1 = require("express");
exports.router = (0, express_1.Router)();
const welcome = [
    {
        mensagem: "Seja bem-vindo (a) à API da Secretaria Online do SEPT",
        contato: "perussilucas@hotmail.com",
        status: "API Online"
    },
];
exports.router.get('/', (req, res) => res.send(JSON.stringify(welcome)));
