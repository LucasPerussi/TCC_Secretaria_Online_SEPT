-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 11-Out-2024 às 21:59
-- Versão do servidor: 10.4.27-MariaDB
-- versão do PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `tcc`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `campos_solicitacao`
--

CREATE TABLE `campos_solicitacao` (
  `id` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `nome_exibicao` varchar(255) NOT NULL,
  `tipo_processo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `codigos`
--

CREATE TABLE `codigos` (
  `id` int(11) NOT NULL,
  `codigo` varchar(60) NOT NULL,
  `data_solicitacao` datetime NOT NULL,
  `usuario` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `comentarios`
--

CREATE TABLE `comentarios` (
  `id` int(11) NOT NULL,
  `processo` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `comentario` varchar(255) NOT NULL,
  `data` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `curso`
--

CREATE TABLE `curso` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `coordenador` int(11) NOT NULL,
  `criado_em` datetime NOT NULL DEFAULT current_timestamp(),
  `identificador` varchar(10) NOT NULL,
  `horas_formativas` int(11) DEFAULT NULL,
  `semestres` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `curso`
--

INSERT INTO `curso` (`id`, `nome`, `descricao`, `coordenador`, `criado_em`, `identificador`, `horas_formativas`, `semestres`) VALUES
(1, 'TADS', 'Técnologia em análise e desenvolvimento de sistemas da UFPR', 24, '2024-10-11 18:31:22', '6P2SEJJ1', 60, 6),
(4, 'TADS', 'Técnologia em análise e desenvolvimento de sistemas da UFPR', 24, '2024-10-11 18:46:20', 'RNA95naa', 60, 6);

-- --------------------------------------------------------

--
-- Estrutura da tabela `empresas`
--

CREATE TABLE `empresas` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cnpj` varchar(20) DEFAULT NULL,
  `email_contato` varchar(255) DEFAULT NULL,
  `tipo` int(11) NOT NULL DEFAULT 99
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `empresas`
--

INSERT INTO `empresas` (`id`, `nome`, `cnpj`, `email_contato`, `tipo`) VALUES
(1, 'Apple', '23.000.000/0001-35', 'perussilucas@apple.com', 1),
(2, 'Apple', '23.000.000/0001-35', 'perussilucas@apple.com', 1),
(3, 'Apple', '23.000.000/0001-35', 'perussilucas@apple.com', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `enum_etapas`
--

CREATE TABLE `enum_etapas` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL DEFAULT '50',
  `label` varchar(255) NOT NULL DEFAULT '100',
  `padrao` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `estagio`
--

CREATE TABLE `estagio` (
  `id` int(11) NOT NULL,
  `aluno` int(11) NOT NULL,
  `professor_orientador` int(11) NOT NULL,
  `codigo_estagio` int(11) NOT NULL,
  `empresa` int(11) NOT NULL,
  `area_atuacao` varchar(100) NOT NULL,
  `data_inicio` date NOT NULL,
  `data_renovacao` date NOT NULL,
  `documentos_referencia` text DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `estagio`
--

INSERT INTO `estagio` (`id`, `aluno`, `professor_orientador`, `codigo_estagio`, `empresa`, `area_atuacao`, `data_inicio`, `data_renovacao`, `documentos_referencia`, `status`) VALUES
(1, 24, 25, 1880846715, 1, 'Desenvolvimento de Software', '2023-10-11', '2024-04-11', NULL, 1),
(3, 24, 25, 2147483647, 1, 'Desenvolvimento de Software', '2023-10-11', '2024-04-11', NULL, 1),
(8, 24, 25, 2147483647, 1, 'Desenvolvimento de Software', '2023-10-11', '2024-04-11', NULL, 1),
(9, 24, 25, 2147483647, 1, 'Desenvolvimento de Software', '2023-10-11', '2024-04-11', NULL, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `etapas_processo`
--

CREATE TABLE `etapas_processo` (
  `id` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `obrigatorio` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `fila_emails`
--

CREATE TABLE `fila_emails` (
  `id` int(11) NOT NULL,
  `identificador` varchar(15) NOT NULL,
  `destinatario` varchar(255) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `operacao` int(5) NOT NULL,
  `corpo` text NOT NULL,
  `status` varchar(3) NOT NULL DEFAULT '1',
  `data` datetime NOT NULL DEFAULT current_timestamp(),
  `usuario` int(10) DEFAULT NULL,
  `sensivel` int(1) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `fila_emails`
--

INSERT INTO `fila_emails` (`id`, `identificador`, `destinatario`, `titulo`, `operacao`, `corpo`, `status`, `data`, `usuario`, `sensivel`) VALUES
(1, 'i0f0A5OiSTqfjjJ', 'perussilucas@hotmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-10-10 20:05:21', 24, 1),
(2, 'DvuMdiR90VtDLLl', 'professor@hotmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-10-11 14:06:56', 25, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `horas_formativas`
--

CREATE TABLE `horas_formativas` (
  `id` int(11) NOT NULL,
  `aluno` int(11) NOT NULL,
  `servidor_avaliador` int(11) DEFAULT NULL,
  `data_envio` datetime NOT NULL,
  `data_evento` date NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `tipo` int(11) NOT NULL,
  `status_aprovacao` int(11) NOT NULL DEFAULT 1,
  `comprovante` text DEFAULT NULL,
  `horas_solicitadas` double NOT NULL,
  `horas_concedidas` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `horas_formativas`
--

INSERT INTO `horas_formativas` (`id`, `aluno`, `servidor_avaliador`, `data_envio`, `data_evento`, `descricao`, `tipo`, `status_aprovacao`, `comprovante`, `horas_solicitadas`, `horas_concedidas`) VALUES
(1, 24, NULL, '2024-10-11 19:49:13', '2023-10-11', 'Participei de um curso de italiano', 1, 1, 'link pro comprovante', 30, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `logins`
--

CREATE TABLE `logins` (
  `id` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `data` datetime NOT NULL,
  `local` varchar(100) NOT NULL,
  `chave_sessao` varchar(60) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `ip` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `logins`
--

INSERT INTO `logins` (`id`, `usuario`, `data`, `local`, `chave_sessao`, `status`, `ip`) VALUES
(12, 24, '2024-10-11 14:47:36', 'Localhost', '9287e9573fc969f4', 1, '::1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `funcao` varchar(50) NOT NULL,
  `mensagem` varchar(255) NOT NULL,
  `usuario` int(11) DEFAULT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `logs`
--

INSERT INTO `logs` (`id`, `funcao`, `mensagem`, `usuario`, `status`) VALUES
(13, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":24,\"email\":\"perussilucas@hotmail.com\",\"nome\":\"Lucas\",\"sobrenome\":\"Perussi\",\"nascimento\":\"1999-07-28T00:00:00.000Z\",\"registro\":\"GRR20193759\",\"funcao\":1,\"status_usuario\":1}}', 24, 'success'),
(14, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info'),
(15, 'sendEmail', 'Enviando email para perussilucas@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info'),
(16, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success'),
(17, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info'),
(18, 'sendEmail', 'Enviando email para perussilucas@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT! 2\"...', NULL, 'info'),
(19, 'sendEmail', 'Invalid login: 535 5.7.139 Authentication unsuccessful, basic authentication is disabled. [CP0PR80CA0014.lamprd80.prod.outlook.com 2024-10-10T20:31:23.429Z 08DCE853B9232A86]', NULL, 'error'),
(20, 'sendEmail', 'Enviando email para perussilucas@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT! 2\"...', NULL, 'info'),
(21, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info'),
(22, 'sendEmail', 'Invalid login: 535 5.7.139 Authentication unsuccessful, basic authentication is disabled. [CP5P284CA0127.BRAP284.PROD.OUTLOOK.COM 2024-10-10T20:33:24.015Z 08DCE94AF0B1CD15]', NULL, 'error'),
(23, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info'),
(24, 'sendEmail', 'Enviando email para perussilucas@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT! 2\"...', NULL, 'info'),
(25, 'sendEmail', 'Invalid login: 535 5.7.139 Authentication unsuccessful, basic authentication is disabled. [CP5P284CA0230.BRAP284.PROD.OUTLOOK.COM 2024-10-10T20:34:18.115Z 08DCE8EEB71AE5A9]', NULL, 'error'),
(26, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info'),
(27, 'sendEmail', 'Enviando email para perussilucas@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT! 2\"...', NULL, 'info'),
(28, 'sendEmail', 'Invalid login: 535 5.7.139 Authentication unsuccessful, basic authentication is disabled. [CP3P284CA0090.BRAP284.PROD.OUTLOOK.COM 2024-10-10T20:40:29.303Z 08DCE752E1A7078E]', NULL, 'error'),
(29, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info'),
(30, 'sendEmail', 'Enviando email para perussilucas@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT! 2\"...', NULL, 'info'),
(31, 'sendEmail', 'Invalid login: 535 5.7.139 Authentication unsuccessful, basic authentication is disabled. [CPYP284CA0058.BRAP284.PROD.OUTLOOK.COM 2024-10-10T20:44:10.565Z 08DCE8E8DEC1D9C7]', NULL, 'error'),
(32, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info'),
(33, 'sendEmail', 'Enviando email para perussilucas@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT! 2\"...', NULL, 'info'),
(34, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success'),
(35, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":25,\"email\":\"professor@hotmail.com\",\"nome\":\"Lucas\",\"sobrenome\":\"Professor\",\"nascimento\":\"1999-07-28T00:00:00.000Z\",\"registro\":\"PRF20193759\",\"funcao\":1,\"status_usuario\":1}}', 25, 'success'),
(36, 'internship/new-company', '200 - Nova empresa cadastrada: Apple', NULL, 'success'),
(37, 'sendEmail', 'Erro durante a verificação de novos registros Error: read ECONNRESET', NULL, 'error'),
(38, 'sendEmail', 'Erro durante a verificação de novos registros Error: read ECONNRESET', NULL, 'error'),
(39, 'GET - company/1', '200 - Found and Authorized', NULL, 'success'),
(40, 'GET - all-company', '200 - Found and Authorized', NULL, 'success'),
(41, 'GET - internships/1', '200 - Found and Authorized', NULL, 'success'),
(42, 'GET - internships/24', '200 - Found and Authorized', NULL, 'success'),
(43, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success'),
(44, 'GET - INTERNSHIP - code/1880846715', '200 - Found and Authorized', NULL, 'success'),
(45, 'GET - COMPANY - internships/24', '200 - Found and Authorized', NULL, 'success'),
(46, 'internship/new-company', '200 - Nova empresa cadastrada: Apple', NULL, 'success'),
(47, 'GET - COMPANY - id/1', '200 - Found and Authorized', NULL, 'success'),
(48, 'GET - COMPANY - all-companies', '200 - Found and Authorized', NULL, 'success'),
(49, 'GET - COURSES - /new', '200 - novo curso cadastrado: TADS', NULL, 'success'),
(50, 'GET - COURSES - id/1', '200 - Found and Authorized', NULL, 'success'),
(51, 'GET - COURSES - id/1', '200 - Found and Authorized', NULL, 'success'),
(52, 'GET - COURSES - id/1', '200 - Found and Authorized', NULL, 'success'),
(53, 'GET - COURSES - id/6P2SEJJ1', '200 - Found and Authorized', NULL, 'success'),
(54, 'GET - Course - all-courses', '200 - Found and Authorized', NULL, 'success'),
(55, 'DELETE - COURSES - id/2', 'Error deleting requested course. {\"name\":\"PrismaClientKnownRequestError\",\"code\":\"P2025\",\"clientVersion\":\"5.5.2\",\"meta\":{\"cause\":\"Record to delete does not exist.\"}} ', NULL, 'error'),
(56, 'GET - COURSES - /new', '200 - novo curso cadastrado: TADS', NULL, 'success'),
(57, 'DELETE - COURSES - id/2', '200 - Found and Authorized', NULL, 'success'),
(58, 'GET - COURSES - /new', '200 - novo curso cadastrado: TADS', NULL, 'success'),
(59, 'DELETE - COURSES - id/Bb6idSsv', '200 - Found and Authorized', NULL, 'success'),
(60, 'GET - Course - all-courses', '200 - Found and Authorized', NULL, 'success'),
(61, 'GET - COURSES - /new', '200 - novo curso cadastrado: TADS', NULL, 'success'),
(62, 'GET - Course - all-courses', '200 - Found and Authorized', NULL, 'success'),
(63, 'POST - HOURS - /new', '200 - New training hours record created: ID 1', NULL, 'success'),
(64, 'GET - HOURS - all-records', '200 - Records fetched successfully', NULL, 'success'),
(65, 'GET - HOURS - id/1', '200 - Found and Authorized', NULL, 'success'),
(66, 'DELETE - HOURS - id/2', '404 - Not Found', NULL, 'error'),
(67, 'POST - HOURS - /new', '200 - New training hours record created: ID 2', NULL, 'success'),
(68, 'DELETE - HOURS - id/2', '200 - Found and Authorized', NULL, 'success'),
(69, 'DELETE - HOURS - id/2', '200 - Found and Authorized', NULL, 'success'),
(70, 'DELETE - HOURS - id/2', '200 - Found and Authorized', NULL, 'success'),
(71, 'DELETE - HOURS - id/2', '200 - Found and Authorized', NULL, 'success'),
(72, 'DELETE - HOURS - id/2', '500 - Error fetching record: \nInvalid `prisma.horas_formativas.delete()` invocation in\nC:\\api-tcc\\src\\routes\\trainingHours\\index.ts:56:64\n\n  53 routerTrainingHours.delete(\'/id/:id\', validateJWT, async (req, res) => {\n  54     const recordId = Number(req.p', NULL, 'error');

-- --------------------------------------------------------

--
-- Estrutura da tabela `mural`
--

CREATE TABLE `mural` (
  `id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descricao` text NOT NULL,
  `identificador` varchar(50) NOT NULL,
  `autor` int(11) NOT NULL,
  `data` datetime NOT NULL,
  `curso_alvo` int(11) NOT NULL,
  `visivel` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `opcoes_de_campos`
--

CREATE TABLE `opcoes_de_campos` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `tipo` int(11) NOT NULL,
  `campo_pai` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `processo`
--

CREATE TABLE `processo` (
  `id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `identificador` int(11) NOT NULL,
  `aluno` int(11) NOT NULL,
  `data_abertura` datetime NOT NULL,
  `servidor_responsavel` int(11) NOT NULL,
  `professor_avaliador` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `justificativa_conclusao` varchar(255) DEFAULT NULL,
  `data_limite_resolucao` datetime DEFAULT NULL,
  `tipo_solicitacao` int(11) NOT NULL,
  `etapa_atual` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `respostas_processo`
--

CREATE TABLE `respostas_processo` (
  `id` int(11) NOT NULL,
  `processo` int(11) NOT NULL,
  `campo` int(11) NOT NULL,
  `resposta` varchar(255) NOT NULL,
  `usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tentativas_login`
--

CREATE TABLE `tentativas_login` (
  `id` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `data_tentativa` datetime NOT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `timelines`
--

CREATE TABLE `timelines` (
  `id` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `referencia` varchar(60) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `tipo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `timelines`
--

INSERT INTO `timelines` (`id`, `usuario`, `referencia`, `titulo`, `descricao`, `tipo`) VALUES
(2, 24, '24', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR20193759', 1),
(3, 25, '25', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro PRF20193759', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipos_campos`
--

CREATE TABLE `tipos_campos` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `etiqueta` varchar(255) NOT NULL,
  `obrigatorio` int(11) NOT NULL DEFAULT 1,
  `tipo_dado` int(11) NOT NULL,
  `campo_padrao` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_solicitacao`
--

CREATE TABLE `tipo_solicitacao` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `fluxograma` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `registro` varchar(15) NOT NULL,
  `nome` varchar(40) NOT NULL,
  `sobrenome` varchar(70) NOT NULL,
  `nascimento` date NOT NULL,
  `criado_em` datetime NOT NULL,
  `funcao` int(11) NOT NULL DEFAULT 1,
  `foto` varchar(255) NOT NULL,
  `status_usuario` int(11) NOT NULL DEFAULT 1,
  `curso` int(11) DEFAULT NULL,
  `status_curso` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`id`, `email`, `senha`, `registro`, `nome`, `sobrenome`, `nascimento`, `criado_em`, `funcao`, `foto`, `status_usuario`, `curso`, `status_curso`) VALUES
(24, 'perussilucas@hotmail.com', '$2a$10$WWaHYx2/cfAk2SgNcxKLY.xXcOrImswudv12aQXtUOg9IpVHxkr/W', 'GRR20193759', 'Lucas', 'Perussi', '1999-07-28', '2024-10-10 20:05:21', 1, '', 1, NULL, 1),
(25, 'professor@hotmail.com', '$2a$10$ES5CjJKLmuXbV4OhsX1G3.oafMmsiQHwhAfJV9DVuHbBI658fVcW6', 'PRF20193759', 'Lucas', 'Professor', '1999-07-28', '2024-10-11 14:06:56', 1, '', 1, NULL, 1);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `campos_solicitacao`
--
ALTER TABLE `campos_solicitacao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tipo` (`tipo`),
  ADD KEY `tipo_processo` (`tipo_processo`);

--
-- Índices para tabela `codigos`
--
ALTER TABLE `codigos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`);

--
-- Índices para tabela `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `processo` (`processo`),
  ADD KEY `usuario` (`usuario`);

--
-- Índices para tabela `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identificador` (`identificador`),
  ADD KEY `curso_fk_coordenador` (`coordenador`);

--
-- Índices para tabela `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `enum_etapas`
--
ALTER TABLE `enum_etapas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `estagio`
--
ALTER TABLE `estagio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aluno` (`aluno`),
  ADD KEY `professor_orientador` (`professor_orientador`),
  ADD KEY `empresa` (`empresa`);

--
-- Índices para tabela `etapas_processo`
--
ALTER TABLE `etapas_processo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tipo` (`tipo`);

--
-- Índices para tabela `fila_emails`
--
ALTER TABLE `fila_emails`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `horas_formativas`
--
ALTER TABLE `horas_formativas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aluno` (`aluno`),
  ADD KEY `servidor_avaliador` (`servidor_avaliador`);

--
-- Índices para tabela `logins`
--
ALTER TABLE `logins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`);

--
-- Índices para tabela `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`);

--
-- Índices para tabela `mural`
--
ALTER TABLE `mural`
  ADD PRIMARY KEY (`id`),
  ADD KEY `autor` (`autor`),
  ADD KEY `curso_alvo` (`curso_alvo`);

--
-- Índices para tabela `opcoes_de_campos`
--
ALTER TABLE `opcoes_de_campos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tipo` (`tipo`),
  ADD KEY `campo_pai` (`campo_pai`);

--
-- Índices para tabela `processo`
--
ALTER TABLE `processo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aluno` (`aluno`),
  ADD KEY `servidor_responsavel` (`servidor_responsavel`),
  ADD KEY `professor_avaliador` (`professor_avaliador`),
  ADD KEY `tipo_solicitacao` (`tipo_solicitacao`),
  ADD KEY `etapa_atual` (`etapa_atual`);

--
-- Índices para tabela `respostas_processo`
--
ALTER TABLE `respostas_processo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `processo` (`processo`),
  ADD KEY `campo` (`campo`),
  ADD KEY `usuario` (`usuario`);

--
-- Índices para tabela `tentativas_login`
--
ALTER TABLE `tentativas_login`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`);

--
-- Índices para tabela `timelines`
--
ALTER TABLE `timelines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`);

--
-- Índices para tabela `tipos_campos`
--
ALTER TABLE `tipos_campos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tipo_solicitacao`
--
ALTER TABLE `tipo_solicitacao`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `registro` (`registro`),
  ADD KEY `usuario_fk_curso` (`curso`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `campos_solicitacao`
--
ALTER TABLE `campos_solicitacao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `codigos`
--
ALTER TABLE `codigos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `curso`
--
ALTER TABLE `curso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `enum_etapas`
--
ALTER TABLE `enum_etapas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `estagio`
--
ALTER TABLE `estagio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `etapas_processo`
--
ALTER TABLE `etapas_processo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `fila_emails`
--
ALTER TABLE `fila_emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `horas_formativas`
--
ALTER TABLE `horas_formativas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `logins`
--
ALTER TABLE `logins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT de tabela `mural`
--
ALTER TABLE `mural`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `opcoes_de_campos`
--
ALTER TABLE `opcoes_de_campos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `processo`
--
ALTER TABLE `processo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `respostas_processo`
--
ALTER TABLE `respostas_processo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tentativas_login`
--
ALTER TABLE `tentativas_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `timelines`
--
ALTER TABLE `timelines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `tipos_campos`
--
ALTER TABLE `tipos_campos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tipo_solicitacao`
--
ALTER TABLE `tipo_solicitacao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `campos_solicitacao`
--
ALTER TABLE `campos_solicitacao`
  ADD CONSTRAINT `campos_solicitacao_ibfk_1` FOREIGN KEY (`tipo`) REFERENCES `tipos_campos` (`id`),
  ADD CONSTRAINT `campos_solicitacao_ibfk_2` FOREIGN KEY (`tipo_processo`) REFERENCES `tipo_solicitacao` (`id`);

--
-- Limitadores para a tabela `codigos`
--
ALTER TABLE `codigos`
  ADD CONSTRAINT `codigos_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`);

--
-- Limitadores para a tabela `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`processo`) REFERENCES `processo` (`id`),
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`);

--
-- Limitadores para a tabela `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `curso_fk_coordenador` FOREIGN KEY (`coordenador`) REFERENCES `usuario` (`id`);

--
-- Limitadores para a tabela `estagio`
--
ALTER TABLE `estagio`
  ADD CONSTRAINT `estagio_ibfk_1` FOREIGN KEY (`aluno`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `estagio_ibfk_2` FOREIGN KEY (`professor_orientador`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `estagio_ibfk_3` FOREIGN KEY (`empresa`) REFERENCES `empresas` (`id`);

--
-- Limitadores para a tabela `etapas_processo`
--
ALTER TABLE `etapas_processo`
  ADD CONSTRAINT `etapas_processo_ibfk_1` FOREIGN KEY (`tipo`) REFERENCES `enum_etapas` (`id`);

--
-- Limitadores para a tabela `horas_formativas`
--
ALTER TABLE `horas_formativas`
  ADD CONSTRAINT `horas_formativas_ibfk_1` FOREIGN KEY (`aluno`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `horas_formativas_ibfk_2` FOREIGN KEY (`servidor_avaliador`) REFERENCES `usuario` (`id`);

--
-- Limitadores para a tabela `logins`
--
ALTER TABLE `logins`
  ADD CONSTRAINT `logins_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`);

--
-- Limitadores para a tabela `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`);

--
-- Limitadores para a tabela `mural`
--
ALTER TABLE `mural`
  ADD CONSTRAINT `mural_ibfk_1` FOREIGN KEY (`autor`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `mural_ibfk_2` FOREIGN KEY (`curso_alvo`) REFERENCES `curso` (`id`);

--
-- Limitadores para a tabela `opcoes_de_campos`
--
ALTER TABLE `opcoes_de_campos`
  ADD CONSTRAINT `opcoes_de_campos_ibfk_1` FOREIGN KEY (`tipo`) REFERENCES `tipos_campos` (`id`),
  ADD CONSTRAINT `opcoes_de_campos_ibfk_2` FOREIGN KEY (`campo_pai`) REFERENCES `campos_solicitacao` (`id`);

--
-- Limitadores para a tabela `processo`
--
ALTER TABLE `processo`
  ADD CONSTRAINT `processo_ibfk_1` FOREIGN KEY (`aluno`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `processo_ibfk_2` FOREIGN KEY (`servidor_responsavel`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `processo_ibfk_3` FOREIGN KEY (`professor_avaliador`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `processo_ibfk_4` FOREIGN KEY (`tipo_solicitacao`) REFERENCES `tipo_solicitacao` (`id`),
  ADD CONSTRAINT `processo_ibfk_5` FOREIGN KEY (`etapa_atual`) REFERENCES `etapas_processo` (`id`);

--
-- Limitadores para a tabela `respostas_processo`
--
ALTER TABLE `respostas_processo`
  ADD CONSTRAINT `respostas_processo_ibfk_1` FOREIGN KEY (`processo`) REFERENCES `processo` (`id`),
  ADD CONSTRAINT `respostas_processo_ibfk_2` FOREIGN KEY (`campo`) REFERENCES `campos_solicitacao` (`id`),
  ADD CONSTRAINT `respostas_processo_ibfk_3` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`);

--
-- Limitadores para a tabela `tentativas_login`
--
ALTER TABLE `tentativas_login`
  ADD CONSTRAINT `tentativas_login_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`);

--
-- Limitadores para a tabela `timelines`
--
ALTER TABLE `timelines`
  ADD CONSTRAINT `timelines_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`);

--
-- Limitadores para a tabela `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_fk_curso` FOREIGN KEY (`curso`) REFERENCES `curso` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
