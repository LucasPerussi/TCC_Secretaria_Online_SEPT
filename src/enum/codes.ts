export type CodeType = {
    id: number;
    nome: string;
    cor: string;
};

export enum CodeTypes {
    ACCOUNT_CREATION = "1",
    PASSWORD_RESET = "2",
    DOUBLE_STEP = "3",
}

export const CodeTypeInfo: Record<CodeTypes, CodeType> = {
    [CodeTypes.ACCOUNT_CREATION]: { id: 1, nome: "Criação de Conta", cor: "#ffffff" },
    [CodeTypes.PASSWORD_RESET]: { id: 2, nome: "Reset de Senha", cor: "#0000ff" },
    [CodeTypes.DOUBLE_STEP]: { id: 3, nome: "Verificação em 2F", cor: "#ff0f0f" }
};



