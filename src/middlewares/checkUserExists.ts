import prisma from '../prismaClient'; // Adjust the path as necessary

export const CheckUserExists = async (user: number) => {
    const alunoExists = await prisma.usuario.findUnique({
        where: { id: user }
    });
    if (!alunoExists) {
        return false;
    }
    return true;
};