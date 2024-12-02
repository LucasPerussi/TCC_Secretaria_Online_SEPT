export type EmailType = {
    id: number;
    nome: string;
    cor: string;
};

export enum EmailTypes {
    ACCOUNT_CREATION = "1",
    LOGIN = "2",
    TICKET_OPEN = "3",
    PASSWORD_CHANGE = "4",
}

export const EmailTypeInfo: Record<EmailTypes, EmailType> = {
    [EmailTypes.ACCOUNT_CREATION]: { id: 1, nome: "Criação de Conta", cor: "#1E90FF" },
    [EmailTypes.LOGIN]: { id: 2, nome: "Login", cor: "#20B2AA" },
    [EmailTypes.TICKET_OPEN]: { id: 3, nome: "Chamado registrado", cor: "#FA8072" },
    [EmailTypes.PASSWORD_CHANGE]: { id: 4, nome: "Alteração de Senha", cor: "#00BFFF" }
};


