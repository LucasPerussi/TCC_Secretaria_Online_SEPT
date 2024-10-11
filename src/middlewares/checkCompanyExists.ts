import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

export const CheckEmpresaExists = async (empresaId: number): Promise<boolean> => {
    const empresaExists = await prisma.empresas.findUnique({
        where: { id: empresaId }
    });
    return !!empresaExists;
};
