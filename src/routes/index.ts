import { Router } from 'express';

export const router = Router()

const welcome = [
    { 
        mensagem: "Seja bem-vindo (a) à API da Secretaria Online do SEPT", 
        contato: "perussilucas@hotmail.com", 
        status: "API Online"
    },
]

router.get('/', (req, res) => res.send(JSON.stringify(welcome)))