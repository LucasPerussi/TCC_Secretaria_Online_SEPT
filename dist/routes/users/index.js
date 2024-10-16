"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.routerUsers = void 0;
const express_1 = require("express");
exports.routerUsers = (0, express_1.Router)();
exports.routerUsers.get('/', (req, res) => res.send('API de usuários'));
