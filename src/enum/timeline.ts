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
    EMAIL_UPDATE = "11",
    REGISTRATION_UPDATE = "12",
    NAME_UPDATE = "13",
    SURNAME_UPDATE = "14",
    BIRTHDATE_UPDATE = "15",
    PHOTO_UPDATE = "16",
    USER_STATUS_UPDATE = "17",
    COURSE_UPDATE = "18",
    COURSE_STATUS_UPDATE = "19",
    ROLE_UPDATE = "20",
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
    [TimelineTypes.NEW_STATUS]: { id: 10, nome: "Novo Status", cor: "#b72dee" },
    [TimelineTypes.EMAIL_UPDATE]: { id: 11, nome: "Atualização de Email", cor: "#ff5733" },
    [TimelineTypes.REGISTRATION_UPDATE]: { id: 12, nome: "Atualização de Registro", cor: "#ff0037" },
    [TimelineTypes.NAME_UPDATE]: { id: 13, nome: "Atualização de Nome", cor: "#0c907e" },
    [TimelineTypes.SURNAME_UPDATE]: { id: 14, nome: "Atualização de Sobrenome", cor: "#581845" },
    [TimelineTypes.BIRTHDATE_UPDATE]: { id: 15, nome: "Atualização de Data de Nascimento", cor: "#DAF7A6" },
    [TimelineTypes.PHOTO_UPDATE]: { id: 16, nome: "Atualização de Foto", cor: "#900C3F" },
    [TimelineTypes.USER_STATUS_UPDATE]: { id: 17, nome: "Atualização de Status do Usuário", cor: "#c53d9c" },
    [TimelineTypes.COURSE_UPDATE]: { id: 18, nome: "Atualização de Curso", cor: "#FF5733" },
    [TimelineTypes.COURSE_STATUS_UPDATE]: { id: 19, nome: "Atualização de Status do Curso", cor: "#FFC300" },
    [TimelineTypes.ROLE_UPDATE]: { id: 19, nome: "Atualização de função do usuário", cor: "#c49a12" },

};


export function getNomeTimelinesById(id: number): string | undefined {
    const timeline = Object.values(TimelineTypeInfo).find(index => index.id === id);
    return timeline ? timeline.nome : undefined;
}