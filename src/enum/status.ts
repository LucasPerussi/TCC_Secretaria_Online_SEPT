// Definição do tipo para informações do status do processo
export type ProcessStatusType = {
    id: number;
    nome: string;
    cor: string;
    encerrado: boolean; // Indica se o status representa um processo encerrado
};

// Enum para os diferentes tipos de status de processo
export enum ProcessStatusTypes {
    PENDENTE = "1",
    ABERTO = "2",
    REGISTRADO = "3",
    AGUARDANDO = "4",
    DEFERIDO = "5",
    INDEFERIDO = "6",
    CANCELADO = "7",
    EM_REVISAO = "8",       // Status adicional: Em Revisão
    EM_ANALISE = "9",       // Status adicional: Em Análise
    FINALIZADO = "10",      // Status adicional: Finalizado
}

// Registro com as informações de cada status
export const ProcessStatusTypeInfo: Record<ProcessStatusTypes, ProcessStatusType> = {
    [ProcessStatusTypes.PENDENTE]: {
        id: 1,
        nome: "Pendente",
        cor: "#FFC107", // Amarelo
        encerrado: false,
    },
    [ProcessStatusTypes.ABERTO]: {
        id: 2,
        nome: "Aberto",
        cor: "#2196F3", // Azul
        encerrado: false,
    },
    [ProcessStatusTypes.REGISTRADO]: {
        id: 3,
        nome: "Registrado",
        cor: "#4CAF50", // Verde
        encerrado: false,
    },
    [ProcessStatusTypes.AGUARDANDO]: {
        id: 4,
        nome: "Aguardando",
        cor: "#FF9800", // Laranja
        encerrado: false,
    },
    [ProcessStatusTypes.DEFERIDO]: {
        id: 5,
        nome: "Deferido",
        cor: "#4CAF50", // Verde
        encerrado: true,
    },
    [ProcessStatusTypes.INDEFERIDO]: {
        id: 6,
        nome: "Indeferido",
        cor: "#F44336", // Vermelho
        encerrado: true,
    },
    [ProcessStatusTypes.CANCELADO]: {
        id: 7,
        nome: "Cancelado",
        cor: "#9E9E9E", // Cinza
        encerrado: true,
    },
    [ProcessStatusTypes.EM_REVISAO]: {
        id: 8,
        nome: "Em Revisão",
        cor: "#795548", // Marrom
        encerrado: false,
    },
    [ProcessStatusTypes.EM_ANALISE]: {
        id: 9,
        nome: "Em Análise",
        cor: "#3F51B5", // Índigo
        encerrado: false,
    },
    [ProcessStatusTypes.FINALIZADO]: {
        id: 10,
        nome: "Finalizado",
        cor: "#673AB7", // Roxo
        encerrado: true,
    },
};
