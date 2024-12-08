export type TimelineType = {
    id: number;
    nome: string;
    cor: string;
};

export enum TimelineTypes {
    ACCOUNT_CREATION = "1",
    LOGIN = "2",
    TICKET_OPEN = "3",
    PASSWORD_CHANGE = "4",
    NEW_COMMENT = "5",
    NEW_STAGE = "6",
    NEW_TEACHER = "7",
    NEW_SERVER = "8",
    TICKET_CLOSED = "9",
    NEW_STATUS = "10",
}

export const TimelineTypeInfo: Record<TimelineTypes, TimelineType> = {
    [TimelineTypes.ACCOUNT_CREATION]: { id: 1, nome: "Criação de Conta", cor: "#1E90FF" },
    [TimelineTypes.LOGIN]: { id: 2, nome: "Login", cor: "#20B2AA" },
    [TimelineTypes.TICKET_OPEN]: { id: 3, nome: "Chamado registrado", cor: "#FA8072" },
    [TimelineTypes.PASSWORD_CHANGE]: { id: 4, nome: "Alteração de Senha", cor: "#00BFFF" },
    [TimelineTypes.NEW_COMMENT]: { id: 5, nome: "Novo Comentário", cor: "#2bff00" },
    [TimelineTypes.NEW_STAGE]: { id: 6, nome: "Mudança de etapa", cor: "#5521b6" },
    [TimelineTypes.NEW_TEACHER]: { id: 7, nome: "Professor Vinculado", cor: "#8caa21" },
    [TimelineTypes.NEW_SERVER]: { id: 8, nome: "Servidor Vinculado", cor: "#217ab6" },
    [TimelineTypes.TICKET_CLOSED]: { id: 9, nome: "Chamado Encerrado", cor: "#eec12d" },
    [TimelineTypes.NEW_STATUS]: { id: 10, nome: "Novo Status", cor: "#b72dee" }
};

