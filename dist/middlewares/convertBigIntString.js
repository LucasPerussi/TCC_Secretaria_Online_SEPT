"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.bigIntMiddleware = void 0;
// Middleware para converter BigInt em string nas respostas JSON
const bigIntMiddleware = (req, res, next) => {
    const oldJson = res.json;
    res.json = function (data) {
        const dataStringified = JSON.stringify(data, (key, value) => typeof value === 'bigint' ? value.toString() : value);
        return oldJson.call(this, JSON.parse(dataStringified));
    };
    next();
};
exports.bigIntMiddleware = bigIntMiddleware;
