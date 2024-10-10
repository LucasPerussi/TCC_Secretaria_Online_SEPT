import { Request, Response, NextFunction } from 'express';
import jwt, { Secret } from 'jsonwebtoken'; // Import 'Secret' type from 'jsonwebtoken'
import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

export const extractUserFromToken = (token: string) => {
    try {
        const decoded = jwt.decode(token);
        if (decoded && typeof decoded === 'object' && 'user' in decoded) {
            return decoded['user'];
        }
        return null; // Token doesn't contain the 'user' key in the payload
    } catch (error) {
        throw new Error('Error decoding the JWT token');
    }
};


export const getSessionKey = async (user: number) => {
    try {
        const session = await prisma.logins.findFirst({
            where: {
                usuario: user
            },
            select: {
                chave_sessao: true
            }
        });

        if (session) {
            return session.chave_sessao;
        } else {
            return null;
        }
        
    } catch (error) {
        throw new Error('Error finding the session key');
    }
};

export const validateJWT = async (req: Request, res: Response, next: NextFunction) => {
    const token = req.header('Authorization');
    if (!token) {
        return res.status(401).json({ message: 'Authorization token not provided.' });
    }

    const userId = await extractUserFromToken(token);
    if (userId === null) {
        return res.status(401).json({ message: 'Invalid JWT token.' });
    }

    const secretKey = await getSessionKey(userId);
    if (secretKey === null) {
        return res.status(401).json({ message: 'Invalid JWT token.' });
    }

    try {
        const decoded = jwt.verify(token, secretKey as Secret);
        next();
    } catch (error) {
        return res.status(401).json({ message: 'Invalid authorization token.' });
    }
};


export const extractUserDataFromToken = async (req: Request, res: Response) => {
    const token = req.header('Authorization');
    if (!token) {
        return res.status(401).json({ message: 'Invalid session data' });
    }

    try {
        const decoded = jwt.decode(token);
        if (decoded && typeof decoded === 'object' && 'user' in decoded) {
            const user = prisma.usuario.findFirst({
                where: {id : decoded['user']}
            })
   
            console.log(user)
            return user;
        }
        return null; 
    } catch (error) {
        throw new Error('Error decoding the JWT token');
    }
};