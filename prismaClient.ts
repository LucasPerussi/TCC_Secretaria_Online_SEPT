import { PrismaClient } from '@prisma/client';

let prisma: PrismaClient;

const databaseUrl =
  process.env.NODE_ENV === 'test'
    ? process.env.DATABASE_URL_TESTS
    : process.env.DATABASE_URL;

prisma = new PrismaClient({
  datasources: { db: { url: databaseUrl } },
});

export default prisma;
