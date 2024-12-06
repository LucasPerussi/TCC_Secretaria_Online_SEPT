import prisma from '../prismaClient'; // Adjust the path as necessary

export const Logger = async (
  funcao: string,
  mensagem: string,
  status: string,
  usuario?: number
) => {
  try {
    // Defina o tamanho máximo permitido para 'funcao'
    const maxFuncaoLength = 50; // Ajuste conforme o esquema do banco

    // Truncate 'funcao' se exceder o tamanho máximo
    if (funcao.length > maxFuncaoLength) {
      console.warn(
        `A função "${funcao}" excede ${maxFuncaoLength} caracteres e será truncada.`
      );
      funcao = funcao.substring(0, maxFuncaoLength);
    }

    if (usuario) {
      const userExists = await prisma.usuario.findUnique({
        where: { id: usuario },
      });

      if (!userExists) {
        throw new Error(`Usuário com ID ${usuario} não encontrado`);
      }
    }

    const registerLog = await prisma.logs.create({
      data: {
        funcao,
        mensagem,
        usuario: usuario ?? null,
        status,
      },
    });

    return registerLog;
  } catch (error) {
    if (error instanceof Error) {
      console.error('Erro ao registrar log:', error.message);
      throw new Error(`Erro ao registrar log: ${error.message}`);
    } else {
      console.error('Erro desconhecido ao registrar log:', error);
      throw new Error('Erro desconhecido ao registrar log');
    }
  }
};
