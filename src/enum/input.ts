export type InputType = {
    id: number;
    nome: string;
    cor: string;
};

export enum InputTypes {
    TEXT_INPUT = "1",
    NUMBER_INPUT = "2",
    DATE_INPUT = "3",
    EMAIL_INPUT = "4",
    PHONE_INPUT = "5",
    TEXT_BOX = "6",
    CHECK_BOX = "7",
    SELECT = "8",
    RADIO_BUTTON = "9",
    SWITCH = "10",
    FILE_UPLOAD = "11",
    RANGE = "12",
    PASSWORD_INPUT = "13",
    COLOR_PICKER = "14",
    TIME_INPUT = "15",
    RATING = "16",
}

export const InputTypeInfo: Record<InputTypes, InputType> = {
    [InputTypes.TEXT_INPUT]: { id: 1, nome: "Input de Texto", cor: "#ffffff" },
    [InputTypes.NUMBER_INPUT]: { id: 2, nome: "Input de Número", cor: "#0000ff" },
    [InputTypes.DATE_INPUT]: { id: 3, nome: "Input de Data", cor: "#ff0f0f" },
    [InputTypes.EMAIL_INPUT]: { id: 4, nome: "Input de Email", cor: "#ff8800" },
    [InputTypes.PHONE_INPUT]: { id: 5, nome: "Input de Telefone", cor: "#228b22" },
    [InputTypes.TEXT_BOX]: { id: 6, nome: "Caixa de Texto", cor: "#8a2be2" },
    [InputTypes.CHECK_BOX]: { id: 7, nome: "Caixa de Seleção", cor: "#ff1493" },
    [InputTypes.SELECT]: { id: 8, nome: "Seleção", cor: "#00ced1" },
    [InputTypes.RADIO_BUTTON]: { id: 9, nome: "Botão de Opção", cor: "#8b4513" },
    [InputTypes.SWITCH]: { id: 10, nome: "Interruptor", cor: "#2e8b57" },
    [InputTypes.FILE_UPLOAD]: { id: 11, nome: "Envio de Arquivo", cor: "#8b0000" },
    [InputTypes.RANGE]: { id: 12, nome: "Controle de Intervalo", cor: "#ffd700" },
    [InputTypes.PASSWORD_INPUT]: { id: 13, nome: "Senha", cor: "#4b0082" },
    [InputTypes.COLOR_PICKER]: { id: 14, nome: "Seletor de Cor", cor: "#daa520" },
    [InputTypes.TIME_INPUT]: { id: 15, nome: "Horário", cor: "#4682b4" },
    [InputTypes.RATING]: { id: 16, nome: "Avaliação", cor: "#d2691e" },
};


