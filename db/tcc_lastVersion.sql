-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 09, 2024 at 01:37 AM
-- Server version: 10.6.18-MariaDB-0ubuntu0.22.04.1
-- PHP Version: 8.2.26

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

--
-- Dumping data for table `campos_solicitacao`
--

INSERT INTO `campos_solicitacao` (`id`, `tipo`, `nome`, `nome_exibicao`, `tipo_processo`) VALUES
(1, 14, 'info', 'Dado a ser alterado', 7),
(2, 15, 'novo', 'Informação atualizada', 7),
(4, 7, 'nome', 'Nome', 7),
(5, 7, 'nome', 'Nome', 6),
(6, 8, 'sobrenome', 'Sobrenome', 6),
(7, 9, 'email', 'Email', 6),
(8, 12, 'data', 'Data', 6),
(10, 8, 'sobrenome', 'Sobrenome', 8),
(11, 9, 'email', 'Email', 8),
(12, 10, 'telefone', 'Telefone', 8),
(13, 11, 'descricao', 'Descrição', 8),
(14, 12, 'data', 'Data', 8),
(15, 13, 'horas', 'Carga Horária', 8),
(17, 7, 'nome', 'Nome', 8),
(18, 16, 'numero_da_cor', 'telefone', 8);

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

--
-- Dumping data for table `comentarios`
--

INSERT INTO `comentarios` (`id`, `processo`, `usuario`, `comentario`, `data`) VALUES
(1, 13, 31, 'kjfkjsfksgs', '2024-12-06 14:39:43'),
(2, 13, 31, 'kjfkjsfksgs', '2024-12-06 14:39:49'),
(3, 13, 31, 'kjfkjsfksgs', '2024-12-06 14:39:49'),
(4, 13, 31, 'kjfkjsfksgs', '2024-12-06 14:39:50'),
(5, 13, 31, 'kjfkjsfksgs', '2024-12-06 14:39:50'),
(6, 13, 31, 'kjfkjsfksgs', '2024-12-06 14:39:50'),
(7, 13, 31, 'kjfkjsfksgs', '2024-12-06 14:39:51'),
(8, 13, 31, 'kjfkjsfksgs', '2024-12-06 14:39:51'),
(9, 13, 31, 'kjfkjsfksgs', '2024-12-06 14:39:51'),
(10, 13, 31, 'pppppp', '2024-12-06 14:39:59');

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
(1, 'Apple', '23.000.000/0001-35', 'perussilucas@apple.com', 1),
(4, 'Teste', '11.000.000/0001-35', 'testeempresa@teste.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `enum_etapas`
--

CREATE TABLE `enum_etapas` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL DEFAULT '50',
  `label` varchar(255) NOT NULL DEFAULT '100',
  `padrao` int(11) NOT NULL DEFAULT 1,
  `estimativaHoras` int(11) NOT NULL DEFAULT 24,
  `cor` varchar(10) NOT NULL DEFAULT '#1E90FF'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 24, 25, 1880846715, 1, 'Desenvolvimento de Software', '2023-10-11', '2024-04-11', NULL, 2),
(3, 24, 25, 2147483647, 1, 'Desenvolvimento de Software', '2023-10-11', '2024-04-11', NULL, 1),
(8, 24, 25, 2147483647, 1, 'Desenvolvimento de Software', '2023-10-11', '2024-04-11', NULL, 1),
(9, 24, 25, 2147483647, 1, 'Desenvolvimento de Software', '2023-10-11', '2024-04-11', NULL, 1),
(10, 31, 25, 2098204026, 1, 'Teste 2', '2024-12-03', '2025-06-03', NULL, 1),
(11, 31, 26, 1603568889, 4, 'Teste', '2024-11-05', '2025-05-05', NULL, 1),
(12, 31, 26, 849276615, 4, 'Teste', '2024-11-05', '2025-05-05', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `etapas_processo`
--

CREATE TABLE `etapas_processo` (
  `id` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `obrigatorio` int(11) NOT NULL DEFAULT 1,
  `proccessTypeId` int(11) NOT NULL,
  `ordem` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `etapas_processo`
--

INSERT INTO `etapas_processo` (`id`, `tipo`, `obrigatorio`, `proccessTypeId`, `ordem`) VALUES
(3, 1, 0, 7, NULL),
(4, 2, 0, 7, NULL),
(5, 7, 0, 7, NULL),
(6, 8, 0, 7, NULL),
(7, 9, 0, 7, NULL),
(8, 1, 0, 6, NULL),
(9, 2, 0, 6, NULL),
(10, 7, 0, 6, NULL),
(11, 8, 0, 6, NULL);

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `fila_emails`
--

INSERT INTO `fila_emails` (`id`, `identificador`, `destinatario`, `titulo`, `operacao`, `corpo`, `status`, `data`, `usuario`, `sensivel`) VALUES
(1, 'i0f0A5OiSTqfjjJ', 'perussilucas@hotmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-10-10 20:05:21', 24, 1),
(2, 'DvuMdiR90VtDLLl', 'professor@hotmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-10-11 14:06:56', 25, 1),
(3, 'rpuQTmqtCV8FQyA', 'proffdgdfgessor@hotmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-10-23 17:48:20', 26, 1),
(4, '62gHmF4MlWqwof3', 'perussilucas@icloud.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-10-23 18:10:46', 27, 1),
(5, 'bShdgy6fDhtlPQG', 'math_fiori@hotmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-11-04 18:43:21', 28, 1),
(6, 'cvUjCtPDl7OzRJm', 'ruan.cunha@ufpr.br', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-11-09 14:13:41', 29, 1),
(7, 'oJ48WPtQ3f9hlyX', 'aluno@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-11-11 23:16:02', 30, 1),
(8, '5GNzHEcO8aazcxU', 'aluno@aluno.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-11-22 11:08:01', 31, 1),
(9, 'EluImU0yDKn4v87', 'teste-erro@erro.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-11-30 11:33:52', 32, 1),
(10, 'uo1d81dezni5xci', 'teste@testou.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-12-06 10:43:29', 33, 1),
(11, '1zwE5Aw6AZCjEvq', 'aluno@lucas.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-12-06 11:44:28', 34, 1),
(12, 'jXt3LabozIx5XEz', 'matheus.fiori@ufpr.br', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-12-06 14:13:44', 35, 1),
(13, 'xI5wMXZrb4OcHGQ', 'cadastro@fix.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-12-06 14:23:36', 36, 1),
(14, '0ZdhUpqbh1HHGuN', 'xcxzc@hotmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-12-06 14:33:37', 37, 1),
(15, 'KYWwbAhIU5CVV4F', 'mathfiori00@gmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-12-08 22:10:14', 38, 1);

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
  `horas_concedidas` double DEFAULT NULL,
  `justificativa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `horas_formativas`
--

INSERT INTO `horas_formativas` (`id`, `aluno`, `servidor_avaliador`, `data_envio`, `data_evento`, `descricao`, `tipo`, `status_aprovacao`, `comprovante`, `horas_solicitadas`, `horas_concedidas`, `justificativa`) VALUES
(1, 24, NULL, '2024-10-11 19:49:13', '2023-10-11', 'Participei de um curso de italiano', 1, 1, 'link pro comprovante', 30, NULL, NULL),
(3, 31, NULL, '2024-11-30 18:51:35', '2023-10-11', 'Participei de um curso de italiano', 1, 1, 'link pro comprovante', 30, NULL, NULL),
(4, 31, NULL, '2024-11-30 18:52:08', '2024-10-11', 'Participei de um curso de francês', 2, 1, 'link pro comprovante', 20, NULL, NULL),
(5, 31, NULL, '2024-11-30 18:52:25', '2024-11-11', 'Participei de um curso de tailandês', 3, 1, 'link pro comprovante', 5, NULL, NULL),
(6, 31, NULL, '2024-11-30 18:52:36', '2024-11-30', 'Participei de um curso de vietnamita', 4, 1, 'link pro comprovante', 5, NULL, NULL),
(7, 31, NULL, '2024-12-01 22:55:19', '2023-10-11', 'Participei de um curso de italiano', 1, 1, 'link pro comprovante', 30, NULL, NULL),
(8, 28, NULL, '2024-12-01 22:56:31', '2023-10-11', 'Participei de um curso de italiano', 1, 1, 'link pro comprovante', 30, NULL, NULL),
(9, 28, NULL, '2024-12-01 22:56:45', '2023-10-16', 'Participei de um curso de francês', 1, 1, 'link pro comprovante', 20, NULL, NULL),
(10, 28, NULL, '2024-12-01 22:56:59', '2023-10-23', 'Participei de um curso de tailandês', 1, 1, 'link pro comprovante', 5, NULL, NULL),
(11, 28, NULL, '2024-12-01 22:57:10', '2023-11-29', 'Participei de um curso de vietnamita', 1, 1, 'link pro comprovante', 5, NULL, NULL),
(12, 31, NULL, '2024-12-02 10:06:53', '2002-01-22', 'Fiz um curso de fiehgiwehfniwjurwehewiug', 5, 1, 'asdafafaf', 9, NULL, NULL),
(13, 31, NULL, '2024-12-06 10:55:27', '1991-11-11', 'dsdadads', 1, 1, 'youtube.com', 20, NULL, NULL),
(14, 31, NULL, '2024-12-06 15:16:48', '1911-11-11', 'sfsfsfds', 1, 1, 'youtube.com', 8, NULL, NULL),
(15, 38, NULL, '2024-12-08 22:16:49', '1994-01-22', 'Participei de alguma coisa', 1, 1, 'youtube.com', 8, NULL, NULL),
(16, 38, NULL, '2024-12-08 22:17:39', '1912-01-01', 'Participei de outra coisa aqui', 2, 1, 'comprovante', 12, NULL, NULL);

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
(40, 30, '2024-11-12 12:07:52', 'Informações de IP não disponíveis', 'd5a319ac9df34d82', 1, '2804:1b3:6080:9c31:13a2:a20d:d5a6:fe21,172.71.238.132'),
(94, 28, '2024-11-30 16:10:26', 'Informações de IP não disponíveis', 'c5c39fe76d99985b', 1, '2804:1b3:6081:2200:5ebb:7217:ab43:7b75,172.69.11.222'),
(96, 32, '2024-11-30 18:46:49', 'Informações de IP não disponíveis', '720a9ca84cb6611a', 1, '2804:1b3:6081:2200:b89d:fdbb:66f6:92c,172.68.19.94'),
(101, 29, '2024-11-30 23:46:06', 'Informações de IP não disponíveis', 'f613a81541b6b1db', 1, '45.230.103.159,172.69.11.219'),
(108, 31, '2024-12-01 18:37:56', 'Informações de IP não disponíveis', '46d906b42e2e757d', 1, '2804:1b3:6081:2200:65ef:a381:a381:2f22,172.71.11.117'),
(109, 24, '2024-12-01 19:09:29', 'Informações de IP não disponíveis', 'f8886bda9dec4ce8', 1, '2804:7f4:309b:2bec:a059:deff:2aad:ff46,172.71.234.200'),
(110, 28, '2024-12-01 22:51:34', 'Informações de IP não disponíveis', '1a150345da2b6603', 1, '2804:1b3:6081:2200:65ef:a381:a381:2f22,172.69.138.209'),
(111, 24, '2024-12-01 22:54:22', 'Informações de IP não disponíveis', 'c6d9aa8cfaf52b07', 1, '179.110.126.57,172.68.18.121'),
(112, 31, '2024-12-01 22:58:29', 'Informações de IP não disponíveis', 'b32636e99d9c3cd9', 1, '2804:1b3:6081:2200:65ef:a381:a381:2f22,172.69.138.106'),
(113, 29, '2024-12-02 00:07:51', 'Informações de IP não disponíveis', 'be3cb8f4b0ab7872', 1, '177.161.199.125,172.71.234.12'),
(114, 29, '2024-12-02 00:18:47', 'Informações de IP não disponíveis', '0ff7c6cd024c36a1', 1, '193.176.127.136,172.69.138.122'),
(115, 29, '2024-12-02 00:22:21', 'Informações de IP não disponíveis', '18813071b8b51c8d', 1, '193.176.127.136,172.71.234.5'),
(116, 31, '2024-12-02 10:04:23', 'Informações de IP não disponíveis', '3c612b68df56f47b', 1, '2804:1b3:6081:2200:5cb6:a70:fa2d:90fe,172.71.234.169'),
(117, 24, '2024-12-02 11:13:42', 'Informações de IP não disponíveis', 'c220e1b0b64ddbc5', 1, '179.110.126.57,172.69.138.123'),
(118, 24, '2024-12-02 16:49:15', 'Informações de IP não disponíveis', '3bfb1c3cdd4070f1', 1, '179.110.126.57,172.71.238.23'),
(119, 31, '2024-12-02 17:07:58', 'Informações de IP não disponíveis', 'ee6d94ba5a630095', 1, '2804:1b3:6081:2200:ad18:8c52:e245:866,172.68.18.52'),
(120, 29, '2024-12-02 21:15:21', 'Informações de IP não disponíveis', '092f63099fb0de61', 1, '189.114.190.151,172.71.6.116'),
(121, 29, '2024-12-02 21:15:25', 'Informações de IP não disponíveis', 'a819a0acf21560c8', 1, '193.19.205.164,172.68.18.52'),
(122, 29, '2024-12-02 23:18:34', 'Informações de IP não disponíveis', 'c2fc3c0fe8b814c9', 1, '193.19.205.164,172.69.11.223'),
(123, 24, '2024-12-02 23:59:10', 'Informações de IP não disponíveis', 'f72f843844577d85', 1, '179.110.126.57,172.69.138.11'),
(124, 24, '2024-12-03 02:03:13', 'Informações de IP não disponíveis', '649de6c892a5a486', 1, '2804:7f4:309b:2bec:98c4:2aee:ee52:eb5e,172.71.6.101'),
(125, 24, '2024-12-03 11:51:58', 'Informações de IP não disponíveis', '1fd6cf07d75669e7', 1, '2804:14c:87c0:c475:8950:af2d:e213:8040,172.68.206.130'),
(126, 28, '2024-12-03 12:17:25', 'Informações de IP não disponíveis', 'cddcc8e18fcec05d', 1, '2804:1b3:6081:2200:5e4:b0dc:81c6:669f,172.69.138.208'),
(127, 31, '2024-12-03 12:18:57', 'Informações de IP não disponíveis', '2344ef545c6457ac', 1, '2804:1b3:6081:2200:5e4:b0dc:81c6:669f,172.71.10.17'),
(128, 24, '2024-12-03 14:26:29', 'Informações de IP não disponíveis', '61a72725fba5fb2c', 1, '179.110.126.57,172.69.11.8'),
(129, 31, '2024-12-04 00:16:39', 'Informações de IP não disponíveis', 'cae22d79952936a6', 1, '2804:1b3:6081:2200:2d12:69d4:d469:b72b,172.69.11.218'),
(130, 28, '2024-12-04 18:38:54', 'Informações de IP não disponíveis', '32805b31f7113720', 1, '2804:1b3:6081:6c7c:f0b9:fec5:ce36:7f8f,172.69.11.223'),
(131, 31, '2024-12-05 00:14:30', 'Informações de IP não disponíveis', 'a61599764ceef06c', 1, '2804:1b3:6081:6c7c:b28d:1fed:f4da:4373,172.71.6.197'),
(132, 28, '2024-12-05 00:16:03', 'Informações de IP não disponíveis', 'e0a7c96412fc4d00', 1, '2804:1b3:6081:6c7c:b28d:1fed:f4da:4373,172.71.6.197'),
(133, 31, '2024-12-05 00:16:15', 'Informações de IP não disponíveis', '07025dda0b3625a1', 1, '2804:1b3:6081:6c7c:b28d:1fed:f4da:4373,172.71.11.159'),
(134, 29, '2024-12-05 07:32:20', 'Informações de IP não disponíveis', '4600c519b4faff30', 1, '45.230.103.53,172.71.6.170'),
(135, 31, '2024-12-05 07:39:37', 'Informações de IP não disponíveis', '49598ff499dfd15b', 1, '45.230.103.53,172.69.11.7'),
(136, 29, '2024-12-05 07:42:16', 'Informações de IP não disponíveis', '89268c97e7d85475', 1, '45.230.103.53,172.71.234.142'),
(137, 31, '2024-12-05 21:34:22', 'Informações de IP não disponíveis', 'c6cac3802d293095', 1, '2804:1b3:6081:6c7c:ad8d:632d:5d70:1584,172.71.234.185'),
(138, 28, '2024-12-05 22:03:28', 'Informações de IP não disponíveis', '82768e1203697fd9', 1, '2804:1b3:6081:6c7c:ad8d:632d:5d70:1584,172.71.10.116'),
(139, 28, '2024-12-05 23:10:00', 'Informações de IP não disponíveis', 'd4aec4b0bb7edfb8', 1, '2804:1b3:6081:6c7c:ad8d:632d:5d70:1584,172.71.11.10'),
(140, 29, '2024-12-06 00:12:50', 'Informações de IP não disponíveis', '5307aefb01f9f3f3', 1, '45.230.103.53,172.71.11.127'),
(141, 24, '2024-12-06 00:16:26', 'Informações de IP não disponíveis', '795a51124294b15f', 1, '177.9.61.84,172.71.10.162'),
(142, 31, '2024-12-06 00:53:33', 'Informações de IP não disponíveis', 'e671dea6f8d7ba89', 1, '185.153.176.11,172.68.18.79'),
(143, 29, '2024-12-06 01:04:03', 'Informações de IP não disponíveis', '0055c5a2a7396335', 1, '185.153.176.11,172.71.234.199'),
(144, 31, '2024-12-06 02:18:58', 'Informações de IP não disponíveis', '82e4a695c3472f2d', 1, '185.153.176.11,172.71.234.217'),
(145, 29, '2024-12-06 07:43:54', 'Informações de IP não disponíveis', '95ddd5b8f6ddbbb0', 1, '185.153.176.11,172.69.11.222'),
(146, 29, '2024-12-06 07:45:23', 'Informações de IP não disponíveis', 'bf2eb9ce215b793c', 1, '185.153.176.11,172.71.234.4'),
(147, 29, '2024-12-06 07:56:41', 'Informações de IP não disponíveis', '4111d3cbd56b1f90', 1, '185.153.176.11,172.69.138.123'),
(148, 24, '2024-12-06 08:12:36', 'Informações de IP não disponíveis', '3a1da7f1549af606', 1, '45.230.103.53,172.68.28.155'),
(149, 24, '2024-12-06 08:13:22', 'Informações de IP não disponíveis', 'cdee46984bd64ee2', 1, '45.230.103.53,172.68.28.148'),
(150, 28, '2024-12-06 10:41:26', 'Informações de IP não disponíveis', '530dde4268404246', 1, '2804:1b3:6081:6c7c:2549:a809:f0f6:68b5,172.71.234.142'),
(151, 31, '2024-12-06 10:48:10', 'Informações de IP não disponíveis', '58d1af76b400cb9b', 1, '2804:1b3:6081:6c7c:2549:a809:f0f6:68b5,172.68.18.239'),
(152, 28, '2024-12-06 10:58:47', 'Informações de IP não disponíveis', 'ed6065e33ec73705', 1, '2804:1b3:6081:6c7c:2549:a809:f0f6:68b5,172.71.10.116'),
(153, 24, '2024-12-06 11:43:10', 'Informações de IP não disponíveis', 'a2a164f9bdf46e46', 1, '2804:14c:87c0:c475:5df2:7b5a:bbb4:f7f2,172.68.206.137'),
(154, 34, '2024-12-06 11:46:29', 'Informações de IP não disponíveis', '31c92382c3254dd6', 1, '2804:14c:87c0:c475:5df2:7b5a:bbb4:f7f2,172.68.206.131'),
(155, 24, '2024-12-06 11:51:34', 'Informações de IP não disponíveis', 'a72dbb5d6103c15a', 1, '2804:14c:87c0:c475:5df2:7b5a:bbb4:f7f2,172.68.206.137'),
(156, 28, '2024-12-06 14:20:53', 'Informações de IP não disponíveis', 'ace6ae8d7f4cd3d0', 1, '2804:1b3:6081:6c7c:7751:dd66:9a52:3410,172.71.11.159'),
(157, 37, '2024-12-06 14:33:37', 'Informações de IP não disponíveis', '73fa8746258b853b', 1, '2804:14c:87c0:c475:5df2:7b5a:bbb4:f7f2,172.68.206.130'),
(158, 28, '2024-12-06 14:36:23', 'Informações de IP não disponíveis', '196780e095611269', 1, '2804:1b3:6081:6c7c:7751:dd66:9a52:3410,172.69.138.11'),
(159, 31, '2024-12-06 16:37:18', 'Informações de IP não disponíveis', '2e1ddd610b7e593b', 1, '45.230.103.53,172.68.28.163'),
(160, 29, '2024-12-06 17:17:34', 'Informações de IP não disponíveis', '96628a1c36bb341c', 1, '45.230.103.53,172.68.28.162'),
(161, 31, '2024-12-06 17:29:35', 'Informações de IP não disponíveis', '84b64602367c8ad0', 1, '45.230.103.53,172.68.28.154'),
(162, 24, '2024-12-06 18:46:44', 'Informações de IP não disponíveis', 'b5d530cba9b9eb7b', 1, '45.230.103.53,172.68.28.155'),
(163, 27, '2024-12-06 18:57:50', 'Informações de IP não disponíveis', '861d908633cbc467', 1, '2804:14c:87c0:c475:5df2:7b5a:bbb4:f7f2,172.68.206.139'),
(164, 24, '2024-12-06 18:58:13', 'Informações de IP não disponíveis', '8cf89036ad692507', 1, '2804:14c:87c0:c475:5df2:7b5a:bbb4:f7f2,172.68.206.130'),
(165, 27, '2024-12-06 18:59:22', 'Informações de IP não disponíveis', '88a5e39f3ec3c059', 1, '2804:14c:87c0:c475:5df2:7b5a:bbb4:f7f2,172.68.206.139'),
(166, 24, '2024-12-06 19:00:16', 'Informações de IP não disponíveis', '12bd8a71003357c4', 1, '2804:14c:87c0:c475:5df2:7b5a:bbb4:f7f2,172.68.206.133'),
(167, 36, '2024-12-06 19:01:00', 'Informações de IP não disponíveis', '7cb28566bcaa1d9e', 1, '2804:14c:87c0:c475:5df2:7b5a:bbb4:f7f2,172.68.206.137'),
(168, 31, '2024-12-06 22:14:17', 'Informações de IP não disponíveis', 'f91106e6b2878bef', 1, '45.230.103.53,172.71.234.142'),
(169, 28, '2024-12-07 01:10:55', 'Informações de IP não disponíveis', 'eaaf150d630b0ab3', 1, '2804:1b3:6081:86ad:8e18:48a1:b4fd:a069,172.71.11.128'),
(170, 28, '2024-12-07 14:05:39', 'Informações de IP não disponíveis', 'ece66c03bd989091', 1, '2804:1b3:6081:86ad:21d3:8d55:87fa:34a,172.69.138.209'),
(171, 28, '2024-12-07 20:13:52', 'Informações de IP não disponíveis', '609c11d86695980b', 1, '2804:1b3:6081:86ad:21d3:8d55:87fa:34a,172.68.19.32'),
(172, 28, '2024-12-08 11:38:44', 'Informações de IP não disponíveis', 'f9bb1b29f2f82af7', 1, '2804:1b3:6081:86ad:867b:8851:63b7:1d97,172.71.11.18'),
(173, 24, '2024-12-08 18:26:54', 'Informações de IP não disponíveis', 'ed210536fec8bc10', 1, '45.230.103.53,172.68.28.155'),
(174, 28, '2024-12-08 18:39:13', 'Informações de IP não disponíveis', '3cd75d51cd83c395', 1, '2804:1b3:6081:86ad:e15d:7a03:e850:97fb,172.69.138.11'),
(175, 29, '2024-12-08 22:08:45', 'Informações de IP não disponíveis', '6838a81af4e21c27', 1, '45.230.103.53,172.68.28.148'),
(176, 38, '2024-12-08 22:10:14', 'Informações de IP não disponíveis', '007f7d7bd5610046', 1, '2804:1b3:6081:86ad:f123:6998:861a:3e36,172.71.234.120'),
(177, 29, '2024-12-08 22:11:12', 'Informações de IP não disponíveis', 'f6bbc1330ca18cc6', 1, '45.230.103.53,172.68.28.148'),
(178, 24, '2024-12-08 22:11:55', 'Informações de IP não disponíveis', '64c7c3ceb8d7f500', 1, '45.230.103.53,172.68.28.163'),
(179, 29, '2024-12-08 22:12:47', 'Informações de IP não disponíveis', '6365af2c7ce864f1', 1, '45.230.103.53,172.68.28.155'),
(180, 24, '2024-12-08 23:21:11', 'Informações de IP não disponíveis', 'c60112fc8e46bf4e', 1, '45.230.103.53,172.68.28.154'),
(181, 24, '2024-12-09 00:22:36', 'Informações de IP não disponíveis', 'a14b7acf43170e8d', 1, '179.94.45.189,172.68.19.186');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `funcao` varchar(50) NOT NULL,
  `mensagem` varchar(255) NOT NULL,
  `usuario` int(11) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `data` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `funcao`, `mensagem`, `usuario`, `status`, `data`) VALUES
(13, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":24,\"email\":\"perussilucas@hotmail.com\",\"nome\":\"Lucas\",\"sobrenome\":\"Perussi\",\"nascimento\":\"1999-07-28T00:00:00.000Z\",\"registro\":\"GRR20193759\",\"funcao\":1,\"status_usuario\":1}}', 24, 'success', '2024-12-02 00:00:00'),
(14, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-02 00:00:00'),
(15, 'sendEmail', 'Enviando email para perussilucas@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info', '2024-12-02 00:00:00'),
(16, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success', '2024-12-02 00:00:00'),
(17, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-02 00:00:00'),
(18, 'sendEmail', 'Enviando email para perussilucas@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT! 2\"...', NULL, 'info', '2024-12-02 00:00:00'),
(19, 'sendEmail', 'Invalid login: 535 5.7.139 Authentication unsuccessful, basic authentication is disabled. [CP0PR80CA0014.lamprd80.prod.outlook.com 2024-10-10T20:31:23.429Z 08DCE853B9232A86]', NULL, 'error', '2024-12-02 00:00:00'),
(20, 'sendEmail', 'Enviando email para perussilucas@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT! 2\"...', NULL, 'info', '2024-12-02 00:00:00'),
(21, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-02 00:00:00'),
(22, 'sendEmail', 'Invalid login: 535 5.7.139 Authentication unsuccessful, basic authentication is disabled. [CP5P284CA0127.BRAP284.PROD.OUTLOOK.COM 2024-10-10T20:33:24.015Z 08DCE94AF0B1CD15]', NULL, 'error', '2024-12-02 00:00:00'),
(23, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-02 00:00:00'),
(24, 'sendEmail', 'Enviando email para perussilucas@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT! 2\"...', NULL, 'info', '2024-12-02 00:00:00'),
(25, 'sendEmail', 'Invalid login: 535 5.7.139 Authentication unsuccessful, basic authentication is disabled. [CP5P284CA0230.BRAP284.PROD.OUTLOOK.COM 2024-10-10T20:34:18.115Z 08DCE8EEB71AE5A9]', NULL, 'error', '2024-12-02 00:00:00'),
(26, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-02 00:00:00'),
(27, 'sendEmail', 'Enviando email para perussilucas@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT! 2\"...', NULL, 'info', '2024-12-02 00:00:00'),
(28, 'sendEmail', 'Invalid login: 535 5.7.139 Authentication unsuccessful, basic authentication is disabled. [CP3P284CA0090.BRAP284.PROD.OUTLOOK.COM 2024-10-10T20:40:29.303Z 08DCE752E1A7078E]', NULL, 'error', '2024-12-02 00:00:00'),
(29, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-02 00:00:00'),
(30, 'sendEmail', 'Enviando email para perussilucas@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT! 2\"...', NULL, 'info', '2024-12-02 00:00:00'),
(31, 'sendEmail', 'Invalid login: 535 5.7.139 Authentication unsuccessful, basic authentication is disabled. [CPYP284CA0058.BRAP284.PROD.OUTLOOK.COM 2024-10-10T20:44:10.565Z 08DCE8E8DEC1D9C7]', NULL, 'error', '2024-12-02 00:00:00'),
(32, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-02 00:00:00'),
(33, 'sendEmail', 'Enviando email para perussilucas@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT! 2\"...', NULL, 'info', '2024-12-02 00:00:00'),
(34, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success', '2024-12-02 00:00:00'),
(35, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":25,\"email\":\"professor@hotmail.com\",\"nome\":\"Lucas\",\"sobrenome\":\"Professor\",\"nascimento\":\"1999-07-28T00:00:00.000Z\",\"registro\":\"PRF20193759\",\"funcao\":1,\"status_usuario\":1}}', 25, 'success', '2024-12-02 00:00:00'),
(36, 'internship/new-company', '200 - Nova empresa cadastrada: Apple', NULL, 'success', '2024-12-02 00:00:00'),
(37, 'sendEmail', 'Erro durante a verificação de novos registros Error: read ECONNRESET', NULL, 'error', '2024-12-02 00:00:00'),
(38, 'sendEmail', 'Erro durante a verificação de novos registros Error: read ECONNRESET', NULL, 'error', '2024-12-02 00:00:00'),
(39, 'GET - company/1', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(40, 'GET - all-company', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(41, 'GET - internships/1', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(42, 'GET - internships/24', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(43, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(44, 'GET - INTERNSHIP - code/1880846715', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(45, 'GET - COMPANY - internships/24', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(46, 'internship/new-company', '200 - Nova empresa cadastrada: Apple', NULL, 'success', '2024-12-02 00:00:00'),
(47, 'GET - COMPANY - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(48, 'GET - COMPANY - all-companies', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(49, 'GET - COURSES - /new', '200 - novo curso cadastrado: TADS', NULL, 'success', '2024-12-02 00:00:00'),
(50, 'GET - COURSES - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(51, 'GET - COURSES - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(52, 'GET - COURSES - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(53, 'GET - COURSES - id/6P2SEJJ1', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(54, 'GET - Course - all-courses', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(55, 'DELETE - COURSES - id/2', 'Error deleting requested course. {\"name\":\"PrismaClientKnownRequestError\",\"code\":\"P2025\",\"clientVersion\":\"5.5.2\",\"meta\":{\"cause\":\"Record to delete does not exist.\"}} ', NULL, 'error', '2024-12-02 00:00:00'),
(56, 'GET - COURSES - /new', '200 - novo curso cadastrado: TADS', NULL, 'success', '2024-12-02 00:00:00'),
(57, 'DELETE - COURSES - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(58, 'GET - COURSES - /new', '200 - novo curso cadastrado: TADS', NULL, 'success', '2024-12-02 00:00:00'),
(59, 'DELETE - COURSES - id/Bb6idSsv', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(60, 'GET - Course - all-courses', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(61, 'GET - COURSES - /new', '200 - novo curso cadastrado: TADS', NULL, 'success', '2024-12-02 00:00:00'),
(62, 'GET - Course - all-courses', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(63, 'POST - HOURS - /new', '200 - New training hours record created: ID 1', NULL, 'success', '2024-12-02 00:00:00'),
(64, 'GET - HOURS - all-records', '200 - Records fetched successfully', NULL, 'success', '2024-12-02 00:00:00'),
(65, 'GET - HOURS - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(66, 'DELETE - HOURS - id/2', '404 - Not Found', NULL, 'error', '2024-12-02 00:00:00'),
(67, 'POST - HOURS - /new', '200 - New training hours record created: ID 2', NULL, 'success', '2024-12-02 00:00:00'),
(68, 'DELETE - HOURS - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(69, 'DELETE - HOURS - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(70, 'DELETE - HOURS - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(71, 'DELETE - HOURS - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(72, 'DELETE - HOURS - id/2', '500 - Error fetching record: \nInvalid `prisma.horas_formativas.delete()` invocation in\nC:\\api-tcc\\src\\routes\\trainingHours\\index.ts:56:64\n\n  53 routerTrainingHours.delete(\'/id/:id\', validateJWT, async (req, res) => {\n  54     const recordId = Number(req.p', NULL, 'error', '2024-12-02 00:00:00'),
(73, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: GRR20193759', NULL, 'error', '2024-12-02 00:00:00'),
(74, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":26,\"email\":\"proffdgdfgessor@hotmail.com\",\"nome\":\"Lucas\",\"sobrenome\":\"Professor\",\"nascimento\":\"1999-07-28T00:00:00.000Z\",\"registro\":\"PRF20df193759\",\"funcao\":1,\"status_usuario\":1}}', 26, 'success', '2024-12-02 00:00:00'),
(75, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: proffdgdfgessor@hotmail.com | registro: PRF20df193759', NULL, 'error', '2024-12-02 00:00:00'),
(76, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-02 00:00:00'),
(77, 'sendEmail', 'Enviando email para proffdgdfgessor@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info', '2024-12-02 00:00:00'),
(78, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success', '2024-12-02 00:00:00'),
(79, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: perussilucas@hotmail.com', NULL, 'error', '2024-12-02 00:00:00'),
(80, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: PODGKJSFD0IHJ', NULL, 'error', '2024-12-02 00:00:00'),
(81, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: PODGKJSFD0IHJ', NULL, 'error', '2024-12-02 00:00:00'),
(82, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: PODGKJSFD0IHJ', NULL, 'error', '2024-12-02 00:00:00'),
(83, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: asfdsgfadsgh', NULL, 'error', '2024-12-02 00:00:00'),
(84, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: perussilucas@hotmail.com', NULL, 'error', '2024-12-02 00:00:00'),
(85, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: perussilucas@hotmail.com', NULL, 'error', '2024-12-02 00:00:00'),
(86, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: perussilucas@hotmail.com', NULL, 'error', '2024-12-02 00:00:00'),
(87, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: perussilucas@hotmail.com', NULL, 'error', '2024-12-02 00:00:00'),
(88, 'auth/create', '500 - Erro - O PrismaClientKnownRequestError: \nInvalid `prisma.usuario.create()` invocation:\n\n\nThe provided value for the column is too long for the column\'s type. Column: registro', NULL, 'error', '2024-12-02 00:00:00'),
(89, 'auth/create', '400 - Erro - Motivo: Registro já atrelado a outro usuário! | email: perussilucas@gmail.com | registro: GRR20193759', NULL, 'error', '2024-12-02 00:00:00'),
(90, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: GRR20193759', NULL, 'error', '2024-12-02 00:00:00'),
(91, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: perussilucas@hotmail.com | registro: GRR20193759', NULL, 'error', '2024-12-02 00:00:00'),
(92, 'auth/create', '400 - Erro - Motivo: Registro já atrelado a outro usuário! | email: perussilucas@icloud.com | registro: GRR20193759', NULL, 'error', '2024-12-02 00:00:00'),
(93, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":27,\"email\":\"perussilucas@icloud.com\",\"nome\":\"Lucas\",\"sobrenome\":\"Perussi\",\"nascimento\":\"1999-07-28T00:00:00.000Z\",\"registro\":\"GRR20193750\",\"funcao\":1,\"status_usuario\":1}}', 27, 'success', '2024-12-02 00:00:00'),
(94, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-02 00:00:00'),
(95, 'sendEmail', 'Enviando email para perussilucas@icloud.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info', '2024-12-02 00:00:00'),
(96, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success', '2024-12-02 00:00:00'),
(97, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":28,\"email\":\"math_fiori@hotmail.com\",\"nome\":\"Matheus\",\"sobrenome\":\"Fiori\",\"nascimento\":\"2002-01-22T00:00:00.000Z\",\"registro\":\"GRR20211618\",\"funcao\":1,\"status_usuario\":1}}', 28, 'success', '2024-12-02 00:00:00'),
(98, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-02 00:00:00'),
(99, 'sendEmail', 'Enviando email para math_fiori@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info', '2024-12-02 00:00:00'),
(100, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: math_fiori@hotmail.com | registro: GRR20211618', NULL, 'error', '2024-12-02 00:00:00'),
(101, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success', '2024-12-02 00:00:00'),
(102, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":29,\"email\":\"ruan.cunha@ufpr.br\",\"nome\":\"Ruan\",\"sobrenome\":\"Brito\",\"nascimento\":\"1998-09-06T00:00:00.000Z\",\"registro\":\"GRR20220043\",\"funcao\":1,\"status_usuario\":1}}', 29, 'success', '2024-12-02 00:00:00'),
(103, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-02 00:00:00'),
(104, 'sendEmail', 'Enviando email para ruan.cunha@ufpr.br com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info', '2024-12-02 00:00:00'),
(105, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success', '2024-12-02 00:00:00'),
(106, 'auth/create', '400 - Erro - Motivo: Registro já atrelado a outro usuário! | email: aluno@teste.com | registro: GRR20211618', NULL, 'error', '2024-12-02 00:00:00'),
(107, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":30,\"email\":\"aluno@teste.com\",\"nome\":\"Matheus\",\"sobrenome\":\"Aluno\",\"nascimento\":\"2002-01-22T00:00:00.000Z\",\"registro\":\"GRR20291618\",\"funcao\":1,\"status_usuario\":1}}', 30, 'success', '2024-12-02 00:00:00'),
(108, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-02 00:00:00'),
(109, 'sendEmail', 'Enviando email para aluno@teste.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info', '2024-12-02 00:00:00'),
(110, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success', '2024-12-02 00:00:00'),
(111, 'GET - REQUEST TYPE - id/1', '404 - Not Found', NULL, 'error', '2024-12-02 00:00:00'),
(112, 'GET - REQUEST TYPE - id/2', '404 - Not Found', NULL, 'error', '2024-12-02 00:00:00'),
(113, 'GET - REQUEST TYPE - id/5', '404 - Not Found', NULL, 'error', '2024-12-02 00:00:00'),
(114, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(115, 'GET - USERS - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(116, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":31,\"email\":\"aluno@aluno.com\",\"nome\":\"Aluno\",\"sobrenome\":\"da Silva\",\"nascimento\":\"2001-07-28T00:00:00.000Z\",\"registro\":\"grr99999999\",\"funcao\":1,\"status_usuario\":1}}', 31, 'success', '2024-12-02 00:00:00'),
(117, 'sendEmail', 'Enviando email para aluno@aluno.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info', '2024-12-02 00:00:00'),
(118, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-02 00:00:00'),
(119, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success', '2024-12-02 00:00:00'),
(120, 'GET - HOURS - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(121, 'GET - USERS - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(122, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(123, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(124, 'GET - HOURS - by-student/24', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(125, 'GET - COURSES - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(126, 'GET - USERS - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(127, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(128, 'GET - STEPS - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(129, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(130, 'GET - REQUEST TYPE - id/1', '404 - Not Found', NULL, 'error', '2024-12-02 00:00:00'),
(131, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(132, 'auth/create', '400 - Erro - Motivo: Registro já atrelado a outro usuário! | email: teste-erro@erro.com | registro: PRF20df193759', NULL, 'error', '2024-12-02 00:00:00'),
(133, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":32,\"email\":\"teste-erro@erro.com\",\"nome\":\"Teste\",\"sobrenome\":\"de Erro\",\"nascimento\":\"1999-07-28T00:00:00.000Z\",\"registro\":\"343434343\",\"funcao\":1,\"status_usuario\":1}}', 32, 'success', '2024-12-02 00:00:00'),
(134, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-02 00:00:00'),
(135, 'sendEmail', 'Enviando email para teste-erro@erro.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info', '2024-12-02 00:00:00'),
(136, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success', '2024-12-02 00:00:00'),
(137, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(138, 'POST - REQUEST TYPE - new', '{\"id\":1,\"nome\":\"processo 3\",\"fluxograma\":\"url\",\"hrs_resposta\":null,\"hrs_resolucao\":null}', NULL, 'success', '2024-12-02 00:00:00'),
(139, 'GET - USERS - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(140, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(141, 'POST - HOURS - /new', '200 - New training hours record created: ID 3', NULL, 'success', '2024-12-02 00:00:00'),
(142, 'POST - HOURS - /new', '200 - New training hours record created: ID 4', NULL, 'success', '2024-12-02 00:00:00'),
(143, 'POST - HOURS - /new', '200 - New training hours record created: ID 5', NULL, 'success', '2024-12-02 00:00:00'),
(144, 'POST - HOURS - /new', '200 - New training hours record created: ID 6', NULL, 'success', '2024-12-02 00:00:00'),
(145, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(146, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(147, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(148, 'GET - HOURS - by-student/28', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(149, 'POST - HOURS - /new', '200 - New training hours record created: ID 7', NULL, 'success', '2024-12-02 00:00:00'),
(150, 'GET - USERS - id/27', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(151, 'GET - USERS - id/21', '404 - Not Found', NULL, 'error', '2024-12-02 00:00:00'),
(152, 'GET - USERS - id/22', '404 - Not Found', NULL, 'error', '2024-12-02 00:00:00'),
(153, 'GET - USERS - id/23', '404 - Not Found', NULL, 'error', '2024-12-02 00:00:00'),
(154, 'GET - USERS - id/28', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(155, 'POST - HOURS - /new', '200 - New training hours record created: ID 8', NULL, 'success', '2024-12-02 00:00:00'),
(156, 'POST - HOURS - /new', '200 - New training hours record created: ID 9', NULL, 'success', '2024-12-02 00:00:00'),
(157, 'POST - HOURS - /new', '200 - New training hours record created: ID 10', NULL, 'success', '2024-12-02 00:00:00'),
(158, 'POST - HOURS - /new', '200 - New training hours record created: ID 11', NULL, 'success', '2024-12-02 00:00:00'),
(159, 'GET - HOURS - by-student/28', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(160, 'GET - HOURS - by-student/28', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(161, 'GET - HOURS - by-student/28', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(162, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(163, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(164, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(165, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(166, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(167, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(168, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(169, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(170, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(171, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(172, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(173, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(174, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(175, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(176, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(177, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(178, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(179, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(180, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(181, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(182, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(183, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(184, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(185, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(186, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(187, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(188, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(189, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(190, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(191, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(192, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(193, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(194, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(195, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(196, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(197, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(198, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(199, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(200, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(201, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(202, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(203, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(204, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(205, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(206, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(207, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(208, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(209, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(210, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(211, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(212, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(213, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(214, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(215, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(216, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(217, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(218, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(219, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(220, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(221, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(222, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(223, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(224, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(225, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(226, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(227, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(228, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(229, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(230, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(231, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(232, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(233, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(234, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(235, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(236, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(237, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(238, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(239, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(240, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(241, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(242, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(243, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(244, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(245, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(246, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(247, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(248, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(249, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(250, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(251, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(252, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(253, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(254, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(255, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(256, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(257, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(258, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(259, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(260, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(261, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(262, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(263, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(264, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(265, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(266, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(267, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(268, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(269, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(270, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(271, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(272, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(273, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(274, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(275, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(276, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(277, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(278, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(279, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(280, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(281, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(282, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(283, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(284, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(285, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(286, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(287, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(288, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(289, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(290, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(291, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(292, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(293, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(294, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(295, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(296, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(297, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(298, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(299, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(300, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(301, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(302, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(303, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(304, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(305, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(306, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(307, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(308, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(309, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(310, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(311, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(312, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(313, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(314, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(315, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(316, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(317, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(318, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(319, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(320, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(321, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(322, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(323, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(324, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(325, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(326, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(327, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(328, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(329, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(330, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(331, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(332, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(333, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(334, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(335, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(336, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(337, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(338, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(339, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(340, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(341, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(342, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(343, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(344, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(345, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(346, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(347, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(348, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(349, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(350, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(351, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(352, 'GET - STEPS - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(353, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(354, 'GET - SYSTEM - logins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(355, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(356, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(357, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(358, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(359, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(360, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(361, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(362, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(363, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(364, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(365, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(366, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(367, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(368, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(369, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(370, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(371, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(372, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(373, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(374, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(375, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(376, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(377, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(378, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(379, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(380, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(381, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(382, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(383, 'GET - STEPS - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(384, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(385, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(386, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(387, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(388, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(389, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(390, 'GET - COMENTARIOS - /all-from-proccess/1', '404 - Not Found', NULL, 'error', '2024-12-02 00:00:00'),
(391, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(392, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(393, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(394, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(395, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(396, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(397, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(398, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(399, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(400, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(401, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(402, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(403, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(404, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(405, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(406, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(407, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(408, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(409, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(410, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(411, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(412, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(413, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(414, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(415, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(416, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(417, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(418, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(419, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(420, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(421, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(422, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(423, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(424, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(425, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(426, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(427, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(428, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(429, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(430, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(431, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(432, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(433, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(434, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(435, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(436, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(437, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(438, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(439, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(440, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(441, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(442, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00');
INSERT INTO `logs` (`id`, `funcao`, `mensagem`, `usuario`, `status`, `data`) VALUES
(443, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(444, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(445, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(446, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(447, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(448, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(449, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(450, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(451, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(452, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(453, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(454, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(455, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(456, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(457, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(458, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(459, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(460, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(461, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(462, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(463, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(464, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(465, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(466, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(467, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(468, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(469, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(470, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(471, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(472, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(473, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(474, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(475, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(476, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(477, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(478, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(479, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(480, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(481, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(482, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(483, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(484, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(485, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(486, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(487, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(488, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(489, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(490, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(491, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-02 00:00:00'),
(492, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(493, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-02 00:00:00'),
(494, 'POST - HOURS - /new', '200 - New training hours record created: ID 12', NULL, 'success', '2024-12-02 00:00:00'),
(495, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(496, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-02 00:00:00'),
(497, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(498, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(499, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(500, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(501, 'POST - MURAL - new', '{\"id\":1,\"titulo\":\"Publicação de teste\",\"descricao\":\"textinho de descricao\",\"identificador\":\"44rwLMPBALo0KPjbqVET\",\"autor\":24,\"data\":\"2024-12-02T11:14:59.000Z\",\"curso_alvo\":1,\"visivel\":1}', NULL, 'success', '2024-12-02 00:00:00'),
(502, 'POST - MURAL - new', '{\"id\":2,\"titulo\":\"Testou\",\"descricao\":\"tá funcionando?\",\"identificador\":\"lRb08pqnZmpBezWsPjuc\",\"autor\":31,\"data\":\"2024-12-02T11:15:27.000Z\",\"curso_alvo\":1,\"visivel\":2}', NULL, 'success', '2024-12-02 00:00:00'),
(503, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 00:00:00'),
(504, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 16:50:30'),
(505, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 17:07:59'),
(506, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 17:08:03'),
(507, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 17:09:25'),
(508, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 17:09:32'),
(509, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 17:09:37'),
(510, 'GET - USERS - id/27', '200 - Found and Authorized', NULL, 'success', '2024-12-02 17:14:33'),
(511, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 17:53:45'),
(512, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-02 17:53:46'),
(513, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 17:53:46'),
(514, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 17:56:33'),
(515, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-02 17:56:33'),
(516, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 17:56:33'),
(517, 'GET - MURAL - id/3', '200 - Found and Authorized', NULL, 'success', '2024-12-02 17:59:29'),
(518, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 18:05:06'),
(519, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-02 18:05:07'),
(520, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 18:05:07'),
(521, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 18:05:11'),
(522, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-02 18:05:12'),
(523, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 18:05:12'),
(524, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 18:05:17'),
(525, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-02 18:05:17'),
(526, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 18:05:17'),
(527, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 18:05:23'),
(528, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-02 18:05:24'),
(529, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 18:05:24'),
(530, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 19:24:04'),
(531, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:15:34'),
(532, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:15:39'),
(533, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:15:41'),
(534, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:15:43'),
(535, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:15:45'),
(536, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:15:46'),
(537, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:15:48'),
(538, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:15:51'),
(539, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:15:57'),
(540, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:16:07'),
(541, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:16:09'),
(542, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:16:13'),
(543, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:16:14'),
(544, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:16:54'),
(545, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:16:56'),
(546, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:16:57'),
(547, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:16:58'),
(548, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:17:00'),
(549, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:17:00'),
(550, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:17:02'),
(551, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:17:06'),
(552, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:17:08'),
(553, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:17:09'),
(554, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:17:11'),
(555, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:17:15'),
(556, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:17:23'),
(557, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:09'),
(558, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:11'),
(559, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:12'),
(560, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:13'),
(561, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:15'),
(562, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:18'),
(563, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:20'),
(564, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:25'),
(565, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:28'),
(566, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:31'),
(567, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:35'),
(568, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:37'),
(569, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:38'),
(570, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:38'),
(571, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:40'),
(572, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:18:41'),
(573, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:19:21'),
(574, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:19:26'),
(575, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:19:28'),
(576, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:19:31'),
(577, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:21:00'),
(578, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:21:04'),
(579, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:21:05'),
(580, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:21:07'),
(581, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:37:28'),
(582, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:50:50'),
(583, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:50:53'),
(584, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:50:55'),
(585, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:51:03'),
(586, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:51:09'),
(587, 'POST - REQUEST TYPE - new', '{\"id\":2,\"nome\":\"processo 1\",\"fluxograma\":\"url\",\"hrs_resposta\":null,\"hrs_resolucao\":null}', NULL, 'success', '2024-12-02 21:51:38'),
(588, 'POST - REQUEST TYPE - new', '{\"id\":3,\"nome\":\"processo 2\",\"fluxograma\":\"url\",\"hrs_resposta\":null,\"hrs_resolucao\":null}', NULL, 'success', '2024-12-02 21:51:42'),
(589, 'POST - REQUEST TYPE - new', '{\"id\":4,\"nome\":\"processo 4\",\"fluxograma\":\"url\",\"hrs_resposta\":null,\"hrs_resolucao\":null}', NULL, 'success', '2024-12-02 21:51:48'),
(590, 'POST - REQUEST TYPE - new', '{\"id\":5,\"nome\":\"processo 5\",\"fluxograma\":\"url\",\"hrs_resposta\":null,\"hrs_resolucao\":null}', NULL, 'success', '2024-12-02 21:51:52'),
(591, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:53:27'),
(592, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:53:49'),
(593, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:53:57'),
(594, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-02 21:53:58'),
(595, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-02 21:53:58'),
(596, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-02 21:54:03'),
(597, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:05:01'),
(598, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:05:08'),
(599, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:06:14'),
(600, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:06:56'),
(601, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:28:21'),
(602, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:28:24'),
(603, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:32:15'),
(604, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:32:17'),
(605, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:32:18'),
(606, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:32:20'),
(607, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:32:20'),
(608, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:32:25'),
(609, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:32:26'),
(610, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:32:28'),
(611, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:32:33'),
(612, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:32:37'),
(613, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:32:39'),
(614, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:32:40'),
(615, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:43:54'),
(616, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:43:55'),
(617, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:43:57'),
(618, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:55:10'),
(619, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:55:11'),
(620, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:55:24'),
(621, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:55:26'),
(622, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:56:44'),
(623, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:57:07'),
(624, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:57:19'),
(625, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:57:28'),
(626, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:57:47'),
(627, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:57:54'),
(628, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:58:10'),
(629, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:58:18'),
(630, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:58:23'),
(631, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:58:25'),
(632, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:58:27'),
(633, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:58:28'),
(634, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:58:29'),
(635, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:58:31'),
(636, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:58:32'),
(637, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:59:39'),
(638, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:59:42'),
(639, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 22:59:48'),
(640, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:07:54'),
(641, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:10:01'),
(642, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:10:03'),
(643, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:10:06'),
(644, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:10:08'),
(645, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:10:09'),
(646, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:10:12'),
(647, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:10:14'),
(648, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:10:17'),
(649, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:10:20'),
(650, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:11:44'),
(651, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:11:46'),
(652, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:11:48'),
(653, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:11:49'),
(654, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:11:51'),
(655, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:12:03'),
(656, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:12:06'),
(657, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:14:46'),
(658, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:14:47'),
(659, 'PATCH - USERS - FOTO - 29', '200 - Foto atualizada com sucesso', NULL, 'success', '2024-12-02 23:14:56'),
(660, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:15:10'),
(661, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:15:12'),
(662, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:15:19'),
(663, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:15:38'),
(664, 'GET - SYSTEM - timelines-user/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:15:39'),
(665, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:15:42'),
(666, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:15:45'),
(667, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:15:56'),
(668, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:16:03'),
(669, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:16:06'),
(670, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:16:21'),
(671, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:16:24'),
(672, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:16:30'),
(673, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:17:00'),
(674, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:17:22'),
(675, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:17:23'),
(676, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:17:33'),
(677, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:17:34'),
(678, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:17:41'),
(679, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:17:44'),
(680, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:17:46'),
(681, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:17:48'),
(682, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:17:50'),
(683, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:17:52'),
(684, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:18:34'),
(685, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:18:49'),
(686, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:19:05'),
(687, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:19:13'),
(688, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:19:19'),
(689, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:19:23'),
(690, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:19:35'),
(691, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:19:48'),
(692, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:22:49'),
(693, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:22:58'),
(694, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:23:46'),
(695, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:27:16'),
(696, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:27:20'),
(697, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:57:59'),
(698, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-02 23:58:12'),
(699, 'POST - REQUESTS - new', '\nInvalid `prisma.etapas_processo.create()` invocation:\n\n\nForeign key constraint failed on the field: `tipo`', NULL, 'error', '2024-12-03 00:00:46'),
(700, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-03 00:05:40'),
(701, 'GET - PERCENTUAL-POR-TIPO - by-student/29', '404 - Nenhum registro encontrado', NULL, 'error', '2024-12-03 00:05:42'),
(702, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 00:05:43'),
(703, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 00:06:37'),
(704, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 00:06:47'),
(705, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:03:14'),
(706, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:03:21'),
(707, 'PATCH - USERS - FOTO - 24', '200 - Foto atualizada com sucesso', NULL, 'success', '2024-12-03 02:03:41'),
(708, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:03:56'),
(709, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:04:02'),
(710, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:04:09'),
(711, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:04:12'),
(712, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:04:15'),
(713, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:04:29'),
(714, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:06:26'),
(715, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:06:29'),
(716, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:06:40'),
(717, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:06:42'),
(718, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:06:44'),
(719, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:06:46'),
(720, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:06:48'),
(721, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:06:50'),
(722, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:06:53'),
(723, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:06:56'),
(724, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:06:58'),
(725, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:07:00'),
(726, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:08:40'),
(727, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:08:44'),
(728, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:08:47'),
(729, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:08:49'),
(730, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:09:04'),
(731, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:09:22'),
(732, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:09:24'),
(733, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:12:27'),
(734, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:12:30'),
(735, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:12:32'),
(736, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:12:36'),
(737, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:16:21'),
(738, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:16:43'),
(739, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:16:57'),
(740, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:17:09'),
(741, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:17:12'),
(742, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:17:15'),
(743, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:17:16'),
(744, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:17:38'),
(745, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:17:43'),
(746, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:18:45'),
(747, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:18:58'),
(748, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:19:12'),
(749, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:19:32'),
(750, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:19:38'),
(751, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:19:41'),
(752, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:19:49'),
(753, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:20:05'),
(754, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:21:05'),
(755, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:21:10'),
(756, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:21:23'),
(757, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:21:34'),
(758, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:24:24'),
(759, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:25:47'),
(760, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:25:53'),
(761, 'POST - REQUEST TYPE - new', '{\"id\":6,\"nome\":\"Quebra de requisito para TCC\",\"fluxograma\":\"testezin\",\"hrs_resposta\":20,\"hrs_resolucao\":60}', NULL, 'success', '2024-12-03 02:26:09'),
(762, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:26:19'),
(763, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:26:58'),
(764, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 02:51:53'),
(765, 'POST - FIELDS - new-type', '{\"id\":1,\"nome\":\"nome\",\"etiqueta\":\"Nome\",\"obrigatorio\":0,\"tipo_dado\":1,\"campo_padrao\":1}', NULL, 'success', '2024-12-03 03:21:10'),
(766, 'POST - FIELDS - new-type', '{\"id\":2,\"nome\":\"nome\",\"etiqueta\":\"Nome\",\"obrigatorio\":0,\"tipo_dado\":1,\"campo_padrao\":1}', NULL, 'success', '2024-12-03 03:21:39'),
(767, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 03:21:43'),
(768, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 03:23:08'),
(769, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 03:23:29'),
(770, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 03:24:54'),
(771, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 03:25:30'),
(772, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 03:25:57'),
(773, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 03:26:31'),
(774, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 03:27:47'),
(775, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 03:28:08'),
(776, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 03:28:41'),
(777, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 03:29:03'),
(778, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 03:29:15'),
(779, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 03:29:46'),
(780, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 03:30:37'),
(781, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 11:51:59'),
(782, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 11:52:47'),
(783, 'GET - REQUEST TYPE - id/10', '404 - Not Found', NULL, 'error', '2024-12-03 12:00:57'),
(784, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:01:18'),
(785, 'GET - REQUEST TYPE - id/10', '404 - Not Found', NULL, 'error', '2024-12-03 12:02:02'),
(786, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:02:23'),
(787, 'GET - REQUEST TYPE - id/11', '404 - Not Found', NULL, 'error', '2024-12-03 12:03:03'),
(788, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:03:23'),
(789, 'GET - REQUEST TYPE - id/11', '404 - Not Found', NULL, 'error', '2024-12-03 12:04:19'),
(790, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:04:40'),
(791, 'GET - REQUEST TYPE - id/11', '404 - Not Found', NULL, 'error', '2024-12-03 12:04:54'),
(792, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:05:16'),
(793, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:05:16'),
(794, 'GET - REQUEST TYPE - id/11', '404 - Not Found', NULL, 'error', '2024-12-03 12:06:46'),
(795, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:07:07'),
(796, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:07:32'),
(797, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:07:33'),
(798, 'GET - REQUEST TYPE - id/7', '404 - Not Found', NULL, 'error', '2024-12-03 12:09:11'),
(799, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:09:31'),
(800, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:09:49'),
(801, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:09:49'),
(802, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:10:24'),
(803, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:10:25'),
(804, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:11:53'),
(805, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:11:53'),
(806, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:13:05'),
(807, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:13:06'),
(808, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:13:38'),
(809, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:13:39'),
(810, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:14:45'),
(811, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:14:46'),
(812, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:14:58'),
(813, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:14:59'),
(814, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:16:41'),
(815, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:16:42'),
(816, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:17:09'),
(817, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:17:10'),
(818, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:17:26'),
(819, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:17:29'),
(820, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:17:40'),
(821, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:17:43'),
(822, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:17:46'),
(823, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:18:01'),
(824, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:18:05'),
(825, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:18:07'),
(826, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:18:14'),
(827, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:18:25'),
(828, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:18:26'),
(829, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:18:57'),
(830, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:19:03'),
(831, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:19:05'),
(832, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-03 12:19:06'),
(833, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:19:21'),
(834, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:19:22'),
(835, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:19:59'),
(836, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:20:00'),
(837, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:20:20'),
(838, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:20:21'),
(839, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:24:11'),
(840, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:24:12'),
(841, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:24:58'),
(842, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:24:59'),
(843, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:25:34'),
(844, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:25:34'),
(845, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:25:52'),
(846, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:25:53'),
(847, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:26:13'),
(848, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:26:14'),
(849, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:26:25'),
(850, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:26:26'),
(851, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:26:50'),
(852, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:26:51'),
(853, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:27:19'),
(854, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:27:20'),
(855, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:30:53'),
(856, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:30:54'),
(857, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:33:00'),
(858, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:33:01'),
(859, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:33:31'),
(860, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:33:32'),
(861, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:33:54'),
(862, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:33:55'),
(863, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:34:34'),
(864, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:34:35'),
(865, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:35:37'),
(866, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:35:38'),
(867, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:43:26'),
(868, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:43:27'),
(869, 'GET - REQUEST TYPE - id/NaN', 'Error fetching requested Field type. {\"name\":\"PrismaClientValidationError\",\"clientVersion\":\"5.5.2\"} ', NULL, 'error', '2024-12-03 12:43:31'),
(870, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:43:52'),
(871, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:44:31'),
(872, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:44:32'),
(873, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:44:34'),
(874, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:46:51'),
(875, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:46:52'),
(876, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:46:54'),
(877, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:47:17'),
(878, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:47:18'),
(879, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:47:19'),
(880, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:47:39'),
(881, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:47:40'),
(882, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:47:42'),
(883, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:48:01'),
(884, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:48:02'),
(885, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:48:04'),
(886, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:48:14'),
(887, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:48:15'),
(888, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:48:18'),
(889, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:48:27'),
(890, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:48:28'),
(891, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:48:30'),
(892, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:48:53'),
(893, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:48:54'),
(894, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:48:56'),
(895, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:49:11'),
(896, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:49:12'),
(897, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:49:13'),
(898, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:49:34'),
(899, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:49:35'),
(900, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:49:37'),
(901, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:49:46'),
(902, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:49:47'),
(903, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:49:48'),
(904, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:50:12'),
(905, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:50:13'),
(906, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:50:14');
INSERT INTO `logs` (`id`, `funcao`, `mensagem`, `usuario`, `status`, `data`) VALUES
(907, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:50:47'),
(908, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:50:48'),
(909, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:50:50'),
(910, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:51:07'),
(911, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:51:08'),
(912, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:51:10'),
(913, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:51:26'),
(914, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:51:27'),
(915, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:51:29'),
(916, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:51:48'),
(917, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:51:52'),
(918, 'POST - FIELDS - new-type', '{\"id\":3,\"nome\":\"sobrenome\",\"etiqueta\":\"Sobrenome\",\"obrigatorio\":0,\"tipo_dado\":1,\"campo_padrao\":1}', NULL, 'success', '2024-12-03 12:52:26'),
(919, 'POST - FIELDS - new-type', '{\"id\":4,\"nome\":\"sobrenome\",\"etiqueta\":\"Sobrenome\",\"obrigatorio\":0,\"tipo_dado\":1,\"campo_padrao\":1}', NULL, 'success', '2024-12-03 12:52:46'),
(920, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:52:47'),
(921, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:52:48'),
(922, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:52:49'),
(923, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:52:50'),
(924, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:53:22'),
(925, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:53:23'),
(926, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:53:24'),
(927, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:53:49'),
(928, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:53:50'),
(929, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:53:51'),
(930, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:54:49'),
(931, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:54:50'),
(932, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-03 12:54:52'),
(933, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 13:59:16'),
(934, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 13:59:20'),
(935, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 13:59:25'),
(936, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 13:59:40'),
(937, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 14:02:00'),
(938, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 14:02:23'),
(939, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 14:02:28'),
(940, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 14:46:51'),
(941, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 14:49:28'),
(942, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-03 14:49:30'),
(943, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 14:49:38'),
(944, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 16:28:55'),
(945, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-03 16:29:06'),
(946, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-04 00:16:40'),
(947, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-04 00:16:46'),
(948, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-04 18:38:55'),
(949, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-04 18:39:26'),
(950, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-04 18:39:43'),
(951, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 00:14:31'),
(952, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 00:14:36'),
(953, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 00:14:41'),
(954, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 00:16:04'),
(955, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 00:16:15'),
(956, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 00:16:17'),
(957, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 07:32:22'),
(958, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 07:32:39'),
(959, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-05 07:33:30'),
(960, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-05 07:33:36'),
(961, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-05 07:33:40'),
(962, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-05 07:33:43'),
(963, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-05 07:39:23'),
(964, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 07:39:37'),
(965, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-05 07:39:44'),
(966, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-05 07:39:46'),
(967, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-05 07:39:55'),
(968, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-05 07:39:55'),
(969, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 07:41:15'),
(970, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 07:42:17'),
(971, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-05 08:07:54'),
(972, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:34:23'),
(973, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 21:35:10'),
(974, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 21:35:31'),
(975, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:35:48'),
(976, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:35:55'),
(977, 'GET - REQUEST TYPE - id/3', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:35:56'),
(978, 'GET - FIELDS - request-field-by-process-type/3', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:35:57'),
(979, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:35:58'),
(980, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:35:58'),
(981, 'GET - STEPS - link-step-to-proccess/3', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:35:59'),
(982, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:36:00'),
(983, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:36:01'),
(984, 'POST - REQUESTS - new', '\nInvalid `prisma.processo.create()` invocation:\n\n\nForeign key constraint failed on the field: `etapa_atual`', NULL, 'error', '2024-12-05 21:36:35'),
(985, 'POST - REQUESTS - new', '\nInvalid `prisma.processo.create()` invocation:\n\n\nForeign key constraint failed on the field: `etapa_atual`', NULL, 'error', '2024-12-05 21:36:48'),
(986, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:37:45'),
(987, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 21:37:46'),
(988, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 21:37:51'),
(989, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 21:37:58'),
(990, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 21:38:35'),
(991, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:38:39'),
(992, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:38:39'),
(993, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:38:40'),
(994, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:38:46'),
(995, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:38:46'),
(996, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:38:47'),
(997, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 21:39:08'),
(998, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:48:31'),
(999, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:48:31'),
(1000, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-05 21:48:32'),
(1001, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:02:44'),
(1002, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:02:45'),
(1003, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:02:45'),
(1004, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 22:02:51'),
(1005, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 22:03:04'),
(1006, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 22:03:09'),
(1007, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 22:03:16'),
(1008, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:03:28'),
(1009, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:03:34'),
(1010, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:13:32'),
(1011, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:13:32'),
(1012, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:13:33'),
(1013, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:13:37'),
(1014, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:13:38'),
(1015, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:13:38'),
(1016, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:18:55'),
(1017, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:19:01'),
(1018, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:19:34'),
(1019, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:19:37'),
(1020, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 22:21:28'),
(1021, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:21:33'),
(1022, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-05 22:21:34'),
(1023, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:55:44'),
(1024, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:55:46'),
(1025, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:55:55'),
(1026, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:56:03'),
(1027, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:56:08'),
(1028, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:56:10'),
(1029, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:56:20'),
(1030, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:56:23'),
(1031, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:56:27'),
(1032, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:56:33'),
(1033, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-05 22:56:41'),
(1034, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:16'),
(1035, 'GET - REQUEST TYPE - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:22'),
(1036, 'GET - FIELDS - request-field-by-process-type/1', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:23'),
(1037, 'GET - STEPS - link-step-to-proccess/1', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:23'),
(1038, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:24'),
(1039, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:25'),
(1040, 'GET - REQUEST TYPE - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:28'),
(1041, 'GET - FIELDS - request-field-by-process-type/1', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:28'),
(1042, 'GET - STEPS - link-step-to-proccess/1', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:29'),
(1043, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:29'),
(1044, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:30'),
(1045, 'GET - REQUEST TYPE - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:33'),
(1046, 'GET - FIELDS - request-field-by-process-type/1', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:33'),
(1047, 'GET - STEPS - link-step-to-proccess/1', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:34'),
(1048, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:34'),
(1049, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:35'),
(1050, 'GET - REQUEST TYPE - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:37'),
(1051, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:39'),
(1052, 'GET - REQUEST TYPE - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:40'),
(1053, 'GET - FIELDS - request-field-by-process-type/1', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:40'),
(1054, 'GET - STEPS - link-step-to-proccess/1', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:40'),
(1055, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:41'),
(1056, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:42'),
(1057, 'GET - REQUEST TYPE - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:45'),
(1058, 'GET - FIELDS - request-field-by-process-type/2', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:45'),
(1059, 'GET - STEPS - link-step-to-proccess/2', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:46'),
(1060, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:46'),
(1061, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:48'),
(1062, 'GET - REQUEST TYPE - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:50'),
(1063, 'GET - FIELDS - request-field-by-process-type/2', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:50'),
(1064, 'GET - STEPS - link-step-to-proccess/2', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:50'),
(1065, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:51'),
(1066, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:00:52'),
(1067, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:00'),
(1068, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:16'),
(1069, 'GET - REQUEST TYPE - id/5', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:22'),
(1070, 'GET - FIELDS - request-field-by-process-type/5', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:23'),
(1071, 'GET - STEPS - link-step-to-proccess/5', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:23'),
(1072, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:24'),
(1073, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:25'),
(1074, 'GET - REQUEST TYPE - id/5', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:44'),
(1075, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:45'),
(1076, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:46'),
(1077, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:47'),
(1078, 'GET - STEPS - link-step-to-proccess/5', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:48'),
(1079, 'GET - REQUEST TYPE - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:55'),
(1080, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:56'),
(1081, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:57'),
(1082, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:01:58'),
(1083, 'GET - STEPS - link-step-to-proccess/2', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:02:00'),
(1084, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 23:09:34'),
(1085, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 23:09:43'),
(1086, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:10:01'),
(1087, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 23:10:33'),
(1088, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 23:10:50'),
(1089, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 23:10:56'),
(1090, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:10:58'),
(1091, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:29:37'),
(1092, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:29:42'),
(1093, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:29:47'),
(1094, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 23:36:13'),
(1095, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:36:33'),
(1096, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-05 23:37:28'),
(1097, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:37:37'),
(1098, 'GET - USERS - id/28', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:43:42'),
(1099, 'GET - USERS - id/28', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:43:53'),
(1100, 'GET - USERS - id/28', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:44:48'),
(1101, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:50:15'),
(1102, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-05 23:50:16'),
(1103, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-05 23:57:13'),
(1104, 'GET - HOURS - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 00:13:09'),
(1105, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 00:14:01'),
(1106, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 00:14:07'),
(1107, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 00:14:09'),
(1108, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 00:15:05'),
(1109, 'GET - Course - all-courses', '200 - Found and Authorized', NULL, 'success', '2024-12-06 00:16:46'),
(1110, 'GET - Course - all-courses', '200 - Found and Authorized', NULL, 'success', '2024-12-06 00:37:12'),
(1111, 'GET - MURAL - id/3', '200 - Found and Authorized', NULL, 'success', '2024-12-06 00:49:28'),
(1112, 'GET - MURAL - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 00:49:36'),
(1113, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 00:53:34'),
(1114, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-06 00:53:38'),
(1115, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 00:53:47'),
(1116, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 00:53:49'),
(1117, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 00:53:58'),
(1118, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 00:53:59'),
(1119, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:03:34'),
(1120, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:04:04'),
(1121, 'GET - MURAL - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:07:55'),
(1122, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:08:05'),
(1123, 'GET - MURAL - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:08:07'),
(1124, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:08:09'),
(1125, 'GET - MURAL - id/3', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:08:11'),
(1126, 'GET - HOURS - by-student/29', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:09:39'),
(1127, 'GET - PERCENTUAL-POR-TIPO - by-student/29', '404 - Nenhum registro encontrado', NULL, 'error', '2024-12-06 01:09:40'),
(1128, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:09:58'),
(1129, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:12:36'),
(1130, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:12:42'),
(1131, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:14:01'),
(1132, 'GET - MURAL - id/3', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:18:58'),
(1133, 'GET - MURAL - id/3', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:18:59'),
(1134, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:19:00'),
(1135, 'GET - COURSES - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:19:00'),
(1136, 'GET - MURAL - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:19:09'),
(1137, 'GET - MURAL - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:19:09'),
(1138, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:19:09'),
(1139, 'GET - COURSES - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:19:10'),
(1140, 'GET - MURAL - id/3', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:19:21'),
(1141, 'GET - MURAL - id/3', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:19:21'),
(1142, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:19:22'),
(1143, 'GET - COURSES - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:19:22'),
(1144, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:20:39'),
(1145, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:20:42'),
(1146, 'GET - Course - all-courses', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:20:46'),
(1147, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:25:36'),
(1148, 'GET - Course - all-courses', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:26:53'),
(1149, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:27:09'),
(1150, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:31:24'),
(1151, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:31:27'),
(1152, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:35:24'),
(1153, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:35:27'),
(1154, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:35:30'),
(1155, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:35:36'),
(1156, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:35:38'),
(1157, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:36:10'),
(1158, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:36:15'),
(1159, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 01:36:40'),
(1160, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:06:21'),
(1161, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:06:35'),
(1162, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:07:53'),
(1163, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:08:24'),
(1164, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:13:07'),
(1165, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:13:14'),
(1166, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:13:31'),
(1167, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:13:35'),
(1168, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:13:43'),
(1169, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:13:46'),
(1170, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:13:48'),
(1171, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:13:51'),
(1172, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:13:53'),
(1173, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:13:56'),
(1174, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:17:56'),
(1175, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:18:25'),
(1176, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:18:28'),
(1177, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:18:29'),
(1178, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:18:29'),
(1179, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:18:34'),
(1180, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:18:35'),
(1181, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:18:35'),
(1182, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:18:38'),
(1183, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 02:18:59'),
(1184, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-06 02:19:04'),
(1185, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 07:39:17'),
(1186, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 07:39:29'),
(1187, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 07:39:36'),
(1188, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 07:43:38'),
(1189, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:43:44'),
(1190, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 07:43:46'),
(1191, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:43:55'),
(1192, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:04'),
(1193, 'GET - REQUEST TYPE - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:08'),
(1194, 'GET - FIELDS - request-field-by-process-type/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:08'),
(1195, 'GET - STEPS - link-step-to-proccess/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:09'),
(1196, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:10'),
(1197, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:11'),
(1198, 'GET - REQUEST TYPE - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:20'),
(1199, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:22'),
(1200, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:23'),
(1201, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:24'),
(1202, 'GET - STEPS - link-step-to-proccess/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:26'),
(1203, 'GET - REQUEST TYPE - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:31'),
(1204, 'GET - FIELDS - request-field-by-process-type/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:31'),
(1205, 'GET - STEPS - link-step-to-proccess/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:32'),
(1206, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:32'),
(1207, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:33'),
(1208, 'GET - REQUEST TYPE - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:40'),
(1209, 'GET - FIELDS - request-field-by-process-type/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:41'),
(1210, 'GET - STEPS - link-step-to-proccess/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:41'),
(1211, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:41'),
(1212, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:43'),
(1213, 'GET - REQUEST TYPE - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:44'),
(1214, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:46'),
(1215, 'GET - REQUEST TYPE - id/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:46'),
(1216, 'GET - FIELDS - request-field-by-process-type/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:47'),
(1217, 'GET - STEPS - link-step-to-proccess/2', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:47'),
(1218, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:48'),
(1219, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:49'),
(1220, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:50'),
(1221, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:51'),
(1222, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:51'),
(1223, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:44:56'),
(1224, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:45:23'),
(1225, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:45:41'),
(1226, 'GET - REQUESTS - process-identificador/6', '404 - Not Found', NULL, 'error', '2024-12-06 07:59:13'),
(1227, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:59:17'),
(1228, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:59:17'),
(1229, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:59:19'),
(1230, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:59:20'),
(1231, 'GET - REQUESTS - all-responses-process/6', '404 - Not Found', NULL, 'error', '2024-12-06 07:59:22'),
(1232, 'GET - REQUESTS - process-identificador/6', '404 - Not Found', NULL, 'error', '2024-12-06 07:59:25'),
(1233, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:59:28'),
(1234, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:59:28'),
(1235, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:59:29'),
(1236, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 07:59:30'),
(1237, 'GET - REQUESTS - all-responses-process/6', '404 - Not Found', NULL, 'error', '2024-12-06 07:59:32'),
(1238, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:00:10'),
(1239, 'GET - USERS - id/29', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:00:21'),
(1240, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:05:56'),
(1241, 'GET - REQUESTS - process-identificador/6', '404 - Not Found', NULL, 'error', '2024-12-06 08:06:45'),
(1242, 'GET - REQUESTS - /all-requests-as-teacher', '404 - Not Found', NULL, 'error', '2024-12-06 08:07:04'),
(1243, 'POST - REQUESTS - new', 'Aluno com id 1 não encontrado', NULL, 'error', '2024-12-06 08:10:03'),
(1244, 'POST - REQUESTS - new', '\nInvalid `prisma.processo.create()` invocation:\n\n\nForeign key constraint failed on the field: `etapa_atual`', NULL, 'error', '2024-12-06 08:10:16'),
(1245, 'POST - REQUESTS - new', '\nInvalid `prisma.processo.create()` invocation:\n\n\nForeign key constraint failed on the field: `etapa_atual`', NULL, 'error', '2024-12-06 08:10:56'),
(1246, 'POST - REQUESTS - new', '\nInvalid `prisma.processo.create()` invocation:\n\n\nForeign key constraint failed on the field: `etapa_atual`', NULL, 'error', '2024-12-06 08:11:38'),
(1247, 'POST - REQUESTS - new', '\nInvalid `prisma.processo.create()` invocation:\n\n\nForeign key constraint failed on the field: `etapa_atual`', NULL, 'error', '2024-12-06 08:11:43'),
(1248, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:12:01'),
(1249, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:12:37'),
(1250, 'GET - REQUESTS - process-identificador/1', '404 - Not Found', NULL, 'error', '2024-12-06 08:13:07'),
(1251, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:13:11'),
(1252, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:13:12'),
(1253, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:13:14'),
(1254, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:13:15'),
(1255, 'GET - REQUESTS - all-responses-process/1', '404 - Not Found', NULL, 'error', '2024-12-06 08:13:17'),
(1256, 'GET - REQUESTS - process-identificador/1', '404 - Not Found', NULL, 'error', '2024-12-06 08:20:29'),
(1257, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:20:32'),
(1258, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:20:32'),
(1259, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:20:33'),
(1260, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:20:34'),
(1261, 'GET - REQUESTS - all-responses-process/1', '404 - Not Found', NULL, 'error', '2024-12-06 08:20:35'),
(1262, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:20:39'),
(1263, 'GET - REQUESTS - process-identificador/4', '404 - Not Found', NULL, 'error', '2024-12-06 08:20:50'),
(1264, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:20:52'),
(1265, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:20:53'),
(1266, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:20:54'),
(1267, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:20:55'),
(1268, 'GET - REQUESTS - all-responses-process/4', '404 - Not Found', NULL, 'error', '2024-12-06 08:20:56'),
(1269, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:20:59'),
(1270, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 08:41:57'),
(1271, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 09:30:01'),
(1272, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:09:22'),
(1273, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:09:29'),
(1274, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:41:27'),
(1275, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":33,\"email\":\"teste@testou.com\",\"nome\":\"Matheus\",\"sobrenome\":\"teste\",\"nascimento\":\"1991-11-11T00:00:00.000Z\",\"registro\":\"grr2019000\",\"funcao\":1,\"status_usuario\":1}}', 33, 'success', '2024-12-06 10:43:29'),
(1276, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste@testou.com | registro: GRR2019000', NULL, 'error', '2024-12-06 10:43:36'),
(1277, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-06 10:43:54'),
(1278, 'sendEmail', 'Enviando email para teste@testou.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info', '2024-12-06 10:43:54'),
(1279, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success', '2024-12-06 10:43:58'),
(1280, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 10:48:10'),
(1281, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:48:15'),
(1282, 'USERS/PATCH - change-password', '400 - Erro - Senha atual inválida. ID: 31', NULL, 'error', '2024-12-06 10:48:38'),
(1283, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 10:49:57'),
(1284, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:13'),
(1285, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:18'),
(1286, 'GET - REQUEST TYPE - id/3', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:19'),
(1287, 'GET - FIELDS - request-field-by-process-type/3', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:20'),
(1288, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:20'),
(1289, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:21'),
(1290, 'GET - STEPS - link-step-to-proccess/3', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:22'),
(1291, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:22'),
(1292, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:23'),
(1293, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:40'),
(1294, 'GET - REQUEST TYPE - id/3', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:41'),
(1295, 'GET - FIELDS - request-field-by-process-type/3', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:41'),
(1296, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:41'),
(1297, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:41'),
(1298, 'GET - STEPS - link-step-to-proccess/3', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:42'),
(1299, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:42'),
(1300, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:43'),
(1301, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 10:50:50'),
(1302, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:54'),
(1303, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:57'),
(1304, 'GET - REQUEST TYPE - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:58'),
(1305, 'GET - FIELDS - request-field-by-process-type/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:58'),
(1306, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:59'),
(1307, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:50:59'),
(1308, 'GET - STEPS - link-step-to-proccess/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:51:00'),
(1309, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:51:00'),
(1310, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:51:01'),
(1311, 'POST - REQUESTS - new', '\nInvalid `prisma.processo.create()` invocation:\n\n\nForeign key constraint failed on the field: `etapa_atual`', NULL, 'error', '2024-12-06 10:51:12'),
(1312, 'POST - REQUESTS - new', '\nInvalid `prisma.processo.create()` invocation:\n\n\nForeign key constraint failed on the field: `etapa_atual`', NULL, 'error', '2024-12-06 10:51:22'),
(1313, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 10:52:13'),
(1314, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 10:52:19'),
(1315, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:53:57'),
(1316, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:54:08'),
(1317, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 10:54:09'),
(1318, 'POST - HOURS - /new', '200 - New training hours record created: ID 13', NULL, 'success', '2024-12-06 10:55:27'),
(1319, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:55:27'),
(1320, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 10:55:28'),
(1321, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:58:48'),
(1322, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:59:41'),
(1323, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:59:45'),
(1324, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:59:47'),
(1325, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:59:51'),
(1326, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:59:53'),
(1327, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:59:55'),
(1328, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:59:58'),
(1329, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 10:59:59'),
(1330, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:01'),
(1331, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:02'),
(1332, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:04'),
(1333, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:20'),
(1334, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:21'),
(1335, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:21'),
(1336, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:22'),
(1337, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:22'),
(1338, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:27'),
(1339, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:28'),
(1340, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:29'),
(1341, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:30'),
(1342, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:31'),
(1343, 'POST - STEPS - /link-step-to-proccess', '{\"id\":2,\"tipo\":1,\"obrigatorio\":0,\"proccessTypeId\":6,\"ordem\":null}', NULL, 'success', '2024-12-06 11:00:36'),
(1344, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:36'),
(1345, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:37'),
(1346, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:38'),
(1347, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:40'),
(1348, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:40'),
(1349, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:41'),
(1350, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:41'),
(1351, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:42'),
(1352, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:43'),
(1353, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:00:44'),
(1354, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:43:11'),
(1355, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:43:17'),
(1356, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:43:27'),
(1357, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:43:31'),
(1358, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":34,\"email\":\"aluno@lucas.com\",\"nome\":\"Lucas\",\"sobrenome\":\"Perussi de Oliveira\",\"nascimento\":\"1999-07-28T00:00:00.000Z\",\"registro\":\"grr22222\",\"funcao\":1,\"status_usuario\":1}}', 34, 'success', '2024-12-06 11:44:28'),
(1359, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 11:46:30'),
(1360, 'GET - USERS - id/34', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:47:21');
INSERT INTO `logs` (`id`, `funcao`, `mensagem`, `usuario`, `status`, `data`) VALUES
(1361, 'PATCH - USERS - FOTO - 34', '200 - Foto atualizada com sucesso', NULL, 'success', '2024-12-06 11:47:26'),
(1362, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 11:47:28'),
(1363, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 11:48:50'),
(1364, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 11:50:02'),
(1365, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 11:50:30'),
(1366, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:50:42'),
(1367, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 11:50:44'),
(1368, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:50:50'),
(1369, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 11:50:53'),
(1370, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:50:57'),
(1371, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 11:51:10'),
(1372, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:51:19'),
(1373, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:51:35'),
(1374, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:51:39'),
(1375, 'POST - REQUEST TYPE - new', '{\"id\":7,\"nome\":\"Alteração Cadastral\",\"fluxograma\":\"ertgttghfdh\",\"hrs_resposta\":24,\"hrs_resolucao\":24}', NULL, 'success', '2024-12-06 11:52:13'),
(1376, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:52:14'),
(1377, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:52:15'),
(1378, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:52:16'),
(1379, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:52:17'),
(1380, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:52:25'),
(1381, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:52:25'),
(1382, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:52:26'),
(1383, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:52:27'),
(1384, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:52:28'),
(1385, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:52:34'),
(1386, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:52:37'),
(1387, 'POST - FIELDS - new-type', '{\"id\":5,\"nome\":\"nome\",\"etiqueta\":\"Nome\",\"obrigatorio\":0,\"tipo_dado\":1,\"campo_padrao\":1}', NULL, 'success', '2024-12-06 11:52:49'),
(1388, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:52:50'),
(1389, 'POST - FIELDS - new-type', '{\"id\":6,\"nome\":\"sobrenome\",\"etiqueta\":\"Sobrenome\",\"obrigatorio\":0,\"tipo_dado\":1,\"campo_padrao\":1}', NULL, 'success', '2024-12-06 11:54:26'),
(1390, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:54:27'),
(1391, 'POST - FIELDS - new-type', '{\"id\":7,\"nome\":\"nome\",\"etiqueta\":\"Nome\",\"obrigatorio\":0,\"tipo_dado\":1,\"campo_padrao\":1}', NULL, 'success', '2024-12-06 11:54:49'),
(1392, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:54:49'),
(1393, 'POST - FIELDS - new-type', '{\"id\":8,\"nome\":\"sobrenome\",\"etiqueta\":\"Sobrenome\",\"obrigatorio\":0,\"tipo_dado\":1,\"campo_padrao\":1}', NULL, 'success', '2024-12-06 11:54:57'),
(1394, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:54:58'),
(1395, 'POST - FIELDS - new-type', '{\"id\":9,\"nome\":\"email\",\"etiqueta\":\"Email\",\"obrigatorio\":0,\"tipo_dado\":4,\"campo_padrao\":1}', NULL, 'success', '2024-12-06 11:55:08'),
(1396, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:55:09'),
(1397, 'POST - FIELDS - new-type', '{\"id\":10,\"nome\":\"telefone\",\"etiqueta\":\"Telefone\",\"obrigatorio\":0,\"tipo_dado\":5,\"campo_padrao\":1}', NULL, 'success', '2024-12-06 11:55:31'),
(1398, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:55:32'),
(1399, 'POST - FIELDS - new-type', '{\"id\":11,\"nome\":\"descricao\",\"etiqueta\":\"Descrição\",\"obrigatorio\":0,\"tipo_dado\":6,\"campo_padrao\":1}', NULL, 'success', '2024-12-06 11:55:54'),
(1400, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:55:55'),
(1401, 'POST - FIELDS - new-type', '{\"id\":12,\"nome\":\"data\",\"etiqueta\":\"Data\",\"obrigatorio\":0,\"tipo_dado\":3,\"campo_padrao\":1}', NULL, 'success', '2024-12-06 11:56:11'),
(1402, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:56:12'),
(1403, 'POST - FIELDS - new-type', '{\"id\":13,\"nome\":\"horas\",\"etiqueta\":\"Carga Horária\",\"obrigatorio\":0,\"tipo_dado\":2,\"campo_padrao\":1}', NULL, 'success', '2024-12-06 11:56:31'),
(1404, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:56:32'),
(1405, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:57:59'),
(1406, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:02'),
(1407, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:12'),
(1408, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:15'),
(1409, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:19'),
(1410, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:20'),
(1411, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:20'),
(1412, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:21'),
(1413, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:22'),
(1414, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:29'),
(1415, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:30'),
(1416, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:31'),
(1417, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:32'),
(1418, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:42'),
(1419, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:43'),
(1420, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:44'),
(1421, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:58:45'),
(1422, 'POST - FIELDS - new-type-for-process', '{\"id\":14,\"nome\":\"info\",\"etiqueta\":\"Dado a ser alterado\",\"obrigatorio\":0,\"tipo_dado\":1,\"campo_padrao\":0}', NULL, 'success', '2024-12-06 11:59:09'),
(1423, 'POST - FIELDS - new-type-for-process', '{\"id\":1,\"tipo\":14,\"nome\":\"info\",\"nome_exibicao\":\"Dado a ser alterado\",\"tipo_processo\":7}', NULL, 'success', '2024-12-06 11:59:09'),
(1424, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:59:09'),
(1425, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:59:10'),
(1426, 'POST - FIELDS - new-type-for-process', '{\"id\":15,\"nome\":\"novo\",\"etiqueta\":\"Informação atualizada\",\"obrigatorio\":0,\"tipo_dado\":1,\"campo_padrao\":0}', NULL, 'success', '2024-12-06 11:59:26'),
(1427, 'POST - FIELDS - new-type-for-process', '{\"id\":2,\"tipo\":15,\"nome\":\"novo\",\"nome_exibicao\":\"Informação atualizada\",\"tipo_processo\":7}', NULL, 'success', '2024-12-06 11:59:26'),
(1428, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:59:26'),
(1429, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:59:27'),
(1430, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:59:39'),
(1431, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:59:40'),
(1432, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:59:54'),
(1433, 'POST - FIELDS - new-request-field', '{\"id\":3,\"tipo\":7,\"nome\":\"nome\",\"nome_exibicao\":\"Nome\",\"tipo_processo\":7}', NULL, 'success', '2024-12-06 11:59:58'),
(1434, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:59:59'),
(1435, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 11:59:59'),
(1436, 'POST - FIELDS - remove-link-field-to-request', '{\"count\":1}', NULL, 'success', '2024-12-06 12:00:01'),
(1437, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:02'),
(1438, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:02'),
(1439, 'POST - FIELDS - new-request-field', '{\"id\":4,\"tipo\":7,\"nome\":\"nome\",\"nome_exibicao\":\"Nome\",\"tipo_processo\":7}', NULL, 'success', '2024-12-06 12:00:05'),
(1440, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:06'),
(1441, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:06'),
(1442, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:26'),
(1443, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:27'),
(1444, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:27'),
(1445, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:28'),
(1446, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:29'),
(1447, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:40'),
(1448, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:41'),
(1449, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:43'),
(1450, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:44'),
(1451, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:45'),
(1452, 'POST - STEPS - /link-step-to-proccess', '{\"id\":3,\"tipo\":1,\"obrigatorio\":0,\"proccessTypeId\":7,\"ordem\":null}', NULL, 'success', '2024-12-06 12:00:48'),
(1453, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:48'),
(1454, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:49'),
(1455, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:00:51'),
(1456, 'POST - STEPS - /link-step-to-proccess', '{\"id\":4,\"tipo\":2,\"obrigatorio\":0,\"proccessTypeId\":7,\"ordem\":null}', NULL, 'success', '2024-12-06 12:01:02'),
(1457, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:03'),
(1458, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:04'),
(1459, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:05'),
(1460, 'POST - STEPS - /link-step-to-proccess', '{\"id\":5,\"tipo\":7,\"obrigatorio\":0,\"proccessTypeId\":7,\"ordem\":null}', NULL, 'success', '2024-12-06 12:01:06'),
(1461, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:06'),
(1462, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:07'),
(1463, 'POST - STEPS - /link-step-to-proccess', '{\"id\":6,\"tipo\":8,\"obrigatorio\":0,\"proccessTypeId\":7,\"ordem\":null}', NULL, 'success', '2024-12-06 12:01:09'),
(1464, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:10'),
(1465, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:10'),
(1466, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:11'),
(1467, 'POST - STEPS - /link-step-to-proccess', '{\"id\":7,\"tipo\":9,\"obrigatorio\":0,\"proccessTypeId\":7,\"ordem\":null}', NULL, 'success', '2024-12-06 12:01:13'),
(1468, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:14'),
(1469, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:14'),
(1470, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:15'),
(1471, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:18'),
(1472, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:19'),
(1473, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:19'),
(1474, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:20'),
(1475, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:21'),
(1476, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:22'),
(1477, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:28'),
(1478, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:31'),
(1479, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:35'),
(1480, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:41'),
(1481, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:42'),
(1482, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:42'),
(1483, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:43'),
(1484, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:44'),
(1485, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:48'),
(1486, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:49'),
(1487, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:51'),
(1488, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:01:51'),
(1489, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:11'),
(1490, 'POST - FIELDS - new-request-field', '{\"id\":5,\"tipo\":7,\"nome\":\"nome\",\"nome_exibicao\":\"Nome\",\"tipo_processo\":6}', NULL, 'success', '2024-12-06 12:02:13'),
(1491, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:13'),
(1492, 'POST - FIELDS - new-request-field', '{\"id\":6,\"tipo\":8,\"nome\":\"sobrenome\",\"nome_exibicao\":\"Sobrenome\",\"tipo_processo\":6}', NULL, 'success', '2024-12-06 12:02:14'),
(1493, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:15'),
(1494, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:15'),
(1495, 'POST - FIELDS - new-request-field', '{\"id\":7,\"tipo\":9,\"nome\":\"email\",\"nome_exibicao\":\"Email\",\"tipo_processo\":6}', NULL, 'success', '2024-12-06 12:02:16'),
(1496, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:16'),
(1497, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:17'),
(1498, 'POST - FIELDS - new-request-field', '{\"id\":8,\"tipo\":12,\"nome\":\"data\",\"nome_exibicao\":\"Data\",\"tipo_processo\":6}', NULL, 'success', '2024-12-06 12:02:17'),
(1499, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:18'),
(1500, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:18'),
(1501, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:19'),
(1502, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:20'),
(1503, 'GET - HOURS - by-student/28', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:23'),
(1504, 'GET - PERCENTUAL-POR-TIPO - by-student/28', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 12:02:24'),
(1505, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:33'),
(1506, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:36'),
(1507, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:37'),
(1508, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:37'),
(1509, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:38'),
(1510, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:02:38'),
(1511, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 12:03:42'),
(1512, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:04:27'),
(1513, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:04:28'),
(1514, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:04:30'),
(1515, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:04:31'),
(1516, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:04:33'),
(1517, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:04:38'),
(1518, 'POST - STEPS - /link-step-to-proccess', '{\"id\":8,\"tipo\":1,\"obrigatorio\":0,\"proccessTypeId\":6,\"ordem\":null}', NULL, 'success', '2024-12-06 12:04:47'),
(1519, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:04:48'),
(1520, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:04:48'),
(1521, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:04:50'),
(1522, 'POST - STEPS - /link-step-to-proccess', '{\"id\":9,\"tipo\":2,\"obrigatorio\":0,\"proccessTypeId\":6,\"ordem\":null}', NULL, 'success', '2024-12-06 12:04:53'),
(1523, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:04:53'),
(1524, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:04:54'),
(1525, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:04:56'),
(1526, 'POST - STEPS - /link-step-to-proccess', '{\"id\":10,\"tipo\":7,\"obrigatorio\":0,\"proccessTypeId\":6,\"ordem\":null}', NULL, 'success', '2024-12-06 12:05:02'),
(1527, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:05:02'),
(1528, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:05:03'),
(1529, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:05:05'),
(1530, 'POST - STEPS - /link-step-to-proccess', '{\"id\":11,\"tipo\":8,\"obrigatorio\":0,\"proccessTypeId\":6,\"ordem\":null}', NULL, 'success', '2024-12-06 12:05:07'),
(1531, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:05:07'),
(1532, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:05:08'),
(1533, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:05:10'),
(1534, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:05:14'),
(1535, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:05:14'),
(1536, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:05:15'),
(1537, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:05:15'),
(1538, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:05:16'),
(1539, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:05:24'),
(1540, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:07:04'),
(1541, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:07:23'),
(1542, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:07:54'),
(1543, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:07:56'),
(1544, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:07:58'),
(1545, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 12:08:02'),
(1546, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:08:05'),
(1547, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:08:10'),
(1548, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:08:11'),
(1549, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:08:11'),
(1550, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:08:12'),
(1551, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:08:12'),
(1552, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:08:13'),
(1553, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:08:13'),
(1554, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:08:14'),
(1555, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:10:46'),
(1556, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:10:51'),
(1557, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:13:56'),
(1558, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:13:59'),
(1559, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:14:03'),
(1560, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:14:09'),
(1561, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:14:18'),
(1562, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:14:19'),
(1563, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:14:20'),
(1564, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:14:20'),
(1565, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:14:21'),
(1566, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:14:30'),
(1567, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:14:43'),
(1568, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:15:08'),
(1569, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:15:23'),
(1570, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:15:44'),
(1571, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:16:46'),
(1572, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:16:47'),
(1573, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:16:48'),
(1574, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:16:49'),
(1575, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:17:00'),
(1576, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:19:51'),
(1577, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:20:06'),
(1578, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:20:08'),
(1579, 'GET - HOURS - by-student/34', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:20:59'),
(1580, 'GET - PERCENTUAL-POR-TIPO - by-student/34', '404 - Nenhum registro encontrado', NULL, 'error', '2024-12-06 12:21:00'),
(1581, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:21:04'),
(1582, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:21'),
(1583, 'GET - REQUESTS - process-identificador/SoL2Y5puBW7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:33'),
(1584, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:34'),
(1585, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:35'),
(1586, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:35'),
(1587, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:36'),
(1588, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:36'),
(1589, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:37'),
(1590, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:37'),
(1591, 'GET - COMENTARIOS - /all-from-proccess/9', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:40'),
(1592, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:44'),
(1593, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:46'),
(1594, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:49'),
(1595, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:51'),
(1596, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:51'),
(1597, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:52'),
(1598, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:52'),
(1599, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:53'),
(1600, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:54'),
(1601, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:25:54'),
(1602, 'POST - REQUESTS - new', '\nInvalid `prisma.processo.create()` invocation:\n\n\nForeign key constraint failed on the field: `etapa_atual`', NULL, 'error', '2024-12-06 12:26:42'),
(1603, 'POST - REQUESTS - new-question-reply', 'Dados recebidos: campo=5, resposta=Lucas, processo=0, usuario=34', NULL, 'info', '2024-12-06 12:26:42'),
(1604, 'POST - REQUESTS - new-question-reply', 'Processo com ID 0 não encontrado.', NULL, 'error', '2024-12-06 12:26:42'),
(1605, 'POST - REQUESTS - new-question-reply', 'Dados recebidos: campo=6, resposta=Perussi, processo=0, usuario=34', NULL, 'info', '2024-12-06 12:26:43'),
(1606, 'POST - REQUESTS - new-question-reply', 'Processo com ID 0 não encontrado.', NULL, 'error', '2024-12-06 12:26:43'),
(1607, 'POST - REQUESTS - new-question-reply', 'Dados recebidos: campo=7, resposta=lucas@lucas.com, processo=0, usuario=34', NULL, 'info', '2024-12-06 12:26:43'),
(1608, 'POST - REQUESTS - new-question-reply', 'Processo com ID 0 não encontrado.', NULL, 'error', '2024-12-06 12:26:43'),
(1609, 'POST - REQUESTS - new-question-reply', 'Dados recebidos: campo=8, resposta=1999-07-28, processo=0, usuario=34', NULL, 'info', '2024-12-06 12:26:44'),
(1610, 'POST - REQUESTS - new-question-reply', 'Processo com ID 0 não encontrado.', NULL, 'error', '2024-12-06 12:26:44'),
(1611, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:26:49'),
(1612, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:26:53'),
(1613, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:27:17'),
(1614, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:31:45'),
(1615, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:31:49'),
(1616, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:31:51'),
(1617, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:31:54'),
(1618, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:31:56'),
(1619, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:56:11'),
(1620, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:56:20'),
(1621, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:56:22'),
(1622, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:56:25'),
(1623, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:56:29'),
(1624, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:56:32'),
(1625, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:56:34'),
(1626, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:56:35'),
(1627, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 12:56:38'),
(1628, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 13:49:20'),
(1629, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 13:49:23'),
(1630, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 13:49:24'),
(1631, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 13:49:26'),
(1632, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 13:49:28'),
(1633, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 13:49:34'),
(1634, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 13:56:07'),
(1635, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 13:56:16'),
(1636, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 13:56:19'),
(1637, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 13:56:21'),
(1638, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 14:08:20'),
(1639, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 14:09:11'),
(1640, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:09:20'),
(1641, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 14:09:21'),
(1642, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 14:09:27'),
(1643, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:09:34'),
(1644, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:09:37'),
(1645, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":35,\"email\":\"matheus.fiori@ufpr.br\",\"nome\":\"teteu\",\"sobrenome\":\"teteu\",\"nascimento\":\"2002-01-22T00:00:00.000Z\",\"registro\":\"grr55555555\",\"funcao\":1,\"status_usuario\":1}}', 35, 'success', '2024-12-06 14:13:44'),
(1646, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-06 14:14:09'),
(1647, 'sendEmail', 'Enviando email para matheus.fiori@ufpr.br com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info', '2024-12-06 14:14:09'),
(1648, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success', '2024-12-06 14:14:14'),
(1649, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:16:45'),
(1650, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:16:51'),
(1651, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:16:58'),
(1652, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:18:12'),
(1653, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:18:17'),
(1654, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:18:20'),
(1655, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:18:25'),
(1656, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:20:53'),
(1657, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 14:21:02'),
(1658, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":36,\"email\":\"cadastro@fix.com\",\"nome\":\"Lucas\",\"sobrenome\":\"Cadastro\",\"nascimento\":\"1999-07-28T00:00:00.000Z\",\"registro\":\"registroooo\",\"funcao\":1,\"status_usuario\":1}}', 36, 'success', '2024-12-06 14:23:36'),
(1659, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-06 14:23:39'),
(1660, 'sendEmail', 'Enviando email para cadastro@fix.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info', '2024-12-06 14:23:39'),
(1661, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success', '2024-12-06 14:23:42'),
(1662, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:25:17'),
(1663, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:32:59'),
(1664, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:33:27'),
(1665, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:33:28'),
(1666, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:33:29'),
(1667, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:33:29'),
(1668, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:33:30'),
(1669, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:33:30'),
(1670, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:33:31'),
(1671, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:33:32'),
(1672, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":37,\"email\":\"xcxzc@hotmail.com\",\"nome\":\"Lucas\",\"sobrenome\":\"Perussi de Oliveira\",\"nascimento\":\"1999-07-28T00:00:00.000Z\",\"registro\":\"sdfsdfsdfsdfsdf\",\"funcao\":1,\"status_usuario\":1,\"foto\":\"\"}}', 37, 'success', '2024-12-06 14:33:37'),
(1673, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-06 14:33:37'),
(1674, 'sendEmail', 'Enviando email para xcxzc@hotmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info', '2024-12-06 14:33:37'),
(1675, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 14:33:38'),
(1676, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success', '2024-12-06 14:33:40'),
(1677, 'GET - USERS - id/37', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:33:48'),
(1678, 'PATCH - USERS - FOTO - 37', '200 - Foto atualizada com sucesso', NULL, 'success', '2024-12-06 14:36:08'),
(1679, 'PATCH - USERS - SOBRENOME - 37', '200 - Sobrenome atualizado com sucesso', NULL, 'success', '2024-12-06 14:36:18'),
(1680, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 14:36:20'),
(1681, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:36:24'),
(1682, 'GET - USERS - id/37', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:36:25'),
(1683, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 14:36:29'),
(1684, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:36:34'),
(1685, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:36:38'),
(1686, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:36:40'),
(1687, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:36:41'),
(1688, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:36:41'),
(1689, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:36:42'),
(1690, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:36:43'),
(1691, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:36:44'),
(1692, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:36:45'),
(1693, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:37:31'),
(1694, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:37:50'),
(1695, 'GET - REQUESTS - process-identificador/dsqwKhoCi65', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:37:58'),
(1696, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:37:59'),
(1697, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:37:59'),
(1698, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:38:00'),
(1699, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:38:00'),
(1700, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:38:00'),
(1701, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:38:00'),
(1702, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:38:01'),
(1703, 'GET - COMENTARIOS - /all-from-proccess/13', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:38:03'),
(1704, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:38:18'),
(1705, 'POST - COMENTARIOS - new', '{\"id\":1,\"processo\":13,\"usuario\":31,\"comentario\":\"kjfkjsfksgs\",\"data\":\"2024-12-06T14:39:43.000Z\",\"usuario_comentarios_usuarioTousuario\":{\"nome\":\"Aluno\",\"sobrenome\":\"da Silva\",\"email\":\"aluno@aluno.com\",\"foto\":\"\"}}', NULL, 'success', '2024-12-06 14:39:43'),
(1706, 'GET - REQUESTS - process-identificador/dsqwKhoCi65', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:39:44'),
(1707, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:39:45'),
(1708, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:39:45'),
(1709, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:39:46'),
(1710, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:39:46'),
(1711, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:39:46'),
(1712, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:39:46'),
(1713, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:39:47'),
(1714, 'GET - COMENTARIOS - /all-from-proccess/13', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:39:49'),
(1715, 'POST - COMENTARIOS - new', '{\"id\":2,\"processo\":13,\"usuario\":31,\"comentario\":\"kjfkjsfksgs\",\"data\":\"2024-12-06T14:39:49.000Z\",\"usuario_comentarios_usuarioTousuario\":{\"nome\":\"Aluno\",\"sobrenome\":\"da Silva\",\"email\":\"aluno@aluno.com\",\"foto\":\"\"}}', NULL, 'success', '2024-12-06 14:39:49'),
(1716, 'POST - COMENTARIOS - new', '{\"id\":3,\"processo\":13,\"usuario\":31,\"comentario\":\"kjfkjsfksgs\",\"data\":\"2024-12-06T14:39:49.000Z\",\"usuario_comentarios_usuarioTousuario\":{\"nome\":\"Aluno\",\"sobrenome\":\"da Silva\",\"email\":\"aluno@aluno.com\",\"foto\":\"\"}}', NULL, 'success', '2024-12-06 14:39:49'),
(1717, 'POST - COMENTARIOS - new', '{\"id\":4,\"processo\":13,\"usuario\":31,\"comentario\":\"kjfkjsfksgs\",\"data\":\"2024-12-06T14:39:50.000Z\",\"usuario_comentarios_usuarioTousuario\":{\"nome\":\"Aluno\",\"sobrenome\":\"da Silva\",\"email\":\"aluno@aluno.com\",\"foto\":\"\"}}', NULL, 'success', '2024-12-06 14:39:50'),
(1718, 'POST - COMENTARIOS - new', '{\"id\":5,\"processo\":13,\"usuario\":31,\"comentario\":\"kjfkjsfksgs\",\"data\":\"2024-12-06T14:39:50.000Z\",\"usuario_comentarios_usuarioTousuario\":{\"nome\":\"Aluno\",\"sobrenome\":\"da Silva\",\"email\":\"aluno@aluno.com\",\"foto\":\"\"}}', NULL, 'success', '2024-12-06 14:39:50'),
(1719, 'POST - COMENTARIOS - new', '{\"id\":6,\"processo\":13,\"usuario\":31,\"comentario\":\"kjfkjsfksgs\",\"data\":\"2024-12-06T14:39:50.000Z\",\"usuario_comentarios_usuarioTousuario\":{\"nome\":\"Aluno\",\"sobrenome\":\"da Silva\",\"email\":\"aluno@aluno.com\",\"foto\":\"\"}}', NULL, 'success', '2024-12-06 14:39:50'),
(1720, 'POST - COMENTARIOS - new', '{\"id\":7,\"processo\":13,\"usuario\":31,\"comentario\":\"kjfkjsfksgs\",\"data\":\"2024-12-06T14:39:51.000Z\",\"usuario_comentarios_usuarioTousuario\":{\"nome\":\"Aluno\",\"sobrenome\":\"da Silva\",\"email\":\"aluno@aluno.com\",\"foto\":\"\"}}', NULL, 'success', '2024-12-06 14:39:51'),
(1721, 'POST - COMENTARIOS - new', '{\"id\":8,\"processo\":13,\"usuario\":31,\"comentario\":\"kjfkjsfksgs\",\"data\":\"2024-12-06T14:39:51.000Z\",\"usuario_comentarios_usuarioTousuario\":{\"nome\":\"Aluno\",\"sobrenome\":\"da Silva\",\"email\":\"aluno@aluno.com\",\"foto\":\"\"}}', NULL, 'success', '2024-12-06 14:39:51'),
(1722, 'POST - COMENTARIOS - new', '{\"id\":9,\"processo\":13,\"usuario\":31,\"comentario\":\"kjfkjsfksgs\",\"data\":\"2024-12-06T14:39:51.000Z\",\"usuario_comentarios_usuarioTousuario\":{\"nome\":\"Aluno\",\"sobrenome\":\"da Silva\",\"email\":\"aluno@aluno.com\",\"foto\":\"\"}}', NULL, 'success', '2024-12-06 14:39:51'),
(1723, 'POST - COMENTARIOS - new', '{\"id\":10,\"processo\":13,\"usuario\":31,\"comentario\":\"pppppp\",\"data\":\"2024-12-06T14:39:59.000Z\",\"usuario_comentarios_usuarioTousuario\":{\"nome\":\"Aluno\",\"sobrenome\":\"da Silva\",\"email\":\"aluno@aluno.com\",\"foto\":\"\"}}', NULL, 'success', '2024-12-06 14:39:59'),
(1724, 'GET - REQUESTS - process-identificador/dsqwKhoCi65', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:40:00'),
(1725, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:40:00'),
(1726, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:40:01'),
(1727, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:40:01'),
(1728, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:40:01'),
(1729, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:40:01'),
(1730, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:40:02'),
(1731, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:40:02'),
(1732, 'GET - COMENTARIOS - /all-from-proccess/13', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:40:04'),
(1733, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:41:46'),
(1734, 'GET - REQUESTS - process-identificador/dsqwKhoCi65', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:41:49'),
(1735, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:41:49'),
(1736, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:41:50'),
(1737, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:41:50'),
(1738, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:41:50'),
(1739, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:41:50'),
(1740, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:41:51'),
(1741, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:41:51'),
(1742, 'GET - COMENTARIOS - /all-from-proccess/13', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:41:53'),
(1743, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:47:22'),
(1744, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:47:32'),
(1745, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:47:46'),
(1746, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:48:23'),
(1747, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:59:17'),
(1748, 'GET - REQUESTS - process-identificador/dsqwKhoCi65', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:59:21'),
(1749, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:59:23'),
(1750, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:59:23'),
(1751, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:59:24'),
(1752, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:59:24'),
(1753, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:59:25'),
(1754, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:59:26'),
(1755, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:59:27'),
(1756, 'GET - COMENTARIOS - /all-from-proccess/13', '200 - Found and Authorized', NULL, 'success', '2024-12-06 14:59:29'),
(1757, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 15:04:51'),
(1758, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-06 15:04:53'),
(1759, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 15:08:46'),
(1760, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 15:09:41'),
(1761, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 15:10:40'),
(1762, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 15:10:41');
INSERT INTO `logs` (`id`, `funcao`, `mensagem`, `usuario`, `status`, `data`) VALUES
(1763, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 15:11:05'),
(1764, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 15:11:08'),
(1765, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 15:11:08'),
(1766, 'POST - HOURS - /new', '200 - New training hours record created: ID 14', NULL, 'success', '2024-12-06 15:16:48'),
(1767, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 15:16:48'),
(1768, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 15:16:49'),
(1769, 'GET - HOURS - by-student/24', '200 - Found and Authorized', NULL, 'success', '2024-12-06 15:50:19'),
(1770, 'GET - PERCENTUAL-POR-TIPO - by-student/24', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 15:50:21'),
(1771, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:19:53'),
(1772, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:20:05'),
(1773, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:25:13'),
(1774, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:25:44'),
(1775, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:25:46'),
(1776, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:26:01'),
(1777, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:26:04'),
(1778, 'GET - MURAL - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:26:08'),
(1779, 'GET - MURAL - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:26:08'),
(1780, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:26:09'),
(1781, 'GET - MURAL - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:26:38'),
(1782, 'GET - MURAL - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:26:39'),
(1783, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:26:39'),
(1784, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:27:21'),
(1785, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:27:25'),
(1786, 'GET - Course - all-courses', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:27:39'),
(1787, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:32:56'),
(1788, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:33:14'),
(1789, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:37:19'),
(1790, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:37:23'),
(1791, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 16:37:24'),
(1792, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:38:07'),
(1793, 'GET - INTERNSHIP - id/2', '404 - Not Found', NULL, 'error', '2024-12-06 16:38:19'),
(1794, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:38:23'),
(1795, 'GET - INTERNSHIP - id/2', '404 - Not Found', NULL, 'error', '2024-12-06 16:40:17'),
(1796, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:41:03'),
(1797, 'GET - INTERNSHIP - internships/24', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:41:35'),
(1798, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:41:58'),
(1799, 'GET - INTERNSHIP - internships/30', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:42:36'),
(1800, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:44:06'),
(1801, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 16:44:07'),
(1802, 'GET - INTERNSHIP - internships/30', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:44:30'),
(1803, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:45:53'),
(1804, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:45:56'),
(1805, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:45:57'),
(1806, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:45:57'),
(1807, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:45:58'),
(1808, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:45:59'),
(1809, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:45:59'),
(1810, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:46:00'),
(1811, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 16:46:00'),
(1812, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:09'),
(1813, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:12'),
(1814, 'GET - REQUESTS - process-identificador/dsqwKhoCi65', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:14'),
(1815, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:15'),
(1816, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:16'),
(1817, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:17'),
(1818, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:17'),
(1819, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:18'),
(1820, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:18'),
(1821, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:20'),
(1822, 'GET - COMENTARIOS - /all-from-proccess/13', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:23'),
(1823, 'GET - REQUESTS - process-identificador/dsqwKhoCi65', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:23'),
(1824, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:23'),
(1825, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:24'),
(1826, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:24'),
(1827, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:24'),
(1828, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:24'),
(1829, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:25'),
(1830, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:26'),
(1831, 'GET - COMENTARIOS - /all-from-proccess/13', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:28'),
(1832, 'GET - REQUESTS - process-identificador/dsqwKhoCi65', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:28'),
(1833, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:28'),
(1834, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:29'),
(1835, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:29'),
(1836, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:29'),
(1837, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:30'),
(1838, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:30'),
(1839, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:31'),
(1840, 'GET - COMENTARIOS - /all-from-proccess/13', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:33'),
(1841, 'GET - REQUESTS - process-identificador/dsqwKhoCi65', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:33'),
(1842, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:34'),
(1843, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:34'),
(1844, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:34'),
(1845, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:34'),
(1846, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:35'),
(1847, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:35'),
(1848, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:36'),
(1849, 'GET - COMENTARIOS - /all-from-proccess/13', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:38'),
(1850, 'GET - REQUESTS - process-identificador/dsqwKhoCi65', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:38'),
(1851, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:39'),
(1852, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:39'),
(1853, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:39'),
(1854, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:40'),
(1855, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:40'),
(1856, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:40'),
(1857, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:41'),
(1858, 'GET - COMENTARIOS - /all-from-proccess/13', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:04:43'),
(1859, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:17:21'),
(1860, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:17:35'),
(1861, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:29:36'),
(1862, 'GET - INTERNSHIP - id/30', '404 - Not Found', NULL, 'error', '2024-12-06 17:30:21'),
(1863, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:48:41'),
(1864, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:51:22'),
(1865, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:51:32'),
(1866, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:51:49'),
(1867, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:51:54'),
(1868, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:51:56'),
(1869, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:51:56'),
(1870, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:51:57'),
(1871, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:51:58'),
(1872, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:51:59'),
(1873, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:52:00'),
(1874, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:52:02'),
(1875, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:56:18'),
(1876, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:58:44'),
(1877, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:58:48'),
(1878, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:58:49'),
(1879, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:58:50'),
(1880, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:58:50'),
(1881, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:58:51'),
(1882, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:58:52'),
(1883, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:58:52'),
(1884, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 17:58:54'),
(1885, 'GET - INTERNSHIP - internships/30', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:02:22'),
(1886, 'GET - COMPANY - all-companies', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:03:51'),
(1887, 'GET - COMPANY -/new', '200 - Nova empresa cadastrada: Teste', NULL, 'success', '2024-12-06 18:04:27'),
(1888, 'GET - COMPANY - all-companies', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:04:39'),
(1889, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:05:25'),
(1890, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:07:48'),
(1891, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:07:49'),
(1892, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:07:49'),
(1893, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:07:50'),
(1894, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:07:50'),
(1895, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:07:51'),
(1896, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:07:52'),
(1897, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:07:53'),
(1898, 'GET - INTERNSHIP - code/1603568889', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:13:45'),
(1899, 'GET - INTERNSHIP - internships/30', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:14:09'),
(1900, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:22:49'),
(1901, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:22:50'),
(1902, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:22:51'),
(1903, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:22:51'),
(1904, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:22:52'),
(1905, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:22:52'),
(1906, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:22:53'),
(1907, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:22:54'),
(1908, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:30:12'),
(1909, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:30:18'),
(1910, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:30:21'),
(1911, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:30:22'),
(1912, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:30:23'),
(1913, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:30:23'),
(1914, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:30:24'),
(1915, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:30:24'),
(1916, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:30:24'),
(1917, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:30:25'),
(1918, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:38:16'),
(1919, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:38:17'),
(1920, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:38:17'),
(1921, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:38:18'),
(1922, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:38:18'),
(1923, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:38:19'),
(1924, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:38:19'),
(1925, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:38:20'),
(1926, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:38:20'),
(1927, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:40:45'),
(1928, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:40:46'),
(1929, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:40:46'),
(1930, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:40:47'),
(1931, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:40:47'),
(1932, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:40:48'),
(1933, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:40:48'),
(1934, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:40:49'),
(1935, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:46:33'),
(1936, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:46:45'),
(1937, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:47:25'),
(1938, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:47:39'),
(1939, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:57:51'),
(1940, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:58:01'),
(1941, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:58:13'),
(1942, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:58:19'),
(1943, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:58:24'),
(1944, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:59:23'),
(1945, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:59:45'),
(1946, 'GET - HOURS - by-student/24', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:59:55'),
(1947, 'GET - PERCENTUAL-POR-TIPO - by-student/24', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 18:59:56'),
(1948, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 18:59:59'),
(1949, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:00:01'),
(1950, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:00:16'),
(1951, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:00:34'),
(1952, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:00:40'),
(1953, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:00:43'),
(1954, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 19:01:01'),
(1955, 'getMyRequestsStudent', 'Erro ao listar admins. Error: Erro interno (404)', 36, 'error', '2024-12-06 19:01:02'),
(1956, 'GET - USERS - id/36', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:07'),
(1957, 'PATCH - USERS - FOTO - 36', '200 - Foto atualizada com sucesso', NULL, 'success', '2024-12-06 19:01:11'),
(1958, 'PATCH - USERS - FOTO - 36', '200 - Foto atualizada com sucesso', NULL, 'success', '2024-12-06 19:01:14'),
(1959, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 19:01:17'),
(1960, 'getMyRequestsStudent', 'Erro ao listar admins. Error: Erro interno (404)', 36, 'error', '2024-12-06 19:01:17'),
(1961, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:20'),
(1962, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:24'),
(1963, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:26'),
(1964, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:27'),
(1965, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:27'),
(1966, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:28'),
(1967, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:29'),
(1968, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:29'),
(1969, 'getUnifiedStages', 'Resposta inesperada ao listar etapas padrão: []', 36, 'warning', '2024-12-06 19:01:30'),
(1970, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:31'),
(1971, 'getUnifiedStages', 'Resposta inesperada ao listar etapas personalizadas: []', 36, 'warning', '2024-12-06 19:01:31'),
(1972, 'getUnifiedStages', 'Etapas unificadas retornadas com sucesso.', 36, 'info', '2024-12-06 19:01:32'),
(1973, 'POST - REQUESTS - new', '\nInvalid `prisma.processo.create()` invocation:\n\n\nForeign key constraint failed on the field: `etapa_atual`', NULL, 'error', '2024-12-06 19:01:47'),
(1974, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:50'),
(1975, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:50'),
(1976, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:51'),
(1977, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:52'),
(1978, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:52'),
(1979, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:53'),
(1980, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:53'),
(1981, 'getUnifiedStages', 'Resposta inesperada ao listar etapas padrão: []', 36, 'warning', '2024-12-06 19:01:54'),
(1982, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:01:54'),
(1983, 'getUnifiedStages', 'Resposta inesperada ao listar etapas personalizadas: []', 36, 'warning', '2024-12-06 19:01:55'),
(1984, 'getUnifiedStages', 'Etapas unificadas retornadas com sucesso.', 36, 'info', '2024-12-06 19:01:56'),
(1985, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 19:02:03'),
(1986, 'getMyRequestsStudent', 'Erro ao listar admins. Error: Erro interno (404)', 36, 'error', '2024-12-06 19:02:04'),
(1987, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-06 19:02:23'),
(1988, 'getMyRequestsStudent', 'Erro ao listar admins. Error: Erro interno (404)', 36, 'error', '2024-12-06 19:02:24'),
(1989, 'GET - REQUESTS - process-identificador/dsqwKhoCi65', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:42:21'),
(1990, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:42:23'),
(1991, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:42:23'),
(1992, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:42:24'),
(1993, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:42:24'),
(1994, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:42:53'),
(1995, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:42:53'),
(1996, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:42:54'),
(1997, 'GET - COMENTARIOS - /all-from-proccess/13', '200 - Found and Authorized', NULL, 'success', '2024-12-06 19:42:56'),
(1998, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:14:18'),
(1999, 'GET - USERS - id/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:14:27'),
(2000, 'PATCH - USERS - FOTO - 31', '200 - Foto atualizada com sucesso', NULL, 'success', '2024-12-06 22:14:32'),
(2001, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:14:42'),
(2002, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:14:52'),
(2003, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:14:58'),
(2004, 'GET - REQUEST TYPE - id/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:14:59'),
(2005, 'GET - FIELDS - request-field-by-process-type/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:15:00'),
(2006, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:15:01'),
(2007, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:15:01'),
(2008, 'GET - STEPS - link-step-to-proccess/7', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:15:02'),
(2009, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:15:03'),
(2010, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:15:04'),
(2011, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:15:24'),
(2012, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 22:15:26'),
(2013, 'GET - HOURS - by-student/31', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:15:36'),
(2014, 'GET - PERCENTUAL-POR-TIPO - by-student/31', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-06 22:15:37'),
(2015, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:15:41'),
(2016, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:15:46'),
(2017, 'GET - REQUESTS - /all-requests-as-student', '200 - Found and Authorized', NULL, 'success', '2024-12-06 22:16:24'),
(2018, 'GET - USERS - all', '200 - Found and Authorized', NULL, 'success', '2024-12-07 01:05:29'),
(2019, 'PATCH - USER - role', '{\"id\":29,\"email\":\"ruan.cunha@ufpr.br\",\"senha\":\"$2a$10$aNT72/DE7Gnamng/CFeVoevaG4R75s8qB8G6xQrTdrC61DZDi1qjO\",\"registro\":\"GRR20220043\",\"nome\":\"Ruan\",\"sobrenome\":\"Brito\",\"nascimento\":\"1998-09-06T00:00:00.000Z\",\"criado_em\":\"2024-11-09T14:13:41.000Z\",\"funcao\"', NULL, 'success', '2024-12-07 01:08:20'),
(2020, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 01:10:56'),
(2021, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-07 01:11:00'),
(2022, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 01:13:01'),
(2023, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-07 01:13:05'),
(2024, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 01:20:19'),
(2025, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-07 01:20:25'),
(2026, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 01:20:37'),
(2027, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-07 01:20:39'),
(2028, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 01:25:59'),
(2029, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-07 01:26:25'),
(2030, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 01:31:58'),
(2031, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 01:32:03'),
(2032, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:05:40'),
(2033, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:09:12'),
(2034, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:09:25'),
(2035, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:09:29'),
(2036, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:11:12'),
(2037, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:11:15'),
(2038, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:11:21'),
(2039, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:13:17'),
(2040, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:16:56'),
(2041, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:17:18'),
(2042, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:19:33'),
(2043, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:19:51'),
(2044, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:20:20'),
(2045, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:20:43'),
(2046, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:23:17'),
(2047, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:23:20'),
(2048, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:24:29'),
(2049, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:24:47'),
(2050, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:27:30'),
(2051, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:45:50'),
(2052, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:48:52'),
(2053, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:49:30'),
(2054, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:58:54'),
(2055, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-07 14:59:06'),
(2056, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:13:16'),
(2057, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:13:31'),
(2058, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:14:29'),
(2059, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:14:32'),
(2060, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:15:55'),
(2061, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:15:57'),
(2062, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:15:59'),
(2063, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:16:02'),
(2064, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:16:03'),
(2065, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:16:08'),
(2066, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:16:20'),
(2067, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:16:22'),
(2068, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:16:29'),
(2069, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:17:48'),
(2070, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:17:51'),
(2071, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:26:58'),
(2072, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:27:01'),
(2073, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:31:56'),
(2074, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:31:59'),
(2075, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:37:45'),
(2076, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 15:37:48'),
(2077, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 19:15:36'),
(2078, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 20:13:52'),
(2079, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-07 20:27:27'),
(2080, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 20:27:39'),
(2081, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-07 20:30:48'),
(2082, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 20:33:43'),
(2083, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-07 20:45:55'),
(2084, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 20:47:39'),
(2085, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-07 20:48:31'),
(2086, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 21:42:10'),
(2087, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-07 21:42:17'),
(2088, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 22:06:45'),
(2089, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-07 22:06:48'),
(2090, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-07 22:19:16'),
(2091, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 11:38:44'),
(2092, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-08 11:38:48'),
(2093, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 11:39:26'),
(2094, 'GET - SYSTEM - logs', '200 - Found and Authorized', NULL, 'success', '2024-12-08 11:39:28'),
(2095, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:08:24'),
(2096, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:08:28'),
(2097, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:20:13'),
(2098, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:20:17'),
(2099, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:22:40'),
(2100, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:22:46'),
(2101, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:22:49'),
(2102, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:22:57'),
(2103, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:22:58'),
(2104, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:22:58'),
(2105, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:22:59'),
(2106, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:00'),
(2107, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:10'),
(2108, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:11'),
(2109, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:12'),
(2110, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:12'),
(2111, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:14'),
(2112, 'GET - REQUEST TYPE - id/NaN', 'Error fetching requested Field type. {\"name\":\"PrismaClientValidationError\",\"clientVersion\":\"5.5.2\"} ', NULL, 'error', '2024-12-08 12:23:21'),
(2113, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:22'),
(2114, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:23'),
(2115, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:24'),
(2116, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:26'),
(2117, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:27'),
(2118, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:28'),
(2119, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:28'),
(2120, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:28'),
(2121, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:28'),
(2122, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:29'),
(2123, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:31'),
(2124, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:23:34'),
(2125, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:33:16'),
(2126, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:33:21'),
(2127, 'POST - REQUEST TYPE - new', '{\"id\":8,\"nome\":\"teste\",\"fluxograma\":\"sdsds\",\"hrs_resposta\":4,\"hrs_resolucao\":4}', NULL, 'success', '2024-12-08 12:33:33'),
(2128, 'GET - REQUEST TYPE - id/8', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:33:34'),
(2129, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:33:34'),
(2130, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:33:35'),
(2131, 'GET - FIELDS - request-field-by-process-type/8', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:33:36'),
(2132, 'POST - FIELDS - new-request-field', '{\"id\":9,\"tipo\":7,\"nome\":\"nome\",\"nome_exibicao\":\"Nome\",\"tipo_processo\":8}', NULL, 'success', '2024-12-08 12:34:26'),
(2133, 'POST - FIELDS - new-request-field', '{\"id\":10,\"tipo\":8,\"nome\":\"sobrenome\",\"nome_exibicao\":\"Sobrenome\",\"tipo_processo\":8}', NULL, 'success', '2024-12-08 12:34:27'),
(2134, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:27'),
(2135, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:27'),
(2136, 'GET - FIELDS - request-field-by-process-type/8', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:27'),
(2137, 'GET - FIELDS - request-field-by-process-type/8', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:28'),
(2138, 'POST - FIELDS - new-request-field', '{\"id\":11,\"tipo\":9,\"nome\":\"email\",\"nome_exibicao\":\"Email\",\"tipo_processo\":8}', NULL, 'success', '2024-12-08 12:34:29'),
(2139, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:29'),
(2140, 'POST - FIELDS - new-request-field', '{\"id\":12,\"tipo\":10,\"nome\":\"telefone\",\"nome_exibicao\":\"Telefone\",\"tipo_processo\":8}', NULL, 'success', '2024-12-08 12:34:29'),
(2141, 'GET - FIELDS - request-field-by-process-type/8', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:30'),
(2142, 'POST - FIELDS - new-request-field', '{\"id\":13,\"tipo\":11,\"nome\":\"descricao\",\"nome_exibicao\":\"Descrição\",\"tipo_processo\":8}', NULL, 'success', '2024-12-08 12:34:30'),
(2143, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:30'),
(2144, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:31'),
(2145, 'GET - FIELDS - request-field-by-process-type/8', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:31'),
(2146, 'POST - FIELDS - new-request-field', '{\"id\":14,\"tipo\":12,\"nome\":\"data\",\"nome_exibicao\":\"Data\",\"tipo_processo\":8}', NULL, 'success', '2024-12-08 12:34:31'),
(2147, 'GET - FIELDS - request-field-by-process-type/8', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:31'),
(2148, 'POST - FIELDS - new-request-field', '{\"id\":15,\"tipo\":13,\"nome\":\"horas\",\"nome_exibicao\":\"Carga Horária\",\"tipo_processo\":8}', NULL, 'success', '2024-12-08 12:34:32'),
(2149, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:32'),
(2150, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:33'),
(2151, 'GET - FIELDS - request-field-by-process-type/8', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:33'),
(2152, 'GET - FIELDS - request-field-by-process-type/8', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:33'),
(2153, 'POST - FIELDS - remove-link-field-to-request', '{\"count\":1}', NULL, 'success', '2024-12-08 12:34:39'),
(2154, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:39'),
(2155, 'GET - FIELDS - request-field-by-process-type/8', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:40'),
(2156, 'POST - FIELDS - new-request-field', '{\"id\":16,\"tipo\":7,\"nome\":\"nome\",\"nome_exibicao\":\"Nome\",\"tipo_processo\":8}', NULL, 'success', '2024-12-08 12:34:41'),
(2157, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:41'),
(2158, 'GET - FIELDS - request-field-by-process-type/8', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:34:42'),
(2159, 'POST - FIELDS - remove-link-field-to-request', '{\"count\":1}', NULL, 'success', '2024-12-08 12:39:46'),
(2160, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:39:46'),
(2161, 'GET - FIELDS - request-field-by-process-type/8', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:39:46'),
(2162, 'POST - FIELDS - new-request-field', '{\"id\":17,\"tipo\":7,\"nome\":\"nome\",\"nome_exibicao\":\"Nome\",\"tipo_processo\":8}', NULL, 'success', '2024-12-08 12:39:47'),
(2163, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:39:48'),
(2164, 'GET - FIELDS - request-field-by-process-type/8', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:39:48'),
(2165, 'POST - FIELDS - new-type-for-process', '{\"id\":16,\"nome\":\"numero_da_cor\",\"etiqueta\":\"telefone\",\"obrigatorio\":0,\"tipo_dado\":3,\"campo_padrao\":0}', NULL, 'success', '2024-12-08 12:45:04'),
(2166, 'POST - FIELDS - new-type-for-process', '{\"id\":18,\"tipo\":16,\"nome\":\"numero_da_cor\",\"nome_exibicao\":\"telefone\",\"tipo_processo\":8}', NULL, 'success', '2024-12-08 12:45:04'),
(2167, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:45:05'),
(2168, 'GET - FIELDS - request-field-by-process-type/8', '200 - Found and Authorized', NULL, 'success', '2024-12-08 12:45:05'),
(2169, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 18:27:34'),
(2170, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 18:39:14'),
(2171, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-08 18:39:19'),
(2172, 'GET - MURAL - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 18:39:21'),
(2173, 'GET - MURAL - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 18:39:21'),
(2174, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-08 18:39:22'),
(2175, 'GET - USERS - id/28', '200 - Found and Authorized', NULL, 'success', '2024-12-08 18:39:28'),
(2176, 'GET - USERS - id/28', '200 - Found and Authorized', NULL, 'success', '2024-12-08 18:39:37'),
(2177, 'GET - USERS - id/28', '200 - Found and Authorized', NULL, 'success', '2024-12-08 18:39:37'),
(2178, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-08 18:39:41'),
(2179, 'GET - MURAL - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 18:39:46'),
(2180, 'GET - MURAL - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 18:39:46'),
(2181, 'GET - USERS - id/24', '200 - Found and Authorized', NULL, 'success', '2024-12-08 18:39:46'),
(2182, 'GET - REQUESTS - process-identificador/6', '404 - Not Found', NULL, 'error', '2024-12-08 20:16:36'),
(2183, 'GET - REQUESTS - process-identificador/1', '404 - Not Found', NULL, 'error', '2024-12-08 20:16:43'),
(2184, 'GET - REQUESTS - process-identificador/1', '404 - Not Found', NULL, 'error', '2024-12-08 21:32:58'),
(2185, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-08 21:33:06'),
(2186, 'GET - REQUESTS - /all-requests-as-teacher', '404 - Not Found', NULL, 'error', '2024-12-08 22:08:46'),
(2187, 'GET - REQUESTS - /all-requests-as-teacher', '404 - Not Found', NULL, 'error', '2024-12-08 22:08:55'),
(2188, 'GET - REQUESTS - /all-requests-as-teacher', '404 - Not Found', NULL, 'error', '2024-12-08 22:08:58'),
(2189, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:09:03'),
(2190, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:09:18'),
(2191, 'GET - REQUESTS - process-identificador/6', '404 - Not Found', NULL, 'error', '2024-12-08 22:09:41'),
(2192, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:09:44'),
(2193, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:09:45'),
(2194, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:09:46'),
(2195, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: matheus.fiori@ufpr.br | registro: GRR20211618', NULL, 'error', '2024-12-08 22:09:47'),
(2196, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:09:47'),
(2197, 'GET - REQUESTS - all-responses-process/6', '404 - Not Found', NULL, 'error', '2024-12-08 22:09:49'),
(2198, 'GET - REQUESTS - process-identificador/6', '404 - Not Found', NULL, 'error', '2024-12-08 22:09:51'),
(2199, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:09:54'),
(2200, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:09:54'),
(2201, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:09:55'),
(2202, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:09:56');
INSERT INTO `logs` (`id`, `funcao`, `mensagem`, `usuario`, `status`, `data`) VALUES
(2203, 'GET - REQUESTS - all-responses-process/6', '404 - Not Found', NULL, 'error', '2024-12-08 22:09:58'),
(2204, 'GET - REQUESTS - process-identificador/2', '404 - Not Found', NULL, 'error', '2024-12-08 22:10:00'),
(2205, 'auth/create', '400 - Erro - Motivo: Registro já atrelado a outro usuário! | email: mathfiori00@gmail.com | registro: GRR20211618', NULL, 'error', '2024-12-08 22:10:01'),
(2206, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:10:02'),
(2207, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:10:03'),
(2208, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:10:04'),
(2209, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:10:05'),
(2210, 'GET - REQUESTS - all-responses-process/2', '404 - Not Found', NULL, 'error', '2024-12-08 22:10:06'),
(2211, 'GET - REQUESTS - /all-requests-as-teacher', '404 - Not Found', NULL, 'error', '2024-12-08 22:10:14'),
(2212, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":38,\"email\":\"mathfiori00@gmail.com\",\"nome\":\"Matheus\",\"sobrenome\":\"Fiori\",\"nascimento\":\"2002-01-22T00:00:00.000Z\",\"registro\":\"grr20219999\",\"funcao\":1,\"status_usuario\":1,\"foto\":\"src/img/avatars/generic.webp\"}}', 38, 'success', '2024-12-08 22:10:14'),
(2213, 'GET - SYSTEM - timelines-user/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:10:14'),
(2214, 'GET - USERS - id/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:10:15'),
(2215, 'sendEmail', 'Encontrados 1 novos registros.', NULL, 'info', '2024-12-08 22:10:21'),
(2216, 'sendEmail', 'Enviando email para mathfiori00@gmail.com com o título \"Bem-vindo(a) à secretaria online do SEPT!\"...', NULL, 'info', '2024-12-08 22:10:21'),
(2217, 'GET - REQUESTS - /all-requests-as-teacher', '404 - Not Found', NULL, 'error', '2024-12-08 22:10:26'),
(2218, 'sendEmail', 'Email enviado com sucesso!', NULL, 'success', '2024-12-08 22:10:26'),
(2219, 'GET - REQUESTS - /all-requests-as-teacher', '404 - Not Found', NULL, 'error', '2024-12-08 22:10:26'),
(2220, 'GET - COURSES - by-user/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:10:34'),
(2221, 'getCourseByStudent', 'Erro ao listar curso. Error: Nenhum registro encontrado', 38, 'error', '2024-12-08 22:10:34'),
(2222, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:10:34'),
(2223, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-08 22:10:35'),
(2224, 'getMyRequestsStudent', 'Erro ao listar admins. Error: Erro interno (404)', 38, 'error', '2024-12-08 22:10:35'),
(2225, 'GET - USERS - id/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:10:43'),
(2226, 'GET - Course - all-courses', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:10:44'),
(2227, 'PATCH - USERS - FOTO - 38', '200 - Foto atualizada com sucesso', NULL, 'success', '2024-12-08 22:10:49'),
(2228, 'PATCH - USERS - REGISTRO - 38', '200 - Registro atualizado com sucesso', NULL, 'success', '2024-12-08 22:11:08'),
(2229, 'PATCH - USERS - SOBRENOME - 38', '200 - Sobrenome atualizado com sucesso', NULL, 'success', '2024-12-08 22:11:09'),
(2230, 'GET - REQUESTS - /all-requests-as-teacher', '404 - Not Found', NULL, 'error', '2024-12-08 22:11:13'),
(2231, 'GET - SYSTEM - timelines-user/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:11:15'),
(2232, 'GET - USERS - id/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:11:35'),
(2233, 'GET - Course - all-courses', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:11:35'),
(2234, 'GET - COURSES - by-user/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:11:39'),
(2235, 'getCourseByStudent', 'Erro ao listar curso. Error: Nenhum registro encontrado', 38, 'error', '2024-12-08 22:11:39'),
(2236, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:11:39'),
(2237, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-08 22:11:39'),
(2238, 'getMyRequestsStudent', 'Erro ao listar admins. Error: Erro interno (404)', 38, 'error', '2024-12-08 22:11:40'),
(2239, 'GET - HOURS - by-student/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:11:44'),
(2240, 'GET - COURSES - by-user/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:11:45'),
(2241, 'getCourseByStudent', 'Erro ao listar curso. Error: Nenhum registro encontrado', 38, 'error', '2024-12-08 22:11:45'),
(2242, 'GET - PERCENTUAL-POR-TIPO - by-student/38', '404 - Nenhum registro encontrado', NULL, 'error', '2024-12-08 22:11:46'),
(2243, 'getHoursUser', 'Erro ao listar horas formativas de usuário 38. Error: Erro interno (404)', 38, 'error', '2024-12-08 22:11:46'),
(2244, 'GET - HORAS-ALUNO - by-student/38', '404 - Curso não encontrado', NULL, 'error', '2024-12-08 22:11:46'),
(2245, 'getHoursTotalUserPercentage', 'Erro ao listar horas formativas de usuário 38. Error: Erro interno (404)', 38, 'error', '2024-12-08 22:11:46'),
(2246, 'GET - COURSES - by-user/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:11:53'),
(2247, 'getCourseByStudent', 'Erro ao listar curso. Error: Nenhum registro encontrado', 38, 'error', '2024-12-08 22:11:53'),
(2248, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:11:53'),
(2249, 'GET - REQUESTS - /all-requests-as-student', '404 - Not Found', NULL, 'error', '2024-12-08 22:11:53'),
(2250, 'getMyRequestsStudent', 'Erro ao listar admins. Error: Erro interno (404)', 38, 'error', '2024-12-08 22:11:53'),
(2251, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:11:56'),
(2252, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:11:59'),
(2253, 'GET - REQUEST TYPE - all', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:12:03'),
(2254, 'GET - REQUEST TYPE - id/6', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:12:04'),
(2255, 'GET - FIELDS - request-field-by-process-type/6', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:12:04'),
(2256, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:12:05'),
(2257, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:12:05'),
(2258, 'GET - STEPS - link-step-to-proccess/6', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:12:06'),
(2259, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:12:06'),
(2260, 'getUnifiedStages', 'Resposta inesperada ao listar etapas padrão: []', 38, 'warning', '2024-12-08 22:12:06'),
(2261, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:12:07'),
(2262, 'getUnifiedStages', 'Resposta inesperada ao listar etapas personalizadas: []', 38, 'warning', '2024-12-08 22:12:07'),
(2263, 'getUnifiedStages', 'Etapas unificadas retornadas com sucesso.', 38, 'info', '2024-12-08 22:12:08'),
(2264, 'GET - REQUESTS - process-identificador/6', '404 - Not Found', NULL, 'error', '2024-12-08 22:12:10'),
(2265, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:12:12'),
(2266, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:12:13'),
(2267, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:12:14'),
(2268, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:12:15'),
(2269, 'GET - REQUESTS - all-responses-process/6', '404 - Not Found', NULL, 'error', '2024-12-08 22:12:16'),
(2270, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:12:23'),
(2271, 'GET - REQUESTS - /all-requests-as-teacher', '404 - Not Found', NULL, 'error', '2024-12-08 22:12:47'),
(2272, 'POST - REQUESTS - new', '\nInvalid `prisma.processo.create()` invocation:\n\n\nForeign key constraint failed on the field: `etapa_atual`', NULL, 'error', '2024-12-08 22:13:28'),
(2273, 'POST - REQUESTS - new', '\nInvalid `prisma.processo.create()` invocation:\n\n\nForeign key constraint failed on the field: `etapa_atual`', NULL, 'error', '2024-12-08 22:13:45'),
(2274, 'POST - REQUESTS - new', '\nInvalid `prisma.processo.create()` invocation:\n\n\nForeign key constraint failed on the field: `etapa_atual`', NULL, 'error', '2024-12-08 22:16:22'),
(2275, 'GET - HOURS - by-student/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:16:25'),
(2276, 'GET - COURSES - by-user/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:16:25'),
(2277, 'getCourseByStudent', 'Erro ao listar curso. Error: Nenhum registro encontrado', 38, 'error', '2024-12-08 22:16:26'),
(2278, 'GET - PERCENTUAL-POR-TIPO - by-student/38', '404 - Nenhum registro encontrado', NULL, 'error', '2024-12-08 22:16:26'),
(2279, 'getHoursUser', 'Erro ao listar horas formativas de usuário 38. Error: Erro interno (404)', 38, 'error', '2024-12-08 22:16:26'),
(2280, 'GET - HORAS-ALUNO - by-student/38', '404 - Curso não encontrado', NULL, 'error', '2024-12-08 22:16:27'),
(2281, 'getHoursTotalUserPercentage', 'Erro ao listar horas formativas de usuário 38. Error: Erro interno (404)', 38, 'error', '2024-12-08 22:16:27'),
(2282, 'POST - HOURS - /new', '200 - New training hours record created: ID 15', NULL, 'success', '2024-12-08 22:16:49'),
(2283, 'GET - HOURS - by-student/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:16:49'),
(2284, 'GET - COURSES - by-user/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:16:50'),
(2285, 'getCourseByStudent', 'Erro ao listar curso. Error: Nenhum registro encontrado', 38, 'error', '2024-12-08 22:16:50'),
(2286, 'GET - PERCENTUAL-POR-TIPO - by-student/38', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-08 22:16:50'),
(2287, 'GET - HORAS-ALUNO - by-student/38', '404 - Curso não encontrado', NULL, 'error', '2024-12-08 22:16:50'),
(2288, 'getHoursTotalUserPercentage', 'Erro ao listar horas formativas de usuário 38. Error: Erro interno (404)', 38, 'error', '2024-12-08 22:16:51'),
(2289, 'POST - HOURS - /new', '200 - New training hours record created: ID 16', NULL, 'success', '2024-12-08 22:17:39'),
(2290, 'GET - HOURS - by-student/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:17:40'),
(2291, 'GET - COURSES - by-user/38', '200 - Found and Authorized', NULL, 'success', '2024-12-08 22:17:40'),
(2292, 'getCourseByStudent', 'Erro ao listar curso. Error: Nenhum registro encontrado', 38, 'error', '2024-12-08 22:17:40'),
(2293, 'GET - PERCENTUAL-POR-TIPO - by-student/38', '200 - Percentuais calculados com sucesso', NULL, 'success', '2024-12-08 22:17:41'),
(2294, 'GET - HORAS-ALUNO - by-student/38', '404 - Curso não encontrado', NULL, 'error', '2024-12-08 22:17:41'),
(2295, 'getHoursTotalUserPercentage', 'Erro ao listar horas formativas de usuário 38. Error: Erro interno (404)', 38, 'error', '2024-12-08 22:17:41'),
(2296, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:21:11'),
(2297, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:21:21'),
(2298, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:21:24'),
(2299, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:24:04'),
(2300, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:26:21'),
(2301, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:47:10'),
(2302, 'GET - INTERNSHIP - code/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:50:31'),
(2303, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:50:40'),
(2304, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:50:58'),
(2305, 'GET - INTERNSHIP - code/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:51:22'),
(2306, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:51:28'),
(2307, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:51:44'),
(2308, 'GET - INTERNSHIP - code/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:51:56'),
(2309, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:52:02'),
(2310, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:52:15'),
(2311, 'GET - INTERNSHIP - code/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:52:29'),
(2312, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:52:35'),
(2313, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:52:37'),
(2314, 'GET - INTERNSHIP - code/1', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:52:44'),
(2315, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-08 23:52:50'),
(2316, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:01:48'),
(2317, 'GET - INTERNSHIP - code/1', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:01:54'),
(2318, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:02:00'),
(2319, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:10:47'),
(2320, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:32:20'),
(2321, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:34:27'),
(2322, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:34:36'),
(2323, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:42:23'),
(2324, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:44:33'),
(2325, 'GET - MURAL - all', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:44:51'),
(2326, 'GET - INTERNSHIP - id/1', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:45:19'),
(2327, 'GET - REQUESTS - process-identificador/6', '404 - Not Found', NULL, 'error', '2024-12-09 00:45:57'),
(2328, 'getProccessIdentifier', 'Erro ao listar campos de processo. Error: Erro interno (404)', 24, 'error', '2024-12-09 00:45:58'),
(2329, 'getProccessTypeId', 'Erro ao listar tipo de processo. Error: Erro interno (404)', 24, 'error', '2024-12-09 00:46:00'),
(2330, 'getProccessFields', 'Erro ao listar campos de processo. Error: Erro interno (404)', 24, 'error', '2024-12-09 00:46:01'),
(2331, 'GET - FIELDS - all-default-fields', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:46:02'),
(2332, 'GET - FIELDS - all-field-types', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:46:02'),
(2333, 'getProccessStages', 'Erro ao listar campos de processo. Error: Erro interno (404)', 24, 'error', '2024-12-09 00:46:04'),
(2334, 'GET - STEPS - all-default', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:46:04'),
(2335, 'getUnifiedStages', 'Resposta inesperada ao listar etapas padrão: []', 24, 'warning', '2024-12-09 00:46:05'),
(2336, 'GET - STEPS - all-customized', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:46:06'),
(2337, 'getUnifiedStages', 'Resposta inesperada ao listar etapas personalizadas: []', 24, 'warning', '2024-12-09 00:46:06'),
(2338, 'getUnifiedStages', 'Etapas unificadas retornadas com sucesso.', 24, 'info', '2024-12-09 00:46:08'),
(2339, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:46:08'),
(2340, 'GET - REQUESTS - all-responses-process/6', '404 - Not Found', NULL, 'error', '2024-12-09 00:46:09'),
(2341, 'getAllProcessResponses', 'Erro ao listar etapas de padrões. Error: Erro interno (404)', 24, 'error', '2024-12-09 00:46:09'),
(2342, 'getAllProcessComments', 'Erro ao listar etapas de padrões. Error: Erro interno (404)', 24, 'error', '2024-12-09 00:46:11'),
(2343, 'GET - SYSTEM - logs/last50', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:46:18'),
(2344, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:55:25'),
(2345, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-09 00:57:30'),
(2346, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:04:15'),
(2347, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:05:48'),
(2348, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:10:30'),
(2349, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:10:45'),
(2350, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:12:15'),
(2351, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:12:51'),
(2352, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:12:54'),
(2354, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:14:12'),
(2355, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:14:18'),
(2356, 'GET - INTERNSHIP - internships/24', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:19:20'),
(2357, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:20:58'),
(2358, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:22:05'),
(2359, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:22:45'),
(2360, 'GET - USERS - all-servers', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:22:50'),
(2361, 'GET - USERS - all-admins', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:22:52'),
(2362, 'GET - USERS - all-teachers', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:22:55'),
(2363, 'GET - USERS - all-students', '200 - Found and Authorized', NULL, 'success', '2024-12-09 01:24:10');

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
(1, 'Publicação de teste', 'textinho de descricao', '44rwLMPBALo0KPjbqVET', 24, '2024-12-02 11:14:59', 1, 1),
(2, 'Testou', 'tá funcionando?', 'lRb08pqnZmpBezWsPjuc', 31, '2024-12-02 11:15:27', 1, 2),
(3, 'Vamos ver teste', 'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum ', 'TfQTwPt2fx2avJnxTWtO', 31, '2024-12-02 11:15:57', 1, 1);

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
  `identificador` varchar(60) NOT NULL,
  `aluno` int(11) NOT NULL,
  `data_abertura` datetime NOT NULL,
  `servidor_responsavel` int(11) DEFAULT NULL,
  `professor_avaliador` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `justificativa_conclusao` varchar(255) DEFAULT NULL,
  `data_limite_resolucao` datetime DEFAULT NULL,
  `tipo_solicitacao` int(11) NOT NULL,
  `etapa_atual` int(11) NOT NULL,
  `numero` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `processo`
--

INSERT INTO `processo` (`id`, `titulo`, `descricao`, `identificador`, `aluno`, `data_abertura`, `servidor_responsavel`, `professor_avaliador`, `status`, `justificativa_conclusao`, `data_limite_resolucao`, `tipo_solicitacao`, `etapa_atual`, `numero`) VALUES
(9, 'Quero pedir uma alteração cadastral', 'Preciso trocar meu GRR no cadastro.', 'SoL2Y5puBW7K4ANYX39Wiumcybf5qPCBGkDSUFUFAHO0d7X3AUldp2IchX1n', 34, '2024-12-06 12:09:02', NULL, NULL, 1, NULL, NULL, 7, 5, 91497504),
(10, 'Quero pedir uma alteração cadastral', 'Preciso trocar meu GRR no cadastro.', 'Rut9353dFxrk3OFbgdgErBMn5OkUIRY4hrdRmpMylmJ9Q8qAfuZGr1Jczqxm', 34, '2024-12-06 12:09:48', NULL, NULL, 1, NULL, NULL, 7, 5, 69255059),
(11, 'Quero pedir uma alteração cadastral', 'Preciso trocar meu GRR no cadastro.', 'G5kJphx7cmYJFi0j37UcXKYl4YLdmdgmbJeZ9olNWgeqEoOQfUTjdwJgNXjh', 34, '2024-12-06 12:11:03', NULL, NULL, 1, NULL, NULL, 7, 5, 14640684),
(13, 'Quero trocar minha senha', 'Por favor, gostaria que minha senha fosse novamente redefinida para \"testeDeSenha@999\".', 'dsqwKhoCi65sLVCpTNvqXtxaxJfcWLwMmUFPaYnmEACA5hGMKOdaWeVeGXDu', 31, '2024-12-06 14:34:29', NULL, NULL, 1, NULL, NULL, 7, 5, 36200663),
(14, 'aaaaaaaa', 'aaaaaaaaa', '5LKbtTJOhRjjF0IPLqfNJMAgb3RQFXeX9fYDtPtfJWn9OGKBpPW99jlX7xcB', 37, '2024-12-06 14:36:56', NULL, NULL, 1, NULL, NULL, 7, 5, 54583495),
(15, 'aaaaa', 'aaaaaaaaaaaaaaaaaaaaaa', 'uHPtpokYsz2cUwBglLizw2tbGKjuKgTo0WF7dQfhswcRuPWISq85wVjcjD1q', 37, '2024-12-06 17:54:46', NULL, NULL, 1, NULL, NULL, 7, 5, 94764247),
(16, 'aaaa', 'aaaaaaaaaaaa', 'fBUSAEXDgPyfhg4Wjdl2K12ioRRfAQw3ymja88pCyM59VWiY5qz615Mr9JTL', 37, '2024-12-06 18:08:08', NULL, NULL, 1, NULL, NULL, 7, 5, 10810629),
(17, 'aaaa', 'aaaaaaaaaaaa', 'p1fXs7GKFEZcST8NOIAC3buoeP77j9Tt89XFgmksYhGthcnTSGJeMHta3rWG', 37, '2024-12-06 18:12:16', NULL, NULL, 1, NULL, NULL, 7, 5, 21575134),
(18, 'bbbbbbbbbbbbbb', 'aaaaaaaaaaaa', '4hFv1AH9Xsp8l2Ap17a0ex9BG3NDbkmMavIS6ic6LU2cf6LmYweKDXxS2aUO', 37, '2024-12-06 18:20:36', NULL, NULL, 1, NULL, NULL, 7, 5, 798825),
(19, 'bbbbbbbbbbbbbb', 'aaaaaaaaaaaa', 'CDF6gDSdagz6rdQX7SRigWhOkgjAvRNBXdQWHYWsU7rohiVOhe3mH3yDGTca', 37, '2024-12-06 18:21:33', NULL, NULL, 1, NULL, NULL, 7, 5, 9004783),
(20, 'cccc', 'ccccccccc', 'JHh1TdQzCnJGOeQCayQkmweSqUF0grIBpITZoW1u2toM0jIzcpEvlaExb4m0', 37, '2024-12-06 18:23:25', NULL, NULL, 1, NULL, NULL, 7, 5, 57960765),
(21, 'cvxcv', 'xcvxcvxc', 'RTdPbBp34wiyvqE3CM6GzjJDQ6UlPBqp5xaR9t5fPtUYuxgf09Vq92x4eH10', 37, '2024-12-06 18:30:44', NULL, NULL, 1, NULL, NULL, 7, 5, 35251278),
(22, 'cccc', 'ccccccccc', 'O35U7m1q9UfkSpRRUSsFQauxFJ0EoT6gWUy9TsyBOD9hHrLYxsud5h0z5o9s', 37, '2024-12-06 18:32:50', NULL, NULL, 1, NULL, NULL, 7, 5, 53948612),
(23, 'fgfdgfdg', 'dfgdfg', 'polMPquR0zR4Pz5f0S1FIQrYk024BUfDFrYL8VpLf3sfVXYmwLTqU8zjaqdU', 37, '2024-12-06 18:38:33', NULL, NULL, 1, NULL, NULL, 7, 5, 34057212),
(24, 'fgfdgfdg', 'dfgdfg', 'WynBDegA4BVBF8zTUUshBH9gjW2D1HOTL7o5lvSRdYj9efzwAWDQrYZSISbj', 37, '2024-12-06 18:39:47', NULL, NULL, 1, NULL, NULL, 7, 5, 68100381),
(25, 'asdasda', 'sdasdsa', 'NtC9t9udjX57F3AhtotirM40Yn4M8PWpJAjKlJpUp1ug1S19myAme4GvYclc', 37, '2024-12-06 18:43:05', NULL, NULL, 1, NULL, NULL, 7, 5, 84561721);

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
  `tipo` int(11) NOT NULL,
  `data` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `timelines`
--

INSERT INTO `timelines` (`id`, `usuario`, `referencia`, `titulo`, `descricao`, `tipo`, `data`) VALUES
(2, 24, '24', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR20193759', 1, '2024-12-02 08:53:23'),
(3, 25, '25', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro PRF20193759', 1, '2024-12-02 08:53:23'),
(4, 26, '26', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro PRF20df193759', 1, '2024-12-02 08:53:23'),
(5, 27, '27', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR20193750', 1, '2024-12-02 08:53:23'),
(6, 28, '28', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR20211618', 1, '2024-12-02 08:53:23'),
(7, 29, '29', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR20220043', 1, '2024-12-02 08:53:23'),
(8, 30, '30', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR20291618', 1, '2024-12-02 08:53:23'),
(9, 31, '31', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR99999999', 1, '2024-12-02 08:53:23'),
(10, 32, '32', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro 343434343', 1, '2024-12-02 08:53:23'),
(11, 33, '33', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR2019000', 1, '2024-12-06 10:43:29'),
(12, 34, '34', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR22222', 1, '2024-12-06 11:44:28'),
(13, 34, '9', 'Chamado registrado', 'O chamado número 91497504 foi registrado com sucesso', 3, '2024-12-06 12:09:02'),
(14, 34, '10', 'Chamado registrado', 'O chamado número 69255059 foi registrado com sucesso', 3, '2024-12-06 12:09:48'),
(15, 34, '11', 'Chamado registrado', 'O chamado número 14640684 foi registrado com sucesso', 3, '2024-12-06 12:11:03'),
(16, 35, '35', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR55555555', 1, '2024-12-06 14:13:44'),
(17, 36, '36', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro registroooo', 1, '2024-12-06 14:23:36'),
(18, 37, '37', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro sdfsdfsdfsdfsdf', 1, '2024-12-06 14:33:37'),
(19, 31, '13', 'Chamado registrado', 'O chamado número 36200663 foi registrado com sucesso', 3, '2024-12-06 14:34:30'),
(20, 37, '14', 'Chamado registrado', 'O chamado número 54583495 foi registrado com sucesso', 3, '2024-12-06 14:36:56'),
(21, 31, '13', 'Novo comentário', 'Um novo comentário foi registrado em seu chamado!', 5, '2024-12-06 14:39:43'),
(22, 31, '13', 'Novo comentário', 'Um novo comentário foi registrado em seu chamado!', 5, '2024-12-06 14:39:49'),
(23, 31, '13', 'Novo comentário', 'Um novo comentário foi registrado em seu chamado!', 5, '2024-12-06 14:39:49'),
(24, 31, '13', 'Novo comentário', 'Um novo comentário foi registrado em seu chamado!', 5, '2024-12-06 14:39:50'),
(25, 31, '13', 'Novo comentário', 'Um novo comentário foi registrado em seu chamado!', 5, '2024-12-06 14:39:50'),
(26, 31, '13', 'Novo comentário', 'Um novo comentário foi registrado em seu chamado!', 5, '2024-12-06 14:39:50'),
(27, 31, '13', 'Novo comentário', 'Um novo comentário foi registrado em seu chamado!', 5, '2024-12-06 14:39:51'),
(28, 31, '13', 'Novo comentário', 'Um novo comentário foi registrado em seu chamado!', 5, '2024-12-06 14:39:51'),
(29, 31, '13', 'Novo comentário', 'Um novo comentário foi registrado em seu chamado!', 5, '2024-12-06 14:39:51'),
(30, 31, '13', 'Novo comentário', 'Um novo comentário foi registrado em seu chamado!', 5, '2024-12-06 14:39:59'),
(31, 37, '15', 'Chamado registrado', 'O chamado número 94764247 foi registrado com sucesso', 3, '2024-12-06 17:54:46'),
(32, 37, '16', 'Chamado registrado', 'O chamado número 10810629 foi registrado com sucesso', 3, '2024-12-06 18:08:08'),
(33, 37, '17', 'Chamado registrado', 'O chamado número 21575134 foi registrado com sucesso', 3, '2024-12-06 18:12:16'),
(34, 37, '18', 'Chamado registrado', 'O chamado número 798825 foi registrado com sucesso', 3, '2024-12-06 18:20:36'),
(35, 37, '19', 'Chamado registrado', 'O chamado número 9004783 foi registrado com sucesso', 3, '2024-12-06 18:21:33'),
(36, 37, '21', 'Chamado registrado', 'O chamado número 35251278 foi registrado com sucesso', 3, '2024-12-06 18:30:44'),
(37, 37, '22', 'Chamado registrado', 'O chamado número 53948612 foi registrado com sucesso', 3, '2024-12-06 18:32:50'),
(38, 37, '23', 'Chamado registrado', 'O chamado número 34057212 foi registrado com sucesso', 3, '2024-12-06 18:38:33'),
(39, 37, '24', 'Chamado registrado', 'O chamado número 68100381 foi registrado com sucesso', 3, '2024-12-06 18:39:47'),
(40, 37, '25', 'Chamado registrado', 'O chamado número 84561721 foi registrado com sucesso', 3, '2024-12-06 18:43:05'),
(41, 38, '38', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR20219999', 1, '2024-12-08 22:10:14'),
(42, 38, '38', 'Alteração de foto de perfil', 'Seu nascimento foi alterado', 16, '2024-12-08 22:10:49'),
(43, 38, '38', 'Alteração de registro', 'Seu registro foi alterado', 12, '2024-12-08 22:11:08'),
(44, 38, '38', 'Alteração de sobrenome', 'Seu sobrenome foi alterado', 14, '2024-12-08 22:11:09');

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
(7, 'nome', 'Nome', 0, 1, 1),
(8, 'sobrenome', 'Sobrenome', 0, 1, 1),
(9, 'email', 'Email', 0, 4, 1),
(10, 'telefone', 'Telefone', 0, 5, 1),
(11, 'descricao', 'Descrição', 0, 6, 1),
(12, 'data', 'Data', 0, 3, 1),
(13, 'horas', 'Carga Horária', 0, 2, 1),
(14, 'info', 'Dado a ser alterado', 0, 1, 0),
(15, 'novo', 'Informação atualizada', 0, 1, 0),
(16, 'numero_da_cor', 'telefone', 0, 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tipo_solicitacao`
--

CREATE TABLE `tipo_solicitacao` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `fluxograma` varchar(255) NOT NULL,
  `hrs_resposta` int(11) DEFAULT NULL,
  `hrs_resolucao` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tipo_solicitacao`
--

INSERT INTO `tipo_solicitacao` (`id`, `nome`, `fluxograma`, `hrs_resposta`, `hrs_resolucao`) VALUES
(6, 'Quebra de requisito para TCC', 'testezin', 20, 60),
(7, 'Alteração Cadastral', 'ertgttghfdh', 24, 24),
(8, 'teste', 'sdsds', 4, 4);

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
(24, 'perussilucas@hotmail.com', '$2a$10$WWaHYx2/cfAk2SgNcxKLY.xXcOrImswudv12aQXtUOg9IpVHxkr/W', 'GRR20193759', 'Lucas', 'Perussi', '1999-07-28', '2024-10-10 20:05:21', 9, 'src/img/avatars/pessoa-1.webp', 1, NULL, 1),
(25, 'professor@hotmail.com', '$2a$10$ES5CjJKLmuXbV4OhsX1G3.oafMmsiQHwhAfJV9DVuHbBI658fVcW6', 'PRF20193759', 'Lucas', 'Professor', '1999-07-28', '2024-10-11 14:06:56', 3, '', 1, NULL, 1),
(26, 'proffdgdfgessor@hotmail.com', '$2a$10$ORd9E9JYh6MAwKwE3T.Ouug1Lzsw8Pk/etp0aOvOLCpclfAk9y4Na', 'PRF20df193759', 'Lucas', 'Professor', '1999-07-28', '2024-10-23 17:48:20', 3, '', 1, NULL, 1),
(27, 'perussilucas@icloud.com', '$2a$10$fjQuLnfRhxUzDo2a/VgtA.cTEpKqTccTBvxNtcuD2ckqyWRqDkzoS', 'GRR20193750', 'Lucas', 'Perussi', '1999-07-28', '2024-10-23 18:10:46', 2, '', 1, NULL, 1),
(28, 'math_fiori@hotmail.com', '$2a$10$XU4cEHvwbZFeEySvWWjyUutl75liJOFo5doQpY39vbMWnAqK0GW..', 'GRR20211618', 'Matheus', 'Fiori', '2002-01-22', '2024-11-04 18:43:21', 9, '', 1, NULL, 1),
(29, 'ruan.cunha@ufpr.br', '$2a$10$aNT72/DE7Gnamng/CFeVoevaG4R75s8qB8G6xQrTdrC61DZDi1qjO', 'GRR20220043', 'Ruan', 'Brito', '1998-09-06', '2024-11-09 14:13:41', 3, 'src/img/avatars/art-2.webp', 1, NULL, 1),
(30, 'aluno@teste.com', '$2a$10$aFYDeiE90EKcoSkmWBhm5uZDytJxsR6U1zUs2um3zdGqI1s1mJgbK', 'GRR20291618', 'Matheus', 'Aluno', '2002-01-22', '2024-11-11 23:16:02', 0, '', 1, NULL, 1),
(31, 'aluno@aluno.com', '$2a$10$HqgwgJnAHGF2Z2k//NaXDuY95HeiVOv6tPpQwcxqdiGm9uEF27lFu', 'grr99999999', 'Aluno', 'da Silva', '2001-07-28', '2024-11-22 11:08:01', 1, 'src/img/avatars/art-1.webp', 1, NULL, 1),
(32, 'teste-erro@erro.com', '$2a$10$TeJTdc/BF7B38I3RCMj2W.UR9JLuo8PlJkrUxiPkihHjUR/BT3sdG', '343434343', 'Teste', 'de Erro', '1999-07-28', '2024-11-30 11:33:52', 1, '', 1, NULL, 1),
(33, 'teste@testou.com', '$2a$10$uy4NmZfRcVkiX.r.IxT5UeDmL858NbhT92RNIQiuox.EVDuJdH4FG', 'grr2019000', 'Matheus', 'teste', '1991-11-11', '2024-12-06 10:43:29', 1, '', 1, NULL, 1),
(34, 'aluno@lucas.com', '$2a$10$bjDakVrLxe63H6kfRqbi..ikwcszgGDYlHs0.HV10bac6hBh7I6kC', 'grr22222', 'Lucas', 'Perussi de Oliveira', '1999-07-28', '2024-12-06 11:44:28', 1, 'src/img/avatars/pessoa-1.webp', 1, NULL, 1),
(35, 'matheus.fiori@ufpr.br', '$2a$10$lOkSdMUo7LIUAi//nwwGn.XdNFcl4NjQJ1rPQ98O.cVPKIQtHa/su', 'grr55555555', 'teteu', 'teteu', '2002-01-22', '2024-12-06 14:13:44', 1, '', 1, NULL, 1),
(36, 'cadastro@fix.com', '$2a$10$t4Nwc25qbmZ4EDMkoGIG2eCyQnGM3ZHvBpyKSazHnCZatahJx58YG', 'registroooo', 'Lucas', 'Cadastro', '1999-07-28', '2024-12-06 14:23:36', 1, 'src/img/avatars/pessoa-8.webp', 1, NULL, 1),
(37, 'xcxzc@hotmail.com', '$2a$10$CilGySIu7YSfibh.fPCmr.PlbDZKUdiPtyReo7CHSD3XK9bfPiFlq', 'sdfsdfsdfsdfsdf', 'Lucas', 'Perussi', '1999-07-28', '2024-12-06 14:33:37', 1, 'src/img/avatars/art-2.webp', 1, NULL, 1),
(38, 'mathfiori00@gmail.com', '$2a$10$3wHkQ6P6AlxGdqDHCVzsuOOL3dJojQ1sKioUnDKaEhy0GfuEcscIK', 'grr20219998', 'Matheus', 'Correa', '2002-01-22', '2024-12-08 22:10:14', 1, 'src/img/avatars/pessoa-1.webp', 1, NULL, 1);

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
  ADD KEY `curso_alvo` (`curso_alvo`),
  ADD KEY `identificador` (`identificador`);

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
  ADD UNIQUE KEY `numero` (`numero`),
  ADD UNIQUE KEY `identificador` (`identificador`),
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `codigos`
--
ALTER TABLE `codigos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `curso`
--
ALTER TABLE `curso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `enum_etapas`
--
ALTER TABLE `enum_etapas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `estagio`
--
ALTER TABLE `estagio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `etapas_processo`
--
ALTER TABLE `etapas_processo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `fila_emails`
--
ALTER TABLE `fila_emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `horas_formativas`
--
ALTER TABLE `horas_formativas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `logins`
--
ALTER TABLE `logins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=182;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2364;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `tipos_campos`
--
ALTER TABLE `tipos_campos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `tipo_solicitacao`
--
ALTER TABLE `tipo_solicitacao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

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
