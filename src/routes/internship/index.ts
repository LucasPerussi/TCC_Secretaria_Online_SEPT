import { Router } from 'express';
import { validateJWT } from '../../middlewares/JWTVerifier';
import { PrismaClient } from '@prisma/client';
import { Logger } from '../../middlewares/logger';
import { numberGenerator } from '../../middlewares/randomCodeGenerator';
import { addMonths, parseISO } from 'date-fns';
import { CheckUserExists } from '../../middlewares/checkUserExists';
import { CheckEmpresaExists } from '../../middlewares/checkCompanyExists';


const prisma = new PrismaClient();

export const routerInternship = Router()

routerInternship.get('/', (req, res) => res.send('API de Estágio'))

routerInternship.post('/new', validateJWT, async (req, res) => { 
    let { aluno, professor_orientador, empresa, area_atuacao, data_inicio, duracaoMeses } = req.body;

    const codigoEstagio = await numberGenerator(10);

    // Converter data_inicio para Date usando date-fns
    const dataInicioDate = parseISO(data_inicio);
    if (!dataInicioDate || isNaN(dataInicioDate.getTime())) {
        return res.status(400).json({ message: 'Data de início inválida.' });
    }

    // Garantir que duracaoMeses é um número
    duracaoMeses = Number(duracaoMeses);
    if (isNaN(duracaoMeses)) {
        return res.status(400).json({ message: 'Duração em meses inválida.' });
    }

    // Certificar-se de que IDs são números
    aluno = Number(aluno);
    professor_orientador = Number(professor_orientador);
    empresa = Number(empresa);

    if (isNaN(aluno) || isNaN(professor_orientador) || isNaN(empresa)) {
        return res.status(400).json({ message: 'IDs inválidos fornecidos.' });
    }

    // Verificar se o aluno e o professor existem
    const [studentExists, teacherExists] = await Promise.all([
        CheckUserExists(aluno),
        CheckUserExists(professor_orientador),
    ]);

    if(!studentExists){
        return res.status(404).json({ message: 'Aluno não encontrado.' });
    }

    if(!teacherExists){
        return res.status(404).json({ message: 'Professor não encontrado.' });
    }

    // Verificar se a empresa existe (opcional)
    const empresaExists = await CheckEmpresaExists(empresa);
    if (!empresaExists) {
        return res.status(404).json({ message: 'Empresa não encontrada.' });
    }

    // Calcular data de renovação usando date-fns
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

routerInternship.post('/new-company', validateJWT, async (req, res) => {
    let { nome, cnpj, emailContato, tipo } = req.body;
    try {
        const newCompany = await prisma.empresas.create({
            data: {
               nome, 
               cnpj: cnpj ? cnpj : 'Não informado',
               email_contato: emailContato ? emailContato : 'Não informado',
               tipo: tipo ? tipo : 99
            }
        })
        Logger('internship/new-company', `200 - Nova empresa cadastrada: ${newCompany.nome}`,"success");
        res.status(200).send({ message: 'Empresa criada com sucesso!', empresa: {newCompany}});
    } catch (error) {
        if (error instanceof Error) {
            Logger('internship/new-company', `500 - Erro ao cadastrar nova empresa: ${error.message}`,"error");
            console.error('Erro ao cadastrar empresa:', error.message);
            res.status(500).send({ message: 'Erro ao enviar email', error: error.message });
        } else {
            Logger('internship/new-company', `500 - Erro ao cadastrar nova empresa: ${JSON.stringify(error)}`,"error");
            console.error('Erro ao ecadastrar empresa: Erro desconhecido');
            res.status(500).send({ message: 'Erro ao enviar email', error: 'Erro desconhecido' });
        }
    }
});





