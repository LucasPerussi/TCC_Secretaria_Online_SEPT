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
Object.defineProperty(exports, "__esModule", { value: true });
exports.HashMD5Generator = exports.numberGenerator = exports.codeGenerator = void 0;
const crypto = require('crypto');
const codeGenerator = (length) => __awaiter(void 0, void 0, void 0, function* () {
    var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var code = '';
    for (var i = 0; i < length; i++) {
        code += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return code;
});
exports.codeGenerator = codeGenerator;
const numberGenerator = (length) => __awaiter(void 0, void 0, void 0, function* () {
    var chars = '0123456789';
    var code = '';
    for (var i = 0; i < length; i++) {
        code += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return code;
});
exports.numberGenerator = numberGenerator;
const HashMD5Generator = (data) => __awaiter(void 0, void 0, void 0, function* () {
    const hash = crypto.createHash('md5');
    hash.update(data);
    return hash.digest('hex');
});
exports.HashMD5Generator = HashMD5Generator;
