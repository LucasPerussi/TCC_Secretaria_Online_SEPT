import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

export const CheckUserExists = async (user: number) => {
    const alunoExists = await prisma.usuario.findUnique({
        where: { id: user }
    });
    if (!alunoExists) {
        return false;
    }
    return true;
};