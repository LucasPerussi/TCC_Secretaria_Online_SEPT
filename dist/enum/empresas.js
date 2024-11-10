"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CompanyTypeInfo = exports.CompanyTypes = void 0;
var CompanyTypes;
(function (CompanyTypes) {
    CompanyTypes["EMPRESA_PRIVADA"] = "1";
    CompanyTypes["EMPRESA_JUNIOR"] = "2";
    CompanyTypes["EMPRESA_GOVERNAMENTAL"] = "3";
    CompanyTypes["ONG"] = "4";
    CompanyTypes["EMPRESA_DO_EXTERIOR"] = "5";
    CompanyTypes["FREELANCER"] = "6";
    CompanyTypes["MEI"] = "7";
    CompanyTypes["NAO_INFORMADO"] = "99";
})(CompanyTypes = exports.CompanyTypes || (exports.CompanyTypes = {}));
exports.CompanyTypeInfo = {
    [CompanyTypes.EMPRESA_PRIVADA]: {
        id: 1,
        nome: "Empresa Privada",
        cor: "#1f77b4", // Azul
    },
    [CompanyTypes.EMPRESA_JUNIOR]: {
        id: 2,
        nome: "Empresa Júnior",
        cor: "#ff7f0e", // Laranja
    },
    [CompanyTypes.EMPRESA_GOVERNAMENTAL]: {
        id: 3,
        nome: "Empresa Governamental",
        cor: "#2ca02c", // Verde
    },
    [CompanyTypes.ONG]: {
        id: 4,
        nome: "ONG",
        cor: "#d62728", // Vermelho
    },
    [CompanyTypes.EMPRESA_DO_EXTERIOR]: {
        id: 5,
        nome: "Empresa do Exterior",
        cor: "#9467bd", // Roxo
    },
    [CompanyTypes.FREELANCER]: {
        id: 6,
        nome: "Freelancer",
        cor: "#8c564b", // Marrom
    },
    [CompanyTypes.MEI]: {
        id: 7,
        nome: "MEI",
        cor: "#e377c2", // Rosa
    },
    [CompanyTypes.NAO_INFORMADO]: {
        id: 99,
        nome: "Não Informado",
        cor: "#7f7f7f", // Cinza
    },
};
