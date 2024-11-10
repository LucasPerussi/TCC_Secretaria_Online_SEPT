"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.EmailTypeInfo = exports.EmailTypes = void 0;
var EmailTypes;
(function (EmailTypes) {
    EmailTypes["ACCOUNT_CREATION"] = "1";
    EmailTypes["LOGIN"] = "2";
    EmailTypes["TICKET_OPEN"] = "3";
})(EmailTypes = exports.EmailTypes || (exports.EmailTypes = {}));
exports.EmailTypeInfo = {
    [EmailTypes.ACCOUNT_CREATION]: { id: 1, nome: "Criação de Conta", cor: "#ffffff" },
    [EmailTypes.LOGIN]: { id: 2, nome: "Login", cor: "#0000ff" },
    [EmailTypes.TICKET_OPEN]: { id: 3, nome: "Chamado registrado", cor: "#ff0f0f" }
};
