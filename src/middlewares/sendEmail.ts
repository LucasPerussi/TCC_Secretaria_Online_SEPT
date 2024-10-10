import { PrismaClient } from '@prisma/client'
import { codeGenerator } from './randomCodeGenerator';

const prisma = new PrismaClient()

export const SendEmail = async (destinatario: string, titulo: string, corpo: string,  usuario: number, operacao: number) => {

    const emailIdentifier = await codeGenerator(15);

    const QueueEmail = await prisma.fila_emails.create({
        data: {
            destinatario,
            titulo,
            corpo,
            identificador: emailIdentifier, 
            usuario: usuario ?? null,
            operacao
        }
    })
    return QueueEmail;
};
