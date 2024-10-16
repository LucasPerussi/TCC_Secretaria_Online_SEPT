"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CodeTypeInfo = exports.CodeTypes = void 0;
var CodeTypes;
(function (CodeTypes) {
    CodeTypes["ACCOUNT_CREATION"] = "1";
    CodeTypes["PASSWORD_RESET"] = "2";
    CodeTypes["DOUBLE_STEP"] = "3";
})(CodeTypes || (exports.CodeTypes = CodeTypes = {}));
exports.CodeTypeInfo = {
    [CodeTypes.ACCOUNT_CREATION]: { id: 1, nome: "Criação de Conta", cor: "#ffffff" },
    [CodeTypes.PASSWORD_RESET]: { id: 2, nome: "Reset de Senha", cor: "#0000ff" },
    [CodeTypes.DOUBLE_STEP]: { id: 3, nome: "Verificação em 2F", cor: "#ff0f0f" }
};
