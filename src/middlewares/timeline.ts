import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

export const Timeline = async (titulo: string, referencia: string, descricao: string ,tipo: number, usuario: number) => {
    const registerTimeline = await prisma.timelines.create({
        data: {
            titulo,
            referencia,
            descricao,
            tipo,
            usuario
        }
    })
    return registerTimeline;
};