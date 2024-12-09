
# TCC - Secretaria Online SEPT - UFPR

API responsável pelas funções lógicas da implementação da nova secretaria online do SEPT. Este projeto faz parte do trabalho de conclusão de curso da equipe de graduação em TADS na UFPR.

## 📋 Descrição

A API fornece os serviços necessários para gerenciar as funcionalidades da secretaria online, incluindo autenticação, gerenciamento de usuários e integração com o banco de dados.

## 🚀 Tecnologias Utilizadas

- Node.js
- TypeScript
- Express
- Prisma ORM
- JWT (Json Web Tokens)
- JEST (Testes)

## 🛠️ Instalação

Siga os passos abaixo para configurar o projeto localmente:

### 1. Clone o Repositório

```bash
git clone https://github.com/LucasPerussi/TCC_Secretaria_Online_SEPT.git
```

### 2. Acesse o Diretório do Projeto

```bash
cd TCC_Secretaria_Online_SEPT
```

### 3. Instale as Dependências

Certifique-se de ter o [Node.js](https://nodejs.org/) e o [npm](https://www.npmjs.com/) instalados. Em seguida, execute:

```bash
npm install
```

### 4. Configure o Arquivo `.env`

Crie um arquivo `.env` na raiz do projeto com o seguinte conteúdo:

```
DATABASE_URL=mysql://root:@localhost:3306/tcc
DATABASE_URL_TESTS=mysql://root:@localhost:3306/tcc_tests
```

### 5. Configure o Banco de Dados

1. Crie os bancos de dados `tcc` e `tcc_tests` localmente.
2. Importe o script `tcc.sql`, localizado na pasta `db` do projeto, para ambos os bancos.

### 6. Inicie o Servidor

Para iniciar o servidor em desenvolvimento, execute:

```bash
npm run dev
```

Para rodar os testes, execute:

```bash
npm run test
```

**⚠️ Problemas ao iniciar o projeto?**  
Caso ocorra algum problema, rode os comandos abaixo e tente novamente:

```bash
npx prisma db pull
npx prisma generate
```

## 📖 Documentação Online

Você pode acessar a documentação da API em:

[https://documenter.getpostman.com/view/17286749/2sAY545dog](https://documenter.getpostman.com/view/17286749/2sAY545dog)

## 🔧 Scripts Disponíveis

- **Instalar dependências:**
  ```bash
  npm install
  ```

- **Iniciar servidor em desenvolvimento:**
  ```bash
  npm run dev
  ```

- **Iniciar servidor em produção:**
  ```bash
  npm start
  ```

- **Executar testes:**
  ```bash
  npm run test
  ```



## 📞 Contato

Para mais informações, entre em contato através do [perussilucas@hotmail.com](mailto:perussilucas@hotmail.com).

---