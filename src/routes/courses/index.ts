import { Router } from 'express';
import { extractUserDataFromToken, validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';
import { codeGenerator, numberGenerator } from '../../middlewares/randomCodeGenerator';
import { addMonths, parseISO } from 'date-fns';
import { CheckUserExists } from '../../middlewares/checkUserExists';
import { CheckEmpresaExists } from '../../middlewares/checkCompanyExists';

interface CreateCourses {
    nome: string, 
    descricao: string,
    coordenador: number, 
    horas_formativas: number, 
    semestres: number
}


export const routerCourses = Router()

routerCourses.get('/', (req, res) => res.send('API de Cursos'))

routerCourses.post('/new', validateJWT, async (req, res) => {
    const { nome, descricao, coordenador, horas_formativas, semestres }: CreateCourses = req.body ;
    try {
        const identificador = await codeGenerator(8);

        const newCourse = await prisma.curso.create({
            data: {
                nome,
                descricao,
                coordenador: Number(coordenador),
                identificador,
                horas_formativas: Number(horas_formativas),
                semestres,
                criado_em: new Date(),
            }
        })

        Logger('GET - COURSES - /new', `200 - novo curso cadastrado: ${newCourse.nome}`, "success");
        res.status(200).send({ message: 'curso criado com sucesso!', curso: { newCourse } });
    } catch (error) {
        if (error instanceof Error) {
            Logger('GET - COURSES - /new', `500 - Erro ao cadastrar novo curso: ${error.message}`, "error");
            console.error('Erro ao cadastrar curso:', error.message);
            res.status(500).send({ message: 'Erro ao enviar email', error: error.message });
        } else {
            Logger('GET - COURSES - /new', `500 - Erro ao cadastrar novo curso: ${JSON.stringify(error)}`, "error");
            console.error('Erro ao cadastrar curso: Erro desconhecido');
            res.status(500).send({ message: 'Erro ao enviar email', error: 'Erro desconhecido' });
        }
    }
});

routerCourses.get('/id/:id', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const courseData = await prisma.curso.findFirst({
            where: {
                id: id
            }
        })

        if (courseData) {
            Logger(`GET - COURSES - id/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(courseData));
        } else {
            Logger(`GET - COURSES - id/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Course not found!' });
        }
    } catch (error) {
        Logger(`GET - COURSES - id/${id}`, `Error fetching requested course. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested course.' });
    }
});

routerCourses.delete('/id/:id', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const courseData = await prisma.curso.delete({
            where: {
                id: id
            }
        })

        if (courseData) {
            Logger(`DELETE - COURSES - id/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(courseData));
        } else {
            Logger(`DELETE - COURSES - id/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Course not found!' });
        }
    } catch (error) {
        Logger(`DELETE - COURSES - id/${id}`, `Error deleting requested course. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error deleting requested course.' });
    }
});

routerCourses.delete('/identifier/:identifier', validateJWT, async (req, res) => {
    const identifier = req.params.identifier;
    try {
        const courseData = await prisma.curso.delete({
            where: {
                identificador: identifier
            }
        })

        if (courseData) {
            Logger(`DELETE - COURSES - id/${identifier}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(courseData));
        } else {
            Logger(`DELETE - COURSES - id/${identifier}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Course not found!' });
        }
    } catch (error) {
        Logger(`DELETE - COURSES - id/${identifier}`, `Error deleting requested course. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error deleting requested course.' });
    }
});

routerCourses.get('/identifier/:identifier', validateJWT, async (req, res) => {
    const identifier = req.params.identifier;
    try {
        const courseData = await prisma.curso.findFirst({
            where: {
                identificador: identifier
            }
        })

        if (courseData) {
            Logger(`GET - COURSES - id/${identifier}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(courseData));
        } else {
            Logger(`GET - COURSES - id/${identifier}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Course not found!' });
        }
    } catch (error) {
        Logger(`GET - COURSES - id/${identifier}`, `Error fetching requested course. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested course.' });
    }
});

routerCourses.get('/all', validateJWT, async (req, res) => {
    try {
        const CourseData = await prisma.curso.findMany()
        if (CourseData) {
            Logger(`GET - Course - all-courses`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(CourseData));
        } else {
            Logger(`GET - Course - all-courses`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'No Course found' });
        }
    } catch (error) {
        Logger(`GET - Course - all-courses`, `Error fetching courses. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching courses.' });
    }
});



