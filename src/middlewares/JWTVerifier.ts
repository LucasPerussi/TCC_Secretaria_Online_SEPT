import { Request, Response, NextFunction } from 'express';
import jwt, { Secret } from 'jsonwebtoken'; // Importa o tipo 'Secret' do 'jsonwebtoken'
import prisma from '../prismaClient'; // Ajuste o caminho conforme necessário

export const extractUserFromToken = (token: string) => {
    try {
        const decoded = jwt.decode(token);
        if (decoded && typeof decoded === 'object' && 'user' in decoded) {
            return decoded['user'];
        }
        return null; // O token não contém a chave 'user' no payload
    } catch (error) {
        throw new Error('Erro ao decodificar o token JWT');
    }
};

export const extractRoleFromToken = (token: string) => {
    try {
        const decoded = jwt.decode(token);
        if (decoded && typeof decoded === 'object' && 'role' in decoded) {
            return decoded['role'];
        }
        return null; // O token não contém a chave 'role' no payload
    } catch (error) {
        throw new Error('Erro ao decodificar o token JWT');
    }
};

export const getSessionKeys = async (user: number) => {
    try {
        const sessions = await prisma.logins.findMany({
            where: {
                usuario: Number(user)
            },
            select: {
                chave_sessao: true
            }
        });

        if (sessions && sessions.length > 0) {
            return sessions.map(session => session.chave_sessao);
        } else {
            console.warn('Nenhuma sessão encontrada para o usuário:', user);
            return [];
        }
        
    } catch (error) {
        console.error('Erro em getSessionKeys:', error);
        throw error; // Relança o erro original
    }
};

export const verifyToken = async (token: string, userId: number): Promise<boolean> => {
    const secretKeys = await getSessionKeys(userId);
    if (secretKeys.length === 0) {
        return false;
    }

    for (const secretKey of secretKeys) {
        try {
            jwt.verify(token, secretKey as Secret);
            return true; // Token é válido
        } catch (error) {
            // Continua tentando com a próxima chave secreta
        }
    }
    return false; // Token inválido
};

export const validateJWT = async (req: Request, res: Response, next: NextFunction) => {
    const token = req.header('Authorization');
    if (!token) {
        return res.status(401).json({ message: 'Token de autorização não fornecido.' });
    }

    const userId = extractUserFromToken(token);
    if (userId === null) {
        return res.status(401).json({ message: 'Token JWT inválido.' });
    }

    const isValid = await verifyToken(token, userId);
    if (isValid) {
        next();
    } else {
        return res.status(401).json({ message: 'Token de autorização inválido.' });
    }
};

export const isAllowed = async (req: Request, res: Response, next: NextFunction) => {
    const token = req.header('Authorization');
    if (!token) {
        return res.status(401).json({ message: 'Token de autorização não fornecido.' });
    }

    const userId = extractUserFromToken(token);
    if (userId === null) {
        return res.status(401).json({ message: 'Token JWT inválido.' });
    }

    const isValid = await verifyToken(token, userId);
    if (!isValid) {
        return res.status(401).json({ message: 'Token de autorização inválido.' });
    }

    const role = extractRoleFromToken(token);
    if ((role === null) || (role < 9)) {
        return res.status(403).json({ message: 'Você não tem permissão para executar esta ação.' });
    }
    next();
};

export const extractUserDataFromToken = async (req: Request, res: Response) => {
    const token = req.header('Authorization');
    if (!token) {
        return res.status(401).json({ message: 'Dados de sessão inválidos' });
    }

    const userId = extractUserFromToken(token);
    if (userId === null) {
        return res.status(401).json({ message: 'Dados de sessão inválidos' });
    }

    const isValid = await verifyToken(token, userId);
    if (!isValid) {
        return res.status(401).json({ message: 'Dados de sessão inválidos' });
    }

    try {
        const user = await prisma.usuario.findFirst({
            where: { id: userId }
        });

        console.log(user);
        return user;
    } catch (error) {
        throw new Error('Erro ao buscar os dados do usuário');
    }
};
