import prisma from '../../prismaClient'; // Adjust the path as necessary

export const CheckEmpresaExists = async (empresaId: number): Promise<boolean> => {
    const empresaExists = await prisma.empresas.findUnique({
        where: { id: empresaId }
    });
    return !!empresaExists;
};
