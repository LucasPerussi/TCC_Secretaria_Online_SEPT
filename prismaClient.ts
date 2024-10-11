import { PrismaClient } from '@prisma/client';

let prisma: PrismaClient;

if (process.env.NODE_ENV === 'test') {
  prisma = new PrismaClient({
    datasources: { db: { url: process.env.DATABASE_URL_TESTS } },
  });
} else {
  prisma = new PrismaClient();
}

export default prisma;