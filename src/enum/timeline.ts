export type TimelineType = {
    id: number;
    nome: string;
    cor: string;
};

export enum TimelineTypes {
    ACCOUNT_CREATION = "1",
    LOGIN = "2",
    TICKET_OPEN = "3",
}

export const TimelineTypeInfo: Record<TimelineTypes, TimelineType> = {
    [TimelineTypes.ACCOUNT_CREATION]: { id: 1, nome: "Criação de Conta", cor: "#ffffff" },
    [TimelineTypes.LOGIN]: { id: 2, nome: "Login", cor: "#0000ff" },
    [TimelineTypes.TICKET_OPEN]: { id: 3, nome: "Chamado registrado", cor: "#ff0f0f" }
};



