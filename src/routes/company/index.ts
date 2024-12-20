import { Router } from 'express';
import { extractUserDataFromToken, validateJWT } from '../../middlewares/JWTVerifier';
import prisma from '../../prismaClient'; // Adjust the path as necessary
import { Logger } from '../../middlewares/logger';
import { numberGenerator } from '../../middlewares/randomCodeGenerator';
import { addMonths, parseISO } from 'date-fns';
import { CheckUserExists } from '../../middlewares/checkUserExists';
import { CheckEmpresaExists } from '../../middlewares/checkCompanyExists';
import { CompanyTypeInfo, CompanyTypes } from '../../enum/empresas';


export const routerCompanies = Router()

routerCompanies.get('/', (req, res) => res.send('API de empresas'))

routerCompanies.post('/new', validateJWT, async (req, res) => {
    let { nome, cnpj, emailContato, tipo } = req.body;
    if (!nome || nome.trim() === '') {
        return res.status(400).send({ message: 'Nome é obrigatório.' });
    }
    if (!cnpj || cnpj.trim() === '') {
        return res.status(400).send({ message: 'CNPJ é obrigatório.' });
    }
    try {
        const newCompany = await prisma.empresas.create({
            data: {
                nome,
                cnpj: cnpj ? cnpj : 'Não informado',
                email_contato: emailContato ? emailContato : 'Não informado',
                tipo: Number(tipo)
            }
        })
        Logger('GET - COMPANY -/new', `200 - Nova empresa cadastrada: ${newCompany.nome}`, "success");
        res.status(200).send({ message: 'Empresa criada com sucesso!', empresa: { newCompany } });
    } catch (error) {
        if (error instanceof Error) {
            Logger('GET - COMPANY - /new', `500 - Erro ao cadastrar nova empresa: ${error.message}`, "error");
            console.error('Erro ao cadastrar empresa:', error.message);
            res.status(500).send({ message: 'Erro ao enviar email', error: error.message });
        } else {
            Logger('GET - COMPANY - /new', `500 - Erro ao cadastrar nova empresa: ${JSON.stringify(error)}`, "error");
            console.error('Erro ao ecadastrar empresa: Erro desconhecido');
            res.status(500).send({ message: 'Erro ao enviar email', error: 'Erro desconhecido' });
        }
    }
});

routerCompanies.get('/id/:id', validateJWT, async (req, res) => {
    const companyId = Number(req.params.id);
    try {
        const companyData = await prisma.empresas.findFirst({
            where: {
                id: companyId
            }
        });

        if (companyData) {
            // Enriquecendo o campo tipo com os dados completos do enum
            const tipoKey = companyData.tipo as unknown as CompanyTypes;
            const typeInfo = tipoKey in CompanyTypeInfo
                ? CompanyTypeInfo[tipoKey]
                : CompanyTypeInfo[CompanyTypes.NAO_INFORMADO];

            // Atualiza o campo `tipo` com os dados enriquecidos
            const enrichedCompanyData = {
                ...companyData,
                tipo: typeInfo
            };

            Logger(`GET - COMPANY - id/${companyId}`, `200 - Found and Authorized`, "success");
            res.status(200).json(enrichedCompanyData);
        } else {
            Logger(`GET - COMPANY - id/${companyId}`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'Company not found!' });
        }
    } catch (error) {
        Logger(`GET - COMPANY - id/${companyId}`, `Error fetching requested company. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching requested company.' });
    }
});

routerCompanies.get('/all', validateJWT, async (req, res) => {
    try {
        const companyData = await prisma.empresas.findMany();
        if (companyData && companyData.length > 0) {
            // Mapeia os dados e inclui informações do tipo
            const enrichedCompanyData = companyData.map(company => {
                // Converte para unknown antes de asserir o tipo
                const tipoKey = company.tipo as unknown as CompanyTypes;

                // Verifica se tipoKey é uma chave válida no CompanyTypeInfo
                const typeInfo = tipoKey in CompanyTypeInfo 
                    ? CompanyTypeInfo[tipoKey] 
                    : CompanyTypeInfo[CompanyTypes.NAO_INFORMADO];

                return {
                    ...company,
                    tipo: typeInfo, // Substitui o ID pelo objeto completo do tipo
                };
            });

            Logger(`GET - COMPANY - all-companies`, `200 - Found and Authorized`, "success");
            res.status(200).json(enrichedCompanyData);
        } else {
            Logger(`GET - COMPANY - all-companies`, `404 - Not Found`, "error");
            res.status(404).send({ error: true, message: 'No company found' });
        }
    } catch (error) {
        Logger(`GET - COMPANY - all-companies`, `Error fetching companies. ${JSON.stringify(error)} `, "error");
        res.status(500).json({ message: 'Error fetching companies.' });
    }
});


routerCompanies.get('/types', validateJWT, async (req, res) => {
    res.status(200).send(JSON.stringify(CompanyTypeInfo));
});



