"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TimelineTypeInfo = exports.TimelineTypes = void 0;
var TimelineTypes;
(function (TimelineTypes) {
    TimelineTypes["ACCOUNT_CREATION"] = "1";
    TimelineTypes["LOGIN"] = "2";
    TimelineTypes["TICKET_OPEN"] = "3";
})(TimelineTypes || (exports.TimelineTypes = TimelineTypes = {}));
exports.TimelineTypeInfo = {
    [TimelineTypes.ACCOUNT_CREATION]: { id: 1, nome: "Criação de Conta", cor: "#ffffff" },
    [TimelineTypes.LOGIN]: { id: 2, nome: "Login", cor: "#0000ff" },
    [TimelineTypes.TICKET_OPEN]: { id: 3, nome: "Chamado registrado", cor: "#ff0f0f" }
};
