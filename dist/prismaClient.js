"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const client_1 = require("@prisma/client");
let prisma;
const databaseUrl = process.env.NODE_ENV === 'test'
    ? process.env.DATABASE_URL_TESTS
    : process.env.DATABASE_URL;
prisma = new client_1.PrismaClient({
    datasources: { db: { url: databaseUrl } },
});
exports.default = prisma;
