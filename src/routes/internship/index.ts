import { Router } from 'express';
import { extractUserDataFromToken, validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';
import { numberGenerator } from '../../middlewares/randomCodeGenerator';
import { addMonths, parseISO } from 'date-fns';
import { CheckUserExists } from '../../middlewares/checkUserExists';
import { CheckEmpresaExists } from '../../middlewares/checkCompanyExists';
import { ProcessStatusTypeInfo } from '../../enum/status';

export const routerInternship = Router()

routerInternship.get('/', (req, res) => res.send('API de Estágio'))

routerInternship.post('/new', validateJWT, async (req, res) => {
    let { aluno, professor_orientador, empresa, area_atuacao, data_inicio, duracaoMeses } = req.body;

    const codigoEstagio = await numberGenerator(10);

    const dataInicioDate = parseISO(data_inicio);
    if (!dataInicioDate || isNaN(dataInicioDate.getTime())) {
        return res.status(400).json({ message: 'Data de início inválida.' });
    }

    duracaoMeses = Number(duracaoMeses);
    if (isNaN(duracaoMeses)) {
        return res.status(400).json({ message: 'Duração em meses inválida.' });
    }

    aluno = Number(aluno);
    professor_orientador = Number(professor_orientador);
    empresa = Number(empresa);

    if (isNaN(aluno) || isNaN(professor_orientador) || isNaN(empresa)) {
        return res.status(400).json({ message: 'IDs inválidos fornecidos.' });
    }

    const [studentExists, teacherExists] = await Promise.all([
        CheckUserExists(aluno),
        CheckUserExists(professor_orientador),
    ]);

    if (!studentExists) {
        return res.status(404).json({ message: 'Aluno não encontrado.' });
    }

    if (!teacherExists) {
        return res.status(404).json({ message: 'Professor não encontrado.' });
    }

    const empresaExists = await CheckEmpresaExists(empresa);
    if (!empresaExists) {
        return res.status(404).json({ message: 'Empresa não encontrada.' });
    }

    const dataRenovacaoDate = addMonths(dataInicioDate, duracaoMeses);

    try {
        const newInternship = await prisma.estagio.create({
            data: {
                aluno,
                professor_orientador,
                empresa,
                area_atuacao,
                data_inicio: dataInicioDate,
                data_renovacao: dataRenovacaoDate,
                codigo_estagio: Number(codigoEstagio)
            }
        });

        res.status(200).send({ message: 'Estágio criado com sucesso', estagio: newInternship });
    } catch (error) {
        if (error instanceof Error) {
            console.error('Erro ao criar estágio:', error.message);
            res.status(500).send({ message: 'Erro ao criar estágio', error: error.message });
        } else {
            console.error('Erro ao criar estágio: Erro desconhecido');
            res.status(500).send({ message: 'Erro ao criar estágio', error: 'Erro desconhecido' });
        }
    }
});



routerInternship.get('/id/:id', validateJWT, async (req, res) => {
    const id = Number(req.params.id);
    try {
        const internshipData = await prisma.estagio.findFirst({
            where: {
                id: id
            }
        })

        if (internshipData) {
            Logger(`GET - INTERNSHIP - id/${id}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(internshipData));
        } else {
            Logger(`GET - INTERNSHIP - id/${id}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Internship not found!' });
        }
    } catch (error) {
        Logger(`GET - INTERNSHIP - id/${id}`, `Error fetching requested Internship. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Internship.' });
    }
});

routerInternship.get('/code/:code', validateJWT, async (req, res) => {
    const code = Number(req.params.code);
    try {
        const internshipData = await prisma.estagio.findFirst({
            where: {
                codigo_estagio: code
            }
        })

        if (internshipData) {
            Logger(`GET - INTERNSHIP - code/${code}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(internshipData));
        } else {
            Logger(`GET - INTERNSHIP - code/${code}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Internship not found!' });
        }
    } catch (error) {
        Logger(`GET - INTERNSHIP - code/${code}`, `Error fetching requested Internship. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Internship.' });
    }
});

routerInternship.get('/get-status-types', validateJWT, async (req, res) => {
    res.status(200).send(JSON.stringify(ProcessStatusTypeInfo));
});

routerInternship.patch('/update-status', validateJWT, async (req, res) => {
    let { id_estagio, status } = req.body;
    try {
        const internshipData = await prisma.estagio.update({
            where: {
                id: Number(id_estagio)
            }, data: {
                status: status
            }
        })

        if (internshipData) {
            Logger(`GET - INTERNSHIP - code/${id_estagio}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(internshipData));
        } else {
            Logger(`GET - INTERNSHIP - code/${id_estagio}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Internship not found!' });
        }
    } catch (error) {
        Logger(`GET - INTERNSHIP - code/${id_estagio}`, `Error fetching requested Internship. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested Internship.' });
    }
});



routerInternship.get('/all-internships', validateJWT, async (req, res) => {
    try {
        const internshipData = await prisma.estagio.findMany()
        if (internshipData) {
            Logger(`GET - INTERNSHIPS - all-internships`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(internshipData));
        } else {
            Logger(`GET - INTERNSHIPS - all-internships`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'No internship found' });
        }
    } catch (error) {
        Logger(`GET - INTERNSHIPS - all-internships`, `Error fetching internships. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching internships.' });
    }
});

routerInternship.get('/all/:user', validateJWT, async (req, res) => {
    const user = Number(req.params.user);
    try {
        const InternshipData = await prisma.estagio.findMany({
            where: {
                aluno: user
            }
        })

        if (InternshipData) {
            Logger(`GET - INTERNSHIP - internships/${user}`, `200 - Found and Authorized`, "success");
            res.status(200).send(JSON.stringify(InternshipData));
        } else {
            Logger(`GET - INTERNSHIP - internships/${user}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Internship not found!' });
        }
    } catch (error) {
        Logger(`GET - INTERNSHIP - internships/${user}`, `Error fetching requested user. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested user.' });
    }
});







