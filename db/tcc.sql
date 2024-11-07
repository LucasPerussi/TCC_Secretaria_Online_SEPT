-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 07, 2024 at 09:28 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tcc`
--

-- --------------------------------------------------------

--
-- Table structure for table `campos_solicitacao`
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
-- Table structure for table `codigos`
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
-- Table structure for table `comentarios`
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
-- Table structure for table `curso`
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
-- Dumping data for table `curso`
--

INSERT INTO `curso` (`id`, `nome`, `descricao`, `coordenador`, `criado_em`, `identificador`, `horas_formativas`, `semestres`) VALUES
(1, 'TADS', 'Técnologia em análise e desenvolvimento de sistemas da UFPR', 24, '2024-10-11 18:31:22', '6P2SEJJ1', 60, 6),
(4, 'TADS', 'Técnologia em análise e desenvolvimento de sistemas da UFPR', 24, '2024-10-11 18:46:20', 'RNA95naa', 60, 6);

-- --------------------------------------------------------

--
-- Table structure for table `empresas`
--

CREATE TABLE `empresas` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cnpj` varchar(20) DEFAULT NULL,
  `email_contato` varchar(255) DEFAULT NULL,
  `tipo` int(11) NOT NULL DEFAULT 99
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `empresas`
--

INSERT INTO `empresas` (`id`, `nome`, `cnpj`, `email_contato`, `tipo`) VALUES
(1, 'Apple', '23.000.000/0001-35', 'perussilucas@apple.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `enum_etapas`
--

CREATE TABLE `enum_etapas` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL DEFAULT '50',
  `label` varchar(255) NOT NULL DEFAULT '100',
  `padrao` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `enum_etapas`
--

INSERT INTO `enum_etapas` (`id`, `nome`, `label`, `padrao`) VALUES
(1, 'Aprovação de professor', 'Etapa de aprovação de professor', 1),
(2, 'Aprovação de admin', 'Etapa de aprovação de admin', 0);

-- --------------------------------------------------------

--
-- Table structure for table `estagio`
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
-- Dumping data for table `estagio`
--

INSERT INTO `estagio` (`id`, `aluno`, `professor_orientador`, `codigo_estagio`, `empresa`, `area_atuacao`, `data_inicio`, `data_renovacao`, `documentos_referencia`, `status`) VALUES
(1, 24, 25, 1880846715, 1, 'Desenvolvimento de Software', '2023-10-11', '2024-04-11', NULL, 1),
(3, 24, 25, 2147483647, 1, 'Desenvolvimento de Software', '2023-10-11', '2024-04-11', NULL, 1),
(8, 24, 25, 2147483647, 1, 'Desenvolvimento de Software', '2023-10-11', '2024-04-11', NULL, 1),
(9, 24, 25, 2147483647, 1, 'Desenvolvimento de Software', '2023-10-11', '2024-04-11', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `etapas_processo`
--

CREATE TABLE `etapas_processo` (
  `id` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `obrigatorio` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fila_emails`
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
-- Dumping data for table `fila_emails`
--

INSERT INTO `fila_emails` (`id`, `identificador`, `destinatario`, `titulo`, `operacao`, `corpo`, `status`, `data`, `usuario`, `sensivel`) VALUES
(1, 'i0f0A5OiSTqfjjJ', 'perussilucas@hotmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-10-10 20:05:21', 24, 1),
(2, 'DvuMdiR90VtDLLl', 'professor@hotmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-10-11 14:06:56', 25, 1),
(3, 'rpuQTmqtCV8FQyA', 'proffdgdfgessor@hotmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-10-23 17:48:20', 26, 1),
(4, '62gHmF4MlWqwof3', 'perussilucas@icloud.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-10-23 18:10:46', 27, 1),
(5, 'bShdgy6fDhtlPQG', 'math_fiori@hotmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-11-04 18:43:21', 28, 1);

-- --------------------------------------------------------

--
-- Table structure for table `horas_formativas`
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
-- Dumping data for table `horas_formativas`
--

INSERT INTO `horas_formativas` (`id`, `aluno`, `servidor_avaliador`, `data_envio`, `data_evento`, `descricao`, `tipo`, `status_aprovacao`, `comprovante`, `horas_solicitadas`, `horas_concedidas`) VALUES
(1, 24, NULL, '2024-10-11 19:49:13', '2023-10-11', 'Participei de um curso de italiano', 1, 1, 'link pro comprovante', 30, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `logins`
--

CREATE TABLE `logins` (
  `id` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `data` datetime NOT NULL,
  `local` varchar(100) NOT NULL,
  `chave_sessao` varchar(60) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `ip` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `logins`
--

INSERT INTO `logins` (`id`, `usuario`, `data`, `local`, `chave_sessao`, `status`, `ip`) VALUES
(20, 27, '2024-10-23 18:12:01', 'Informações de IP não disponíveis', 'ca1d5764e6c9d761', 1, '2001:1284:f502:b70b:d93d:8631:d939:4d1,172.69.11.122'),
(29, 28, '2024-11-04 22:16:44', 'Informações de IP não disponíveis', '5065707f39d20735', 1, '2804:14c:8786:874e:2c89:df4b:94fc:52e5,172.68.206.131'),
(30, 24, '2024-11-07 18:34:38', 'Localhost', '1cc0c3f4380eed12', 1, '::1');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `funcao` varchar(50) NOT NULL,
  `mensagem` varchar(255) NOT NULL,
  `usuario` int(11) DEFAULT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `logs`
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
(72, 'DELETE - HOURS - id/2', '500 - Error fetching record: \nInvalid `prisma.horas_formativas.delete()` invocation in\nC:\\api-tcc\\src\\routes\\trainingHours\\index.ts:56:64\n\n  53 routerTrainingHours.delete(\'/id/:id\', validateJWT, async (req, res) => {\n  54     const recordId = Number(req.p', NULL, 'error'),
(73, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: GRR20193759', NULL, 'error'),
(74, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":26,\"email\":\"proffdgdfgessor@hotmail.com\",\"nome\":\"Lucas\",\"sobrenome\":\"Professor\",\"nascimento\":\"1999-07-28T00:00:00.000Z\",\"registro\":\"PRF20df193759\",\"funcao\":1,\"status_usuario\":1}}', 26, 'success'),
(75, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: proffdgdfgessor@hotmail.com | registro: PRF20df193759', NULL, 'error'),
(76, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info'),
(77, 'sendEmail', 'Enviando email para proffdgdfgessor@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info'),
(78, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success'),
(79, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: perussilucas@hotmail.com', NULL, 'error'),
(80, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: PODGKJSFD0IHJ', NULL, 'error'),
(81, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: PODGKJSFD0IHJ', NULL, 'error'),
(82, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: PODGKJSFD0IHJ', NULL, 'error'),
(83, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: asfdsgfadsgh', NULL, 'error'),
(84, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: perussilucas@hotmail.com', NULL, 'error'),
(85, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: perussilucas@hotmail.com', NULL, 'error'),
(86, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: perussilucas@hotmail.com', NULL, 'error'),
(87, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: perussilucas@hotmail.com', NULL, 'error'),
(88, 'auth/create', '500 - Erro - O PrismaClientKnownRequestError: \nInvalid `prisma.usuario.create()` invocation:\n\n\nThe provided value for the column is too long for the column\'s type. Column: registro', NULL, 'error'),
(89, 'auth/create', '400 - Erro - Motivo: Registro já atrelado a outro usuário! | email: perussilucas@gmail.com | registro: GRR20193759', NULL, 'error'),
(90, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: GRR20193759', NULL, 'error'),
(91, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: GRR20193759', NULL, 'error'),
(92, 'auth/create', '400 - Erro - Motivo: Registro já atrelado a outro usuário! | email: perussilucas@icloud.com | registro: GRR20193759', NULL, 'error'),
(93, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":27,\"email\":\"perussilucas@icloud.com\",\"nome\":\"Lucas\",\"sobrenome\":\"Perussi\",\"nascimento\":\"1999-07-28T00:00:00.000Z\",\"registro\":\"GRR20193750\",\"funcao\":1,\"status_usuario\":1}}', 27, 'success'),
(94, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info'),
(95, 'sendEmail', 'Enviando email para perussilucas@icloud.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info'),
(96, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success'),
(97, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":28,\"email\":\"math_fiori@hotmail.com\",\"nome\":\"Matheus\",\"sobrenome\":\"Fiori\",\"nascimento\":\"2002-01-22T00:00:00.000Z\",\"registro\":\"GRR20211618\",\"funcao\":1,\"status_usuario\":1}}', 28, 'success'),
(98, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info'),
(99, 'sendEmail', 'Enviando email para math_fiori@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info'),
(100, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: math_fiori@hotmail.com | registro: GRR20211618', NULL, 'error'),
(101, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success'),
(102, 'POST - STEPS - NEW', '{\"id\":1,\"nome\":\"Aprovação de professor\",\"label\":\"Etapa de aprovação de professor\",\"padrao\":1}', NULL, 'success'),
(103, 'POST - STEPS - NEW', '{\"id\":2,\"nome\":\"Aprovação de admin\",\"label\":\"Etapa de aprovação de admin\",\"padrao\":0}', NULL, 'success'),
(104, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success'),
(105, 'GET - STEPS - id/1', '200 - Found and Authorized', NULL, 'success'),
(106, 'GET - STEPS - all', '200 - Found and Authorized', NULL, 'success'),
(107, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success'),
(108, 'POST - FIELDS - new-type', '{\"id\":1,\"nome\":\"Aprovação de admin\",\"etiqueta\":\"Etapa de aprovação de admin\",\"obrigatorio\":0,\"tipo_dado\":1,\"campo_padrao\":0}', NULL, 'success'),
(109, 'GET - FIELDS - field-type-id/1', '200 - Found and Authorized', NULL, 'success'),
(110, 'POST - FIELDS - new-type', '{\"id\":2,\"nome\":\"Apasdasdasdn\",\"etiqueta\":\"Etapa de aprovação de admin\",\"obrigatorio\":0,\"tipo_dado\":1,\"campo_padrao\":0}', NULL, 'success'),
(111, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success'),
(112, 'POST - REQUEST TYPE - new', '{\"id\":1,\"nome\":\"processo 1\",\"fluxograma\":\"url\"}', NULL, 'success'),
(113, 'GET - REQUEST TYPE - id/1', '200 - Found and Authorized', NULL, 'success'),
(114, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success'),
(115, 'POST - REQUEST TYPE - new', '{\"id\":2,\"nome\":\"processo 2\",\"fluxograma\":\"url\"}', NULL, 'success'),
(116, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success'),
(117, 'POST - REQUEST TYPE - new', '\nInvalid `prisma.tipo_solicitacao.create()` invocation in\nC:\\api-tcc\\src\\routes\\requestType\\index.ts:14:55\n\n  11 let { nome, fluxograma } = req.body;\n  12 \n  13 try {\n→ 14     const request = await prisma.tipo_solicitacao.create({\n           data: {\n     ', NULL, 'error'),
(118, 'POST - MURAL - new', '\nInvalid `prisma.mural.create()` invocation in\nC:\\api-tcc\\src\\routes\\mural\\index.ts:16:42\n\n  13 \n  14 try {\n  15     const identificador = await codeGenerator(8);\n→ 16     const mural = await prisma.mural.create(\nForeign key constraint failed on the field', NULL, 'error'),
(119, 'POST - MURAL - new', '\nInvalid `prisma.mural.create()` invocation in\nC:\\api-tcc\\src\\routes\\mural\\index.ts:16:42\n\n  13 \n  14 try {\n  15     let identificador = await codeGenerator(20);\n→ 16     const mural = await prisma.mural.create(\nForeign key constraint failed on the field:', NULL, 'error'),
(120, 'POST - MURAL - new', '{\"id\":3,\"titulo\":\"Publicação de teste\",\"descricao\":\"textinho de descricao\",\"identificador\":\"JWnlSXm428KQSKqpYs16\",\"autor\":24,\"data\":\"2024-11-07T20:14:20.000Z\",\"curso_alvo\":1,\"visivel\":1}', NULL, 'success'),
(121, 'GET - MURAL - id/1', '404 - Not Found', NULL, 'error'),
(122, 'GET - MURAL - id/1', '404 - Not Found', NULL, 'error'),
(123, 'GET - MURAL - id/3', '200 - Found and Authorized', NULL, 'success'),
(124, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success'),
(125, 'GET - MURAL - identifier/JWnlSXm428KQSKqpYs16', '200 - Found and Authorized', NULL, 'success');

-- --------------------------------------------------------

--
-- Table structure for table `mural`
--

CREATE TABLE `mural` (
  `id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descricao` text NOT NULL,
  `identificador` varchar(50) NOT NULL,
  `autor` int(11) NOT NULL,
  `data` datetime NOT NULL DEFAULT current_timestamp(),
  `curso_alvo` int(11) NOT NULL,
  `visivel` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mural`
--

INSERT INTO `mural` (`id`, `titulo`, `descricao`, `identificador`, `autor`, `data`, `curso_alvo`, `visivel`) VALUES
(3, 'Publicação de teste', 'textinho de descricao', 'JWnlSXm428KQSKqpYs16', 24, '2024-11-07 20:14:20', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `opcoes_de_campos`
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
-- Table structure for table `processo`
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
-- Table structure for table `respostas_processo`
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
-- Table structure for table `tentativas_login`
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
-- Table structure for table `timelines`
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
-- Dumping data for table `timelines`
--

INSERT INTO `timelines` (`id`, `usuario`, `referencia`, `titulo`, `descricao`, `tipo`) VALUES
(2, 24, '24', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR20193759', 1),
(3, 25, '25', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro PRF20193759', 1),
(4, 26, '26', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro PRF20df193759', 1),
(5, 27, '27', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR20193750', 1),
(6, 28, '28', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR20211618', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tipos_campos`
--

CREATE TABLE `tipos_campos` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `etiqueta` varchar(255) NOT NULL,
  `obrigatorio` int(11) NOT NULL DEFAULT 1,
  `tipo_dado` int(11) NOT NULL,
  `campo_padrao` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tipos_campos`
--

INSERT INTO `tipos_campos` (`id`, `nome`, `etiqueta`, `obrigatorio`, `tipo_dado`, `campo_padrao`) VALUES
(1, 'Aprovação de admin', 'Etapa de aprovação de admin', 0, 1, 0),
(2, 'Apasdasdasdn', 'Etapa de aprovação de admin', 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tipo_solicitacao`
--

CREATE TABLE `tipo_solicitacao` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `fluxograma` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tipo_solicitacao`
--

INSERT INTO `tipo_solicitacao` (`id`, `nome`, `fluxograma`) VALUES
(1, 'processo 1', 'url'),
(2, 'processo 2', 'url');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
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
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id`, `email`, `senha`, `registro`, `nome`, `sobrenome`, `nascimento`, `criado_em`, `funcao`, `foto`, `status_usuario`, `curso`, `status_curso`) VALUES
(24, 'perussilucas@hotmail.com', '$2a$10$WWaHYx2/cfAk2SgNcxKLY.xXcOrImswudv12aQXtUOg9IpVHxkr/W', 'GRR20193759', 'Lucas', 'Perussi', '1999-07-28', '2024-10-10 20:05:21', 1, '', 1, NULL, 1),
(25, 'professor@hotmail.com', '$2a$10$ES5CjJKLmuXbV4OhsX1G3.oafMmsiQHwhAfJV9DVuHbBI658fVcW6', 'PRF20193759', 'Lucas', 'Professor', '1999-07-28', '2024-10-11 14:06:56', 1, '', 1, NULL, 1),
(26, 'proffdgdfgessor@hotmail.com', '$2a$10$ORd9E9JYh6MAwKwE3T.Ouug1Lzsw8Pk/etp0aOvOLCpclfAk9y4Na', 'PRF20df193759', 'Lucas', 'Professor', '1999-07-28', '2024-10-23 17:48:20', 1, '', 1, NULL, 1),
(27, 'perussilucas@icloud.com', '$2a$10$fjQuLnfRhxUzDo2a/VgtA.cTEpKqTccTBvxNtcuD2ckqyWRqDkzoS', 'GRR20193750', 'Lucas', 'Perussi', '1999-07-28', '2024-10-23 18:10:46', 1, '', 1, NULL, 1),
(28, 'math_fiori@hotmail.com', '$2a$10$XU4cEHvwbZFeEySvWWjyUutl75liJOFo5doQpY39vbMWnAqK0GW..', 'GRR20211618', 'Matheus', 'Fiori', '2002-01-22', '2024-11-04 18:43:21', 1, '', 1, NULL, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `campos_solicitacao`
--
ALTER TABLE `campos_solicitacao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tipo` (`tipo`),
  ADD KEY `tipo_processo` (`tipo_processo`);

--
-- Indexes for table `codigos`
--
ALTER TABLE `codigos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`);

--
-- Indexes for table `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `processo` (`processo`),
  ADD KEY `usuario` (`usuario`);

--
-- Indexes for table `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identificador` (`identificador`),
  ADD KEY `curso_fk_coordenador` (`coordenador`);

--
-- Indexes for table `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cnpj` (`cnpj`);

--
-- Indexes for table `enum_etapas`
--
ALTER TABLE `enum_etapas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `estagio`
--
ALTER TABLE `estagio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aluno` (`aluno`),
  ADD KEY `professor_orientador` (`professor_orientador`),
  ADD KEY `empresa` (`empresa`);

--
-- Indexes for table `etapas_processo`
--
ALTER TABLE `etapas_processo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tipo` (`tipo`);

--
-- Indexes for table `fila_emails`
--
ALTER TABLE `fila_emails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `horas_formativas`
--
ALTER TABLE `horas_formativas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aluno` (`aluno`),
  ADD KEY `servidor_avaliador` (`servidor_avaliador`);

--
-- Indexes for table `logins`
--
ALTER TABLE `logins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`);

--
-- Indexes for table `mural`
--
ALTER TABLE `mural`
  ADD PRIMARY KEY (`id`),
  ADD KEY `autor` (`autor`),
  ADD KEY `curso_alvo` (`curso_alvo`);

--
-- Indexes for table `opcoes_de_campos`
--
ALTER TABLE `opcoes_de_campos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tipo` (`tipo`),
  ADD KEY `campo_pai` (`campo_pai`);

--
-- Indexes for table `processo`
--
ALTER TABLE `processo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aluno` (`aluno`),
  ADD KEY `servidor_responsavel` (`servidor_responsavel`),
  ADD KEY `professor_avaliador` (`professor_avaliador`),
  ADD KEY `tipo_solicitacao` (`tipo_solicitacao`),
  ADD KEY `etapa_atual` (`etapa_atual`);

--
-- Indexes for table `respostas_processo`
--
ALTER TABLE `respostas_processo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `processo` (`processo`),
  ADD KEY `campo` (`campo`),
  ADD KEY `usuario` (`usuario`);

--
-- Indexes for table `tentativas_login`
--
ALTER TABLE `tentativas_login`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`);

--
-- Indexes for table `timelines`
--
ALTER TABLE `timelines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`);

--
-- Indexes for table `tipos_campos`
--
ALTER TABLE `tipos_campos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tipo_solicitacao`
--
ALTER TABLE `tipo_solicitacao`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `registro` (`registro`),
  ADD KEY `usuario_fk_curso` (`curso`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `campos_solicitacao`
--
ALTER TABLE `campos_solicitacao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `codigos`
--
ALTER TABLE `codigos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `curso`
--
ALTER TABLE `curso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `enum_etapas`
--
ALTER TABLE `enum_etapas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `estagio`
--
ALTER TABLE `estagio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `etapas_processo`
--
ALTER TABLE `etapas_processo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fila_emails`
--
ALTER TABLE `fila_emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `horas_formativas`
--
ALTER TABLE `horas_formativas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `logins`
--
ALTER TABLE `logins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `mural`
--
ALTER TABLE `mural`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `opcoes_de_campos`
--
ALTER TABLE `opcoes_de_campos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `processo`
--
ALTER TABLE `processo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `respostas_processo`
--
ALTER TABLE `respostas_processo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tentativas_login`
--
ALTER TABLE `tentativas_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `timelines`
--
ALTER TABLE `timelines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tipos_campos`
--
ALTER TABLE `tipos_campos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tipo_solicitacao`
--
ALTER TABLE `tipo_solicitacao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `campos_solicitacao`
--
ALTER TABLE `campos_solicitacao`
  ADD CONSTRAINT `campos_solicitacao_ibfk_1` FOREIGN KEY (`tipo`) REFERENCES `tipos_campos` (`id`),
  ADD CONSTRAINT `campos_solicitacao_ibfk_2` FOREIGN KEY (`tipo_processo`) REFERENCES `tipo_solicitacao` (`id`);

--
-- Constraints for table `codigos`
--
ALTER TABLE `codigos`
  ADD CONSTRAINT `codigos_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`processo`) REFERENCES `processo` (`id`),
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `curso_fk_coordenador` FOREIGN KEY (`coordenador`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `estagio`
--
ALTER TABLE `estagio`
  ADD CONSTRAINT `estagio_ibfk_1` FOREIGN KEY (`aluno`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `estagio_ibfk_2` FOREIGN KEY (`professor_orientador`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `estagio_ibfk_3` FOREIGN KEY (`empresa`) REFERENCES `empresas` (`id`);

--
-- Constraints for table `etapas_processo`
--
ALTER TABLE `etapas_processo`
  ADD CONSTRAINT `etapas_processo_ibfk_1` FOREIGN KEY (`tipo`) REFERENCES `enum_etapas` (`id`);

--
-- Constraints for table `horas_formativas`
--
ALTER TABLE `horas_formativas`
  ADD CONSTRAINT `horas_formativas_ibfk_1` FOREIGN KEY (`aluno`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `horas_formativas_ibfk_2` FOREIGN KEY (`servidor_avaliador`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `logins`
--
ALTER TABLE `logins`
  ADD CONSTRAINT `logins_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `mural`
--
ALTER TABLE `mural`
  ADD CONSTRAINT `mural_ibfk_1` FOREIGN KEY (`autor`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `mural_ibfk_2` FOREIGN KEY (`curso_alvo`) REFERENCES `curso` (`id`);

--
-- Constraints for table `opcoes_de_campos`
--
ALTER TABLE `opcoes_de_campos`
  ADD CONSTRAINT `opcoes_de_campos_ibfk_1` FOREIGN KEY (`tipo`) REFERENCES `tipos_campos` (`id`),
  ADD CONSTRAINT `opcoes_de_campos_ibfk_2` FOREIGN KEY (`campo_pai`) REFERENCES `campos_solicitacao` (`id`);

--
-- Constraints for table `processo`
--
ALTER TABLE `processo`
  ADD CONSTRAINT `processo_ibfk_1` FOREIGN KEY (`aluno`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `processo_ibfk_2` FOREIGN KEY (`servidor_responsavel`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `processo_ibfk_3` FOREIGN KEY (`professor_avaliador`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `processo_ibfk_4` FOREIGN KEY (`tipo_solicitacao`) REFERENCES `tipo_solicitacao` (`id`),
  ADD CONSTRAINT `processo_ibfk_5` FOREIGN KEY (`etapa_atual`) REFERENCES `etapas_processo` (`id`);

--
-- Constraints for table `respostas_processo`
--
ALTER TABLE `respostas_processo`
  ADD CONSTRAINT `respostas_processo_ibfk_1` FOREIGN KEY (`processo`) REFERENCES `processo` (`id`),
  ADD CONSTRAINT `respostas_processo_ibfk_2` FOREIGN KEY (`campo`) REFERENCES `campos_solicitacao` (`id`),
  ADD CONSTRAINT `respostas_processo_ibfk_3` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `tentativas_login`
--
ALTER TABLE `tentativas_login`
  ADD CONSTRAINT `tentativas_login_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `timelines`
--
ALTER TABLE `timelines`
  ADD CONSTRAINT `timelines_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_fk_curso` FOREIGN KEY (`curso`) REFERENCES `curso` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
