import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

export const Logger = async (funcao: string, mensagem: string, status: string, usuario?: number) => {
    const registerLog = await prisma.logs.create({
        data: {
            funcao,
            mensagem,
            usuario: usuario ?? null,
            status
        }
    })
    return registerLog;
};
