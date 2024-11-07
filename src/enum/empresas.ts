export type CompanyType = {
    id: number;
    nome: string;
    cor: string;
    text: string;
};

export enum CompanyTypes {
    EMPRESA_PRIVADA = "1",
    EMPRESA_JUNIOR = "2",
    EMPRESA_GOVERNAMENTAL = "3",
    ONG = "4",
    EMPRESA_DO_EXTERIOR = "5",
    FREELANCER = "6",
    MEI = "7",
    NAO_INFORMADO = "99",
}

export const CompanyTypeInfo: Record<CompanyTypes, CompanyType> = {
    [CompanyTypes.EMPRESA_PRIVADA]: {
        id: 1,
        nome: "Empresa Privada",
        cor: "#1f77b4", 
        text: "#ffffff"
    },
    [CompanyTypes.EMPRESA_JUNIOR]: {
        id: 2,
        nome: "Empresa Júnior",
        cor: "#fc9337", // Laranja
        text: "#161616"
    },
    [CompanyTypes.EMPRESA_GOVERNAMENTAL]: {
        id: 3,
        nome: "Empresa Governamental",
        cor: "#2ca02c", // Verde
        text: "#ffffff"
    },
    [CompanyTypes.ONG]: {
        id: 4,
        nome: "ONG",
        cor: "#d62728", // Vermelho
        text: "#ffffff"
    },
    [CompanyTypes.EMPRESA_DO_EXTERIOR]: {
        id: 5,
        nome: "Empresa do Exterior",
        cor: "#9467bd", // Roxo
        text: "#ffffff"
    },
    [CompanyTypes.FREELANCER]: {
        id: 6,
        nome: "Freelancer",
        cor: "#8c564b", // Marrom
        text: "#ffffff"

    },
    [CompanyTypes.MEI]: {
        id: 7,
        nome: "MEI",
        cor: "#fc83d8", // Rosa
        text: "#181717"
    },
    [CompanyTypes.NAO_INFORMADO]: {
        id: 99,
        nome: "Não Informado",
        cor: "#e7e428", // Cinza
        text: "#242222"
    },
};
