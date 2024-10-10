export type EmailType = {
    id: number;
    nome: string;
    cor: string;
};

export enum EmailTypes {
    ACCOUNT_CREATION = "1",
    LOGIN = "2",
    TICKET_OPEN = "3",
}

export const EmailTypeInfo: Record<EmailTypes, EmailType> = {
    [EmailTypes.ACCOUNT_CREATION]: { id: 1, nome: "Criação de Conta", cor: "#ffffff" },
    [EmailTypes.LOGIN]: { id: 2, nome: "Login", cor: "#0000ff" },
    [EmailTypes.TICKET_OPEN]: { id: 3, nome: "Chamado registrado", cor: "#ff0f0f" }
};



