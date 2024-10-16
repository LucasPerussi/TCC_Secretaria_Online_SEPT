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
exports.extractUserDataFromToken = exports.validateJWT = exports.getSessionKey = exports.extractUserFromToken = void 0;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken")); // Import 'Secret' type from 'jsonwebtoken'
const prismaClient_1 = __importDefault(require("../prismaClient")); // Adjust the path as necessary
const extractUserFromToken = (token) => {
    try {
        const decoded = jsonwebtoken_1.default.decode(token);
        if (decoded && typeof decoded === 'object' && 'user' in decoded) {
            return decoded['user'];
        }
        return null; // Token doesn't contain the 'user' key in the payload
    }
    catch (error) {
        throw new Error('Error decoding the JWT token');
    }
};
exports.extractUserFromToken = extractUserFromToken;
const getSessionKey = (user) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const session = yield prismaClient_1.default.logins.findFirst({
            where: {
                usuario: Number(user)
            },
            select: {
                chave_sessao: true
            }
        });
        if (session) {
            return session.chave_sessao;
        }
        else {
            console.warn('No session found for user:', user);
            return null;
        }
    }
    catch (error) {
        console.error('Error in getSessionKey:', error);
        throw error; // Rethrow the original error
    }
});
exports.getSessionKey = getSessionKey;
const validateJWT = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const token = req.header('Authorization');
    if (!token) {
        return res.status(401).json({ message: 'Authorization token not provided.' });
    }
    const userId = yield (0, exports.extractUserFromToken)(token);
    if (userId === null) {
        return res.status(401).json({ message: 'Invalid JWT token.' });
    }
    const secretKey = yield (0, exports.getSessionKey)(userId);
    if (secretKey === null) {
        return res.status(401).json({ message: 'Invalid JWT token.' });
    }
    try {
        const decoded = jsonwebtoken_1.default.verify(token, secretKey);
        next();
    }
    catch (error) {
        return res.status(401).json({ message: 'Invalid authorization token.' });
    }
});
exports.validateJWT = validateJWT;
const extractUserDataFromToken = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const token = req.header('Authorization');
    if (!token) {
        return res.status(401).json({ message: 'Invalid session data' });
    }
    try {
        const decoded = jsonwebtoken_1.default.decode(token);
        if (decoded && typeof decoded === 'object' && 'user' in decoded) {
            const user = prismaClient_1.default.usuario.findFirst({
                where: { id: decoded['user'] }
            });
            console.log(user);
            return user;
        }
        return null;
    }
    catch (error) {
        throw new Error('Error decoding the JWT token');
    }
});
exports.extractUserDataFromToken = extractUserDataFromToken;
