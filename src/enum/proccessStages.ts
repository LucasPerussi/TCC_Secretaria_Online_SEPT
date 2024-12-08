
export type StageType = {
    id: number;
    nome: string;
    estimativaHoras: number;
    cor: string;
};


export enum ProcessoEtapas {
    ABERTO_PENDENTE = "1",
    EM_ANALISE = "2",
    ENCAMINHADO_PROFESSOR_RESPONSAVEL = "3",
    ENCAMINHADO_TECNICO_RESPONSAVEL = "4",
    ENCAMINHADO_RESPONSAVEL = "5",
    EM_CONTESTACAO = "6",
    DEFERIDO = "7",
    INDEFERIDO = "8",
    CONCLUIDO = "9",
    CANCELADO = "10",
    REVISADO = "11",
    AGUARDANDO_DOCUMENTOS = "12",
    AGUARDANDO_APROVACAO = "13",
    EM_RECURSO = "14"
}

export const ProcessoEtapaInfo: Record<ProcessoEtapas, StageType> = {
    [ProcessoEtapas.ABERTO_PENDENTE]: {
        id: 1,
        nome: "Aberto / Pendente",
        estimativaHoras: 24,
        cor: "#FFA500", // Laranja
    },
    [ProcessoEtapas.EM_ANALISE]: {
        id: 2,
        nome: "Em Análise",
        estimativaHoras: 24,
        cor: "#FFFF00", // Amarelo
    },
    [ProcessoEtapas.ENCAMINHADO_PROFESSOR_RESPONSAVEL]: {
        id: 3,
        nome: "Encaminhado para Professor Responsável",
        estimativaHoras: 24,
        cor: "#0000FF", // Azul
    },
    [ProcessoEtapas.ENCAMINHADO_TECNICO_RESPONSAVEL]: {
        id: 4,
        nome: "Encaminhado para Técnico Responsável",
        estimativaHoras: 24,
        cor: "#00FFFF", // Ciano
    },
    [ProcessoEtapas.ENCAMINHADO_RESPONSAVEL]: {
        id: 5,
        nome: "Encaminhado para Responsável",
        estimativaHoras: 24,
        cor: "#800080", // Roxo
    },
    [ProcessoEtapas.EM_CONTESTACAO]: {
        id: 6,
        nome: "Em Contestação",
        estimativaHoras: 24,
        cor: "#FF4500", // Laranja avermelhado
    },
    [ProcessoEtapas.DEFERIDO]: {
        id: 7,
        nome: "Deferido",
        estimativaHoras: 24,
        cor: "#008000", // Verde
    },
    [ProcessoEtapas.INDEFERIDO]: {
        id: 8,
        nome: "Indeferido",
        estimativaHoras: 24,
        cor: "#FF0000", // Vermelho
    },
    [ProcessoEtapas.CONCLUIDO]: {
        id: 9,
        nome: "Concluído",
        estimativaHoras: 24,
        cor: "#32CD32", // Verde limão
    },
    [ProcessoEtapas.CANCELADO]: {
        id: 10,
        nome: "Cancelado",
        estimativaHoras: 24,
        cor: "#A9A9A9", // Cinza
    },
    [ProcessoEtapas.REVISADO]: {
        id: 11,
        nome: "Revisado",
        estimativaHoras: 24,
        cor: "#4169E1", // Azul Royal
    },
    [ProcessoEtapas.AGUARDANDO_DOCUMENTOS]: {
        id: 12,
        nome: "Aguardando Documentos",
        estimativaHoras: 24,
        cor: "#FFD700", // Dourado
    },
    [ProcessoEtapas.AGUARDANDO_APROVACAO]: {
        id: 13,
        nome: "Aguardando Aprovação",
        estimativaHoras: 24,
        cor: "#40E0D0", // Turquesa
    },
    [ProcessoEtapas.EM_RECURSO]: {
        id: 14,
        nome: "Em Recurso",
        estimativaHoras: 24,
        cor: "#DC143C", // Carmesim
    },
};

export function getNomeEtapaById(id: number): string | undefined {
    const etapa = Object.values(ProcessoEtapaInfo).find(stage => stage.id === id);
    return etapa ? etapa.nome : undefined;
}