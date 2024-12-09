import prisma from '../prismaClient'; // Adjust the path as necessary

export const Timeline = async (titulo: string, referencia: string, descricao: string ,tipo: number, usuario: number) => {
    const registerTimeline = await prisma.timelines.create({
        data: {
            titulo,
            referencia:String(referencia),
            descricao,
            tipo,
            usuario
        }
    })
    return registerTimeline;
};