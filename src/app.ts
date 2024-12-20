import express from 'express';
import cors from 'cors';
import logger from 'morgan';
import { bigIntMiddleware } from './middlewares/convertBigIntString'; // Importando o middleware

import { router } from './routes/index';
import { routerUsers } from './routes/users/index';
import { routerAuth } from './routes/auth/index';
import { routerSystem } from './routes/system/index'
import { routerInternship } from './routes/internship/index'
import { routerCompanies } from './routes/company/index'
import { routerCourses } from './routes/courses/index'
import { routerTrainingHours } from './routes/trainingHours/index'
import { routerSteps } from './routes/steps/index'
import { routerFields } from './routes/fields/index'
import { routerRequestType } from './routes/requestType/index'
import { routerMural } from './routes/mural/index'
import { routerRequests } from './routes/requests/index'
import { routerComments } from './routes/comments/index'

import { checkEmailQueue } from './middlewares/checkEmailQueue';

// cria o app
export const app = express();

// Executa a função de verificação de e-mails
checkEmailQueue();

// ***** Configuração dos middlewares
app.use(express.json());
// app.use(bigIntMiddleware); // Middleware para conversão de BigInt para string
app.use(cors());
app.use(logger('dev'));

// Integra os endpoints na aplicação
app.use('/', router);
app.use('/users', routerUsers);
app.use('/auth', routerAuth);
app.use('/system', routerSystem)
app.use('/internship', routerInternship)
app.use('/companies', routerCompanies)
app.use('/courses', routerCourses)
app.use('/hours', routerTrainingHours)
app.use('/steps', routerSteps)
app.use('/fields', routerFields)
app.use('/request-type', routerRequestType)
app.use('/mural', routerMural)
app.use('/requests', routerRequests)
app.use('/comments', routerComments)

