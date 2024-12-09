export type AtividadeFormativaType = {
    id: number;
    nome: string;
    maxHoras: number;
    cargaHoraria: number;
    cor: string;
};

export enum AtividadeFormativaTypes {
    PARTICIPACAO_SEMINARIO = "1",
    PARTICIPACAO_PALESTRA = "2",
    ORGANIZACAO_SEMINARIO = "3",
    CURSOS_EXTENSAO = "4",
    ESTAGIO = "5",
}

export const AtividadeFormativaTypeInfo: Record<AtividadeFormativaTypes, AtividadeFormativaType> = {
    [AtividadeFormativaTypes.PARTICIPACAO_SEMINARIO]: {
        id: 1,
        nome: "Participação em Seminário, Congresso, Encontro, Fórum e Workshops",
        maxHoras: 30,
        cargaHoraria: 20,
        cor: "#ff5c33",
    },
    [AtividadeFormativaTypes.PARTICIPACAO_PALESTRA]: {
        id: 2,
        nome: "Participação em Palestra",
        maxHoras: 30,
        cargaHoraria: 4,
        cor: "#218d72",
    },
    [AtividadeFormativaTypes.ORGANIZACAO_SEMINARIO]: {
        id: 3,
        nome: "Organização de Seminário, Congresso, Encontro, Fórum e Workshop",
        maxHoras: 30,
        cargaHoraria: 30,
        cor: "#3357FF",
    },
    [AtividadeFormativaTypes.CURSOS_EXTENSAO]: {
        id: 4,
        nome: "Cursos de extensão presenciais ou à distância",
        maxHoras: 30,
        cargaHoraria: 17,
        cor: "#FF33A8",
    },
    [AtividadeFormativaTypes.ESTAGIO]: {
        id: 5,
        nome: "Estágio não obrigatório remunerado (ENOR), trabalho voluntário qualificado ou trabalho remunerado (todos na área de atuação do curso)",
        maxHoras: 30,
        cargaHoraria: 0,
        cor: "#5f33ff",
    },
};
