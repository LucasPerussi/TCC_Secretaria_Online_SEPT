-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 07, 2024 at 09:29 PM
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
-- Database: `tcc_tests`
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
(1, 'i0f0A5OiSTqfjjJ', 'perussilucas@hotmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-10-10 20:05:21', 24, 1),
(2, 'DvuMdiR90VtDLLl', 'professor@hotmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-10-11 14:06:56', 25, 1),
(3, 'RvUysMZvKGDZeRK', 'teste071526myht@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 18:26:32', 26, 1),
(4, 'CZLYe4YpxUkFHrA', 'teste071538giql@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 18:38:22', 27, 1),
(5, 'CDIuyiG2iVX6Tqa', 'teste071541z9g4@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 18:41:47', 28, 1),
(6, 'vye3cMeUtO2aXtu', 'teste071546engp@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 18:46:57', 29, 1),
(7, '36D0Dos56LM6Pwj', 'teste071548fdvy@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 18:48:31', 30, 1),
(8, 'FVQDa0xb3JofKNI', 'teste071550qjeb@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 18:50:31', 31, 1),
(9, 't6EiZa8Dm2SFQ5e', 'teste0715524h9e@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 18:52:03', 32, 1),
(10, 'tp75SazicZliybl', 'teste071553gk9s@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 18:53:32', 33, 1),
(11, 'yv11A9usLSE1wzK', 'teste0715533xx5@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 18:53:44', 34, 1),
(12, 'In4DZshqajr0MkO', 'teste071556xd5v@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 18:56:32', 35, 1),
(13, 'IAhkMEg7BoBRp9X', 'teste071557qf8k@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 18:57:18', 36, 1),
(14, 'wvlJ8y9jeu2Z4u2', 'teste071559xhs6@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 18:59:22', 37, 1),
(15, 'nOYObxY1KWbozcE', 'teste071559mnpa@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 18:59:45', 38, 1),
(16, 'tf8E2SVOB8yo9Fn', 'teste071604rmjn@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 19:04:36', 39, 1),
(17, 'ykyrC521dUc4u7g', 'teste071608wetz@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 19:08:52', 40, 1),
(18, '3H8ESshbV8jMUsy', 'teste071613dgdq@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 19:13:26', 41, 1),
(19, 'FAPI8gtCKNsYuCi', 'teste071614vytw@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 19:14:52', 42, 1),
(20, 'HYFPw4HuaFVVUeX', 'teste071615i1xb@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 19:15:13', 43, 1),
(21, 'NzKrCCnYeMBHKxq', 'teste071617sudn@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 19:17:34', 44, 1),
(22, 'Cn3YQBzSNi4os8u', 'teste0716244439@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 19:24:48', 45, 1),
(23, 'hIJEpi8EjC5AE2t', 'teste071626zm0e@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 19:26:23', 46, 1),
(24, 'TJdVJzDXUOww51o', 'teste0716289pn9@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 19:28:38', 47, 1),
(25, 'YuFfSYwh2e3UcGU', 'teste071629mjyz@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 19:29:06', 48, 1),
(26, 'eZMwgvW8nih88wV', 'teste071629d1xn@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 19:29:32', 49, 1),
(27, 'ergxHVbvDyecJkb', 'teste07163176au@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 19:31:34', 50, 1),
(28, '4ZF3c6TPS47q7sA', 'teste071638i5e3@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 19:38:25', 51, 1),
(29, 'rWgkhFGlu1CIHWc', 'teste071640ijsl@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 19:40:06', 52, 1),
(30, 'MujrCwbWhJHCMfL', 'teste071701wukh@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:01:14', 53, 1),
(31, 'tKiIzE4MblUOP9v', 'teste071704w2cw@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:04:16', 54, 1),
(32, 'Gnnw04AlhyWTzFH', 'teste071706fjpv@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:06:59', 55, 1),
(33, 'rduPSEUkhw85g8M', 'teste071707jhkr@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:07:19', 56, 1),
(34, '51oQDSW8GV6aYIj', 'teste071707wvv3@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:07:48', 57, 1),
(35, 'jejhoAB66DEPmvj', 'teste071708pj0r@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:08:21', 58, 1),
(36, 'R58EOvd15weCEd9', 'teste071708ztvi@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:08:37', 59, 1),
(37, '0osGJyHEiDdG3kw', 'teste0717109ogm@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:10:28', 60, 1),
(38, 'LatlBtRWpMsr9ig', 'teste071711fhfj@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:11:13', 61, 1),
(39, 'Nr6H2JjK6f8plOh', 'teste07171133q7@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:11:28', 62, 1),
(40, 'DWo0tFbxDDjsbx3', 'teste071713b77k@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:13:13', 63, 1),
(41, 'B5WgSFbo17byrbn', 'teste0717154gra@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:15:21', 64, 1),
(42, 'WOZmds5A4hjggJz', 'teste0717169pwi@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:16:41', 65, 1),
(43, 'rinjG7qUea1kmsn', 'teste0717195gy0@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:19:33', 66, 1),
(44, 'am0m0gysYxERwKA', 'teste07172083lu@teste.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '1', '2024-11-07 20:20:36', 67, 1);

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
  `ip` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `logins`
--

INSERT INTO `logins` (`id`, `usuario`, `data`, `local`, `chave_sessao`, `status`, `ip`) VALUES
(12, 24, '2024-10-11 14:47:36', 'Localhost', '9287e9573fc969f4', 1, '::1'),
(13, 26, '2024-11-07 18:26:32', 'undefined, undefined, undefined', 'a790772caab55c1b', 1, '::ffff:127.0.0.'),
(14, 27, '2024-11-07 18:38:22', 'undefined, undefined, undefined', '77be7b72c4125240', 1, '::ffff:127.0.0.'),
(15, 28, '2024-11-07 18:41:47', 'undefined, undefined, undefined', 'bba7d7b926ee8df3', 1, '::ffff:127.0.0.'),
(16, 29, '2024-11-07 18:46:57', 'undefined, undefined, undefined', '28dbd6a05ee958a7', 1, '::ffff:127.0.0.'),
(17, 30, '2024-11-07 18:48:32', 'undefined, undefined, undefined', '3393ddf2aa312aca', 1, '::ffff:127.0.0.'),
(18, 31, '2024-11-07 18:50:31', 'undefined, undefined, undefined', 'a76a7d4bbcaf9555', 1, '::ffff:127.0.0.'),
(19, 32, '2024-11-07 18:52:03', 'undefined, undefined, undefined', 'cbff77d01a464333', 1, '::ffff:127.0.0.'),
(20, 33, '2024-11-07 18:53:32', 'undefined, undefined, undefined', '33732bf4729c8e3f', 1, '::ffff:127.0.0.'),
(21, 34, '2024-11-07 18:53:44', 'undefined, undefined, undefined', 'a330e94ce35fb4c1', 1, '::ffff:127.0.0.'),
(22, 35, '2024-11-07 18:56:32', 'undefined, undefined, undefined', '6969576b5011b1bb', 1, '::ffff:127.0.0.'),
(23, 36, '2024-11-07 18:57:18', 'undefined, undefined, undefined', '2f50fd2cf452b4ee', 1, '::ffff:127.0.0.'),
(24, 37, '2024-11-07 18:59:23', 'undefined, undefined, undefined', '290f520550d81ac7', 1, '::ffff:127.0.0.'),
(25, 38, '2024-11-07 18:59:45', 'undefined, undefined, undefined', 'b546cbe419f27641', 1, '::ffff:127.0.0.'),
(26, 39, '2024-11-07 19:04:36', 'undefined, undefined, undefined', '588f7ce3386106cb', 1, '::ffff:127.0.0.'),
(27, 40, '2024-11-07 19:08:52', 'undefined, undefined, undefined', '2718bd08e366d4e4', 1, '::ffff:127.0.0.'),
(28, 41, '2024-11-07 19:13:26', 'undefined, undefined, undefined', '14bd4c9a6d0f214b', 1, '::ffff:127.0.0.'),
(29, 42, '2024-11-07 19:14:52', 'undefined, undefined, undefined', '25bef04ddf33e388', 1, '::ffff:127.0.0.'),
(30, 43, '2024-11-07 19:15:13', 'undefined, undefined, undefined', 'e62ed5b7e7839f9e', 1, '::ffff:127.0.0.'),
(31, 44, '2024-11-07 19:17:34', 'undefined, undefined, undefined', 'b784a9cba6e82c67', 1, '::ffff:127.0.0.'),
(32, 45, '2024-11-07 19:24:48', 'undefined, undefined, undefined', '0397d1249a84ff42', 1, '::ffff:127.0.0.'),
(33, 46, '2024-11-07 19:26:23', 'undefined, undefined, undefined', '9595de5d95370c2c', 1, '::ffff:127.0.0.'),
(34, 47, '2024-11-07 19:28:38', 'undefined, undefined, undefined', 'b0faec8dee3feac2', 1, '::ffff:127.0.0.'),
(35, 48, '2024-11-07 19:29:06', 'undefined, undefined, undefined', 'fa8f43b7b819f4fe', 1, '::ffff:127.0.0.'),
(36, 49, '2024-11-07 19:29:32', 'undefined, undefined, undefined', '91ef7dc95f8ad9f6', 1, '::ffff:127.0.0.'),
(37, 50, '2024-11-07 19:31:35', 'undefined, undefined, undefined', 'f46e0499239c5d01', 1, '::ffff:127.0.0.'),
(38, 51, '2024-11-07 19:38:25', 'undefined, undefined, undefined', 'd98cb3188cc5376d', 1, '::ffff:127.0.0.'),
(39, 52, '2024-11-07 19:40:06', 'undefined, undefined, undefined', 'b80aa394dce9e5d7', 1, '::ffff:127.0.0.'),
(40, 53, '2024-11-07 20:01:14', 'undefined, undefined, undefined', '71cd3fdbdcebf04e', 1, '::ffff:127.0.0.'),
(41, 54, '2024-11-07 20:04:16', 'undefined, undefined, undefined', '9f50ac183684a623', 1, '::ffff:127.0.0.'),
(42, 55, '2024-11-07 20:06:59', 'undefined, undefined, undefined', '756bf15a57ee021f', 1, '::ffff:127.0.0.'),
(43, 56, '2024-11-07 20:07:19', 'undefined, undefined, undefined', 'a1d67f7d179a8627', 1, '::ffff:127.0.0.'),
(44, 57, '2024-11-07 20:07:48', 'undefined, undefined, undefined', '3ca14eac1a339d73', 1, '::ffff:127.0.0.'),
(45, 58, '2024-11-07 20:08:21', 'undefined, undefined, undefined', '8db899bccdd33096', 1, '::ffff:127.0.0.'),
(46, 59, '2024-11-07 20:08:37', 'undefined, undefined, undefined', '66601e56c2ba8f5a', 1, '::ffff:127.0.0.'),
(47, 60, '2024-11-07 20:10:28', 'undefined, undefined, undefined', 'b0778514210f5bec', 1, '::ffff:127.0.0.'),
(48, 61, '2024-11-07 20:11:13', 'undefined, undefined, undefined', '7a3e3f7fef75bfd8', 1, '::ffff:127.0.0.'),
(49, 62, '2024-11-07 20:11:28', 'undefined, undefined, undefined', 'd6b21a906be48d26', 1, '::ffff:127.0.0.'),
(50, 63, '2024-11-07 20:13:13', 'undefined, undefined, undefined', '9be609045497b353', 1, '::ffff:127.0.0.'),
(51, 64, '2024-11-07 20:15:21', 'undefined, undefined, undefined', '6e3049d1a18b5d08', 1, '::ffff:127.0.0.'),
(52, 65, '2024-11-07 20:16:41', 'undefined, undefined, undefined', '903cbd366da930d7', 1, '::ffff:127.0.0.'),
(53, 66, '2024-11-07 20:19:34', 'undefined, undefined, undefined', 'fc1a3e6df7f4959a', 1, '::ffff:127.0.0.'),
(54, 67, '2024-11-07 20:20:36', 'undefined, undefined, undefined', '7f1884363309816b', 1, '::ffff:127.0.0.');

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
(73, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":26,\"email\":\"teste071526myht@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR0715267yzm\",\"funcao\":1,\"status_usuario\":1}}', 26, 'success'),
(74, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(75, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071526myht@teste.com | registro: 654321', NULL, 'error'),
(76, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":27,\"email\":\"teste071538giql@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071538h3rk\",\"funcao\":1,\"status_usuario\":1}}', 27, 'success'),
(77, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(78, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071538giql@teste.com | registro: 654321', NULL, 'error'),
(79, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":28,\"email\":\"teste071541z9g4@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR0715410g2a\",\"funcao\":1,\"status_usuario\":1}}', 28, 'success'),
(80, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(81, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071541z9g4@teste.com | registro: 654321', NULL, 'error'),
(82, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":29,\"email\":\"teste071546engp@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071546dpd6\",\"funcao\":1,\"status_usuario\":1}}', 29, 'success'),
(83, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(84, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071546engp@teste.com | registro: 654321', NULL, 'error'),
(85, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":30,\"email\":\"teste071548fdvy@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071548czmu\",\"funcao\":1,\"status_usuario\":1}}', 30, 'success'),
(86, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(87, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071548fdvy@teste.com | registro: 654321', NULL, 'error'),
(88, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":31,\"email\":\"teste071550qjeb@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR0715508t55\",\"funcao\":1,\"status_usuario\":1}}', 31, 'success'),
(89, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071550qjeb@teste.com | registro: 654321', NULL, 'error'),
(90, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(91, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(92, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":32,\"email\":\"teste0715524h9e@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071552hy63\",\"funcao\":1,\"status_usuario\":1}}', 32, 'success'),
(93, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste0715524h9e@teste.com | registro: 654321', NULL, 'error'),
(94, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(95, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":33,\"email\":\"teste071553gk9s@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071553mb52\",\"funcao\":1,\"status_usuario\":1}}', 33, 'success'),
(96, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071553gk9s@teste.com | registro: 654321', NULL, 'error'),
(97, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(98, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":34,\"email\":\"teste0715533xx5@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071553h22k\",\"funcao\":1,\"status_usuario\":1}}', 34, 'success'),
(99, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(100, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste0715533xx5@teste.com | registro: 654321', NULL, 'error'),
(101, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":35,\"email\":\"teste071556xd5v@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071556gzng\",\"funcao\":1,\"status_usuario\":1}}', 35, 'success'),
(102, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071556xd5v@teste.com | registro: 654321', NULL, 'error'),
(103, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(104, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":36,\"email\":\"teste071557qf8k@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071557urm8\",\"funcao\":1,\"status_usuario\":1}}', 36, 'success'),
(105, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071557qf8k@teste.com | registro: 654321', NULL, 'error'),
(106, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(107, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(108, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":37,\"email\":\"teste071559xhs6@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071559gi8q\",\"funcao\":1,\"status_usuario\":1}}', 37, 'success'),
(109, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(110, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071559xhs6@teste.com | registro: 654321', NULL, 'error'),
(111, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":38,\"email\":\"teste071559mnpa@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071559nxn0\",\"funcao\":1,\"status_usuario\":1}}', 38, 'success'),
(112, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(113, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071559mnpa@teste.com | registro: 654321', NULL, 'error'),
(114, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":39,\"email\":\"teste071604rmjn@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR0716046k9j\",\"funcao\":1,\"status_usuario\":1}}', 39, 'success'),
(115, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(116, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071604rmjn@teste.com | registro: 654321', NULL, 'error'),
(117, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":40,\"email\":\"teste071608wetz@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071608aqmd\",\"funcao\":1,\"status_usuario\":1}}', 40, 'success'),
(118, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071608wetz@teste.com | registro: 654321', NULL, 'error'),
(119, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(120, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(121, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":41,\"email\":\"teste071613dgdq@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071613q8t5\",\"funcao\":1,\"status_usuario\":1}}', 41, 'success'),
(122, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071613dgdq@teste.com | registro: 654321', NULL, 'error'),
(123, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(124, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":42,\"email\":\"teste071614vytw@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR0716140mk2\",\"funcao\":1,\"status_usuario\":1}}', 42, 'success'),
(125, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(126, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071614vytw@teste.com | registro: 654321', NULL, 'error'),
(127, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":43,\"email\":\"teste071615i1xb@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071615qchr\",\"funcao\":1,\"status_usuario\":1}}', 43, 'success'),
(128, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(129, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071615i1xb@teste.com | registro: 654321', NULL, 'error'),
(130, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":44,\"email\":\"teste071617sudn@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR0716175xa9\",\"funcao\":1,\"status_usuario\":1}}', 44, 'success'),
(131, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071617sudn@teste.com | registro: 654321', NULL, 'error'),
(132, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(133, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":45,\"email\":\"teste0716244439@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR0716247z50\",\"funcao\":1,\"status_usuario\":1}}', 45, 'success'),
(134, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(135, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste0716244439@teste.com | registro: 654321', NULL, 'error'),
(136, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":46,\"email\":\"teste071626zm0e@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071626ggo2\",\"funcao\":1,\"status_usuario\":1}}', 46, 'success'),
(137, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(138, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071626zm0e@teste.com | registro: 654321', NULL, 'error'),
(139, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":47,\"email\":\"teste0716289pn9@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR0716285z2n\",\"funcao\":1,\"status_usuario\":1}}', 47, 'success'),
(140, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(141, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste0716289pn9@teste.com | registro: 654321', NULL, 'error'),
(142, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":48,\"email\":\"teste071629mjyz@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR0716295xdz\",\"funcao\":1,\"status_usuario\":1}}', 48, 'success'),
(143, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(144, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071629mjyz@teste.com | registro: 654321', NULL, 'error'),
(145, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":49,\"email\":\"teste071629d1xn@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR0716296w0n\",\"funcao\":1,\"status_usuario\":1}}', 49, 'success'),
(146, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071629d1xn@teste.com | registro: 654321', NULL, 'error'),
(147, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(148, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(149, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":50,\"email\":\"teste07163176au@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR0716317f2c\",\"funcao\":1,\"status_usuario\":1}}', 50, 'success'),
(150, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste07163176au@teste.com | registro: 654321', NULL, 'error'),
(151, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(152, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(153, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":51,\"email\":\"teste071638i5e3@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071638da2f\",\"funcao\":1,\"status_usuario\":1}}', 51, 'success'),
(154, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071638i5e3@teste.com | registro: 654321', NULL, 'error'),
(155, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(156, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(157, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":52,\"email\":\"teste071640ijsl@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071640gjjj\",\"funcao\":1,\"status_usuario\":1}}', 52, 'success'),
(158, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(159, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071640ijsl@teste.com | registro: 654321', NULL, 'error'),
(160, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":53,\"email\":\"teste071701wukh@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR0717019bar\",\"funcao\":1,\"status_usuario\":1}}', 53, 'success'),
(161, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(162, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071701wukh@teste.com | registro: 654321', NULL, 'error'),
(163, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":54,\"email\":\"teste071704w2cw@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071704x3an\",\"funcao\":1,\"status_usuario\":1}}', 54, 'success'),
(164, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(165, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071704w2cw@teste.com | registro: 654321', NULL, 'error'),
(166, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":55,\"email\":\"teste071706fjpv@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071706xfvg\",\"funcao\":1,\"status_usuario\":1}}', 55, 'success'),
(167, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(168, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071706fjpv@teste.com | registro: 654321', NULL, 'error'),
(169, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":56,\"email\":\"teste071707jhkr@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR0717075ljf\",\"funcao\":1,\"status_usuario\":1}}', 56, 'success'),
(170, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071707jhkr@teste.com | registro: 654321', NULL, 'error'),
(171, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(172, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":57,\"email\":\"teste071707wvv3@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071707dr0i\",\"funcao\":1,\"status_usuario\":1}}', 57, 'success'),
(173, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071707wvv3@teste.com | registro: 654321', NULL, 'error'),
(174, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(175, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":58,\"email\":\"teste071708pj0r@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071708awmg\",\"funcao\":1,\"status_usuario\":1}}', 58, 'success'),
(176, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(177, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071708pj0r@teste.com | registro: 654321', NULL, 'error'),
(178, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":59,\"email\":\"teste071708ztvi@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR07170805ts\",\"funcao\":1,\"status_usuario\":1}}', 59, 'success'),
(179, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(180, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071708ztvi@teste.com | registro: 654321', NULL, 'error'),
(181, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":60,\"email\":\"teste0717109ogm@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071710u77t\",\"funcao\":1,\"status_usuario\":1}}', 60, 'success'),
(182, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(183, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste0717109ogm@teste.com | registro: 654321', NULL, 'error'),
(184, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":61,\"email\":\"teste071711fhfj@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071711eknt\",\"funcao\":1,\"status_usuario\":1}}', 61, 'success'),
(185, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(186, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071711fhfj@teste.com | registro: 654321', NULL, 'error'),
(187, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":62,\"email\":\"teste07171133q7@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071711cejo\",\"funcao\":1,\"status_usuario\":1}}', 62, 'success'),
(188, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(189, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste07171133q7@teste.com | registro: 654321', NULL, 'error'),
(190, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":63,\"email\":\"teste071713b77k@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071713q8gs\",\"funcao\":1,\"status_usuario\":1}}', 63, 'success'),
(191, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(192, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste071713b77k@teste.com | registro: 654321', NULL, 'error'),
(193, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":64,\"email\":\"teste0717154gra@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071715w5p6\",\"funcao\":1,\"status_usuario\":1}}', 64, 'success'),
(194, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(195, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste0717154gra@teste.com | registro: 654321', NULL, 'error'),
(196, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":65,\"email\":\"teste0717169pwi@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071716crp9\",\"funcao\":1,\"status_usuario\":1}}', 65, 'success'),
(197, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(198, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste0717169pwi@teste.com | registro: 654321', NULL, 'error'),
(199, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":66,\"email\":\"teste0717195gy0@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR0717197c15\",\"funcao\":1,\"status_usuario\":1}}', 66, 'success'),
(200, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error'),
(201, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste0717195gy0@teste.com | registro: 654321', NULL, 'error'),
(202, 'auth/create', 'Usuário criado com sucesso! {\"user\":{\"id\":67,\"email\":\"teste07172083lu@teste.com\",\"nome\":\"Novo\",\"sobrenome\":\"Usuario\",\"nascimento\":\"1990-01-01T00:00:00.000Z\",\"registro\":\"GRR071720f053\",\"funcao\":1,\"status_usuario\":1}}', 67, 'success'),
(203, 'auth/create', '400 - Erro - Motivo: Email já cadastrado para outro usuário! | email: teste07172083lu@teste.com | registro: 654321', NULL, 'error'),
(204, 'sendEmail', 'Erro durante a verificação de novos registros Error: Encoding not recognized: \'cesu8\' (searched as: \'cesu8\')', NULL, 'error');

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
(4, 26, '26', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR0715267yzm', 1),
(5, 27, '27', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071538h3rk', 1),
(6, 28, '28', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR0715410g2a', 1),
(7, 29, '29', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071546dpd6', 1),
(8, 30, '30', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071548czmu', 1),
(9, 31, '31', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR0715508t55', 1),
(10, 32, '32', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071552hy63', 1),
(11, 33, '33', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071553mb52', 1),
(12, 34, '34', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071553h22k', 1),
(13, 35, '35', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071556gzng', 1),
(14, 36, '36', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071557urm8', 1),
(15, 37, '37', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071559gi8q', 1),
(16, 38, '38', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071559nxn0', 1),
(17, 39, '39', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR0716046k9j', 1),
(18, 40, '40', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071608aqmd', 1),
(19, 41, '41', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071613q8t5', 1),
(20, 42, '42', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR0716140mk2', 1),
(21, 43, '43', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071615qchr', 1),
(22, 44, '44', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR0716175xa9', 1),
(23, 45, '45', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR0716247z50', 1),
(24, 46, '46', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071626ggo2', 1),
(25, 47, '47', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR0716285z2n', 1),
(26, 48, '48', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR0716295xdz', 1),
(27, 49, '49', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR0716296w0n', 1),
(28, 50, '50', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR0716317f2c', 1),
(29, 51, '51', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071638da2f', 1),
(30, 52, '52', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071640gjjj', 1),
(31, 53, '53', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR0717019bar', 1),
(32, 54, '54', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071704x3an', 1),
(33, 55, '55', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071706xfvg', 1),
(34, 56, '56', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR0717075ljf', 1),
(35, 57, '57', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071707dr0i', 1),
(36, 58, '58', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071708awmg', 1),
(37, 59, '59', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR07170805ts', 1),
(38, 60, '60', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071710u77t', 1),
(39, 61, '61', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071711eknt', 1),
(40, 62, '62', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071711cejo', 1),
(41, 63, '63', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071713q8gs', 1),
(42, 64, '64', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071715w5p6', 1),
(43, 65, '65', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071716crp9', 1),
(44, 66, '66', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR0717197c15', 1),
(45, 67, '67', 'Bem vindo(a) à secretaria online do SEPT!', 'Sua conta foi registrada com sucesso e atrelada ao registro GRR071720f053', 1);

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

-- --------------------------------------------------------

--
-- Table structure for table `tipo_solicitacao`
--

CREATE TABLE `tipo_solicitacao` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `fluxograma` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(26, 'teste071526myht@teste.com', '$2a$10$ECk2PavJg4EkyPniK2aGWOQ6qOKjxGIg4WrxV42XJ0tVXHl8T7mXK', 'GRR0715267yzm', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 18:26:32', 1, '', 1, NULL, 1),
(27, 'teste071538giql@teste.com', '$2a$10$8Wn3wIhJ.gfMcP8QjCoVQu9ugS/Votfv.vbBatv/nNKWBob6yrOyS', 'GRR071538h3rk', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 18:38:22', 1, '', 1, NULL, 1),
(28, 'teste071541z9g4@teste.com', '$2a$10$iZ5Qc0NXVLAxZe6yDfzRAuiSBHDedYa.AASEivlF.bqMASEM0oADe', 'GRR0715410g2a', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 18:41:47', 1, '', 1, NULL, 1),
(29, 'teste071546engp@teste.com', '$2a$10$P22d5z82Kk/K9L6BBsy6keSyNbfcXJlOIXKFdvvFtsNvLX1rFDAN.', 'GRR071546dpd6', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 18:46:57', 1, '', 1, NULL, 1),
(30, 'teste071548fdvy@teste.com', '$2a$10$jeiGhMeRMWemfd5el7.ftuE02f.T2EXkQn.QGtRCjqWJlgBjLi1c6', 'GRR071548czmu', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 18:48:31', 1, '', 1, NULL, 1),
(31, 'teste071550qjeb@teste.com', '$2a$10$9iKrl7jawPyPbxeV.bM6XOMBceiXOdhN3A88DHh.v4t68f5aIV0xW', 'GRR0715508t55', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 18:50:31', 1, '', 1, NULL, 1),
(32, 'teste0715524h9e@teste.com', '$2a$10$wgucvvcfPL9gTGC/5D.3seN5NlLlefq9gwvDu3LlMKzUl.KCy20vC', 'GRR071552hy63', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 18:52:03', 1, '', 1, NULL, 1),
(33, 'teste071553gk9s@teste.com', '$2a$10$lOOJ6TRAgwt..PjfDv8.VuB09MwdFkg3J1Tz2Sg6XJvkeCdcKN49.', 'GRR071553mb52', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 18:53:32', 1, '', 1, NULL, 1),
(34, 'teste0715533xx5@teste.com', '$2a$10$lsqnvQUMLMASXKJFmbufJ.tnddNuFoU9MWY0yXy9xyaDr8ksMWCJm', 'GRR071553h22k', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 18:53:44', 1, '', 1, NULL, 1),
(35, 'teste071556xd5v@teste.com', '$2a$10$KrBQL9qKGXI9cAqJ2MXsy.QXHz.YQykJtsJlao6NBkcyDahWSLRzi', 'GRR071556gzng', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 18:56:32', 1, '', 1, NULL, 1),
(36, 'teste071557qf8k@teste.com', '$2a$10$/GfbUmLRXgxD05IFC8ZlN.W.2MFeZFVI6V3yBT9n3m3DlvUmAAxbu', 'GRR071557urm8', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 18:57:18', 1, '', 1, NULL, 1),
(37, 'teste071559xhs6@teste.com', '$2a$10$plDjwisXt29r6/SRSVt3J.RPwo/pd2kM9bmu6IA2J30UcFeLWKsAu', 'GRR071559gi8q', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 18:59:22', 1, '', 1, NULL, 1),
(38, 'teste071559mnpa@teste.com', '$2a$10$Lwu1jKolQkHmXprgHfSwKuAng8wcG2ZCM0L1VyL0YBkg1n/Jm.BuK', 'GRR071559nxn0', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 18:59:45', 1, '', 1, NULL, 1),
(39, 'teste071604rmjn@teste.com', '$2a$10$yHDIj.fLf8alc5h3dkptf.Ox2g4cxgOQ2FtHW7hLjeYGkObkYqIIy', 'GRR0716046k9j', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 19:04:36', 1, '', 1, NULL, 1),
(40, 'teste071608wetz@teste.com', '$2a$10$QKAmm0hz5U/X3tqfK6YTBOAf1wf5l642qMZ2.PYggw0c5Lb4Caf16', 'GRR071608aqmd', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 19:08:52', 1, '', 1, NULL, 1),
(41, 'teste071613dgdq@teste.com', '$2a$10$mqt9oFFcLn9RJHFaxuFYDeTPt.o7STBnY7AvNdyrLNGSX8GcephHG', 'GRR071613q8t5', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 19:13:26', 1, '', 1, NULL, 1),
(42, 'teste071614vytw@teste.com', '$2a$10$JUVJkhalRB8ROCvRzcoJ6uZJvl/KzSa8jJSIjt1WJ/FOo7TaIyjI2', 'GRR0716140mk2', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 19:14:52', 1, '', 1, NULL, 1),
(43, 'teste071615i1xb@teste.com', '$2a$10$WzNc/0QBVgLgP7sgs6EK/uCMUMI7GEfd/cs3uahZET3xBRU1AcyQu', 'GRR071615qchr', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 19:15:13', 1, '', 1, NULL, 1),
(44, 'teste071617sudn@teste.com', '$2a$10$qEJbknZeoGq/NbDYDGnJ6eUXX8rXLcdBX5AIYJ..G1.5H9ljhk3kK', 'GRR0716175xa9', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 19:17:34', 1, '', 1, NULL, 1),
(45, 'teste0716244439@teste.com', '$2a$10$PeE1fHkdRhC5lzoo5Nc7veXD2Yd2EVmb5Wco.ASHVZfG58CRYKmGe', 'GRR0716247z50', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 19:24:48', 1, '', 1, NULL, 1),
(46, 'teste071626zm0e@teste.com', '$2a$10$tJHduTwyMDh/CqScC5332uTVw1p59G6RgJIhA9ik2Oqa8mfgVea6C', 'GRR071626ggo2', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 19:26:23', 1, '', 1, NULL, 1),
(47, 'teste0716289pn9@teste.com', '$2a$10$ciTdKX6OFIIJXKuSLU5r0.5ikRUZiXUVaHnkBZAfc9nes0tf3Z0WK', 'GRR0716285z2n', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 19:28:38', 1, '', 1, NULL, 1),
(48, 'teste071629mjyz@teste.com', '$2a$10$YGAkXdAnHutgNcHNri8Og./Oqz53DCC4esQybEvRkBYvc0U6Q3yL2', 'GRR0716295xdz', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 19:29:06', 1, '', 1, NULL, 1),
(49, 'teste071629d1xn@teste.com', '$2a$10$Klnm.rPctWibdRznu/Y7X.7JezJESO2SYK0Ao.pydZAY/87YyS6da', 'GRR0716296w0n', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 19:29:32', 1, '', 1, NULL, 1),
(50, 'teste07163176au@teste.com', '$2a$10$dF9BZEze7qSYq3hiik8QJe8rWGBu0zUZ4eyVPFeb3J0uzPakT8RCq', 'GRR0716317f2c', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 19:31:34', 1, '', 1, NULL, 1),
(51, 'teste071638i5e3@teste.com', '$2a$10$CtveV0mUmbMSj4m9MwymAuZYCOUsFsRbEhiBYmtfz0OmVK1OH7e0u', 'GRR071638da2f', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 19:38:25', 1, '', 1, NULL, 1),
(52, 'teste071640ijsl@teste.com', '$2a$10$KjX2MY7KaRC7/o3siShASeCxQL0mYAsGsRvOot0k1kkDYurpXXyuC', 'GRR071640gjjj', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 19:40:06', 1, '', 1, NULL, 1),
(53, 'teste071701wukh@teste.com', '$2a$10$deXDuC0x8bdt2dJ17zCsF.xW5kR47F44qtQbB4BhRLFa3USc79NoW', 'GRR0717019bar', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:01:14', 1, '', 1, NULL, 1),
(54, 'teste071704w2cw@teste.com', '$2a$10$weCOAoWZxQa/4GIa1pAWduGZewCPcXwUTxPrmkvYZny1mmM/VSL7K', 'GRR071704x3an', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:04:16', 1, '', 1, NULL, 1),
(55, 'teste071706fjpv@teste.com', '$2a$10$qQ6wkLQ4BGEXlyoDoeF/h.5iDiDUspYdEmDq0UGHGZ3uOpycvDRjy', 'GRR071706xfvg', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:06:59', 1, '', 1, NULL, 1),
(56, 'teste071707jhkr@teste.com', '$2a$10$pT.V1mI59y45X.yGKZobcuw690bkzpt4s7JYjSKhwUzSTp3H1rGvm', 'GRR0717075ljf', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:07:19', 1, '', 1, NULL, 1),
(57, 'teste071707wvv3@teste.com', '$2a$10$NwIxOJTNNBVIFtFZrKRZWuB8EkOoulnzFvPRwFEOBrA/TR8hWxOUm', 'GRR071707dr0i', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:07:48', 1, '', 1, NULL, 1),
(58, 'teste071708pj0r@teste.com', '$2a$10$Nbi0a67m3icTypSR4wQCUuTHTG2M0ilpKml/581Dc4DmhJbbdX7lu', 'GRR071708awmg', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:08:21', 1, '', 1, NULL, 1),
(59, 'teste071708ztvi@teste.com', '$2a$10$YKA3Sb.kr7dGcAyxyf7ryuO6q8eOl08ZZfYkfuBqe32UucOYLJMxe', 'GRR07170805ts', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:08:37', 1, '', 1, NULL, 1),
(60, 'teste0717109ogm@teste.com', '$2a$10$IZolw29fRMHqsxeoDGhfteyIKzCIftOhnwdd9UdE7lqot..keXJmK', 'GRR071710u77t', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:10:28', 1, '', 1, NULL, 1),
(61, 'teste071711fhfj@teste.com', '$2a$10$qE.h.R4ndeEbd37oMyrDEOz5EulvEFDNpRUf5ZNv1xuAxCtOhfN8m', 'GRR071711eknt', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:11:13', 1, '', 1, NULL, 1),
(62, 'teste07171133q7@teste.com', '$2a$10$46GWmKqJJpbPmsaSWkIwb.cH6Z4IjztTJFYgwYmFHPyiCRRYlA80G', 'GRR071711cejo', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:11:28', 1, '', 1, NULL, 1),
(63, 'teste071713b77k@teste.com', '$2a$10$S6WgEgUQ0Zq3ExMR05kDoOZAaTZTA9Oub36qFi6dxcEfuP74CMS5W', 'GRR071713q8gs', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:13:13', 1, '', 1, NULL, 1),
(64, 'teste0717154gra@teste.com', '$2a$10$ILuKZUpZLf75Dt1XhkiLg..yPHVPckBHdrzg/eU.8qOpcE6pvuE0.', 'GRR071715w5p6', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:15:21', 1, '', 1, NULL, 1),
(65, 'teste0717169pwi@teste.com', '$2a$10$VyHQ.23RxVr.FcAKKWWYRuWoCS8w3GYZ6BifkLY0rgO4Hgc1ccvGS', 'GRR071716crp9', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:16:41', 1, '', 1, NULL, 1),
(66, 'teste0717195gy0@teste.com', '$2a$10$xONFpa.PUidhj644OxBT6uuWDhH6lnjbdUKr7noWlxGx7HwOtbVke', 'GRR0717197c15', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:19:33', 1, '', 1, NULL, 1),
(67, 'teste07172083lu@teste.com', '$2a$10$MQaoeaTfZrMgywZowlCSCu/b1X.aQFT8Crg1TPRncP54UzoaYgoTm', 'GRR071720f053', 'Novo', 'Usuario', '1990-01-01', '2024-11-07 20:20:36', 1, '', 1, NULL, 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `horas_formativas`
--
ALTER TABLE `horas_formativas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `logins`
--
ALTER TABLE `logins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=205;

--
-- AUTO_INCREMENT for table `mural`
--
ALTER TABLE `mural`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `tipos_campos`
--
ALTER TABLE `tipos_campos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipo_solicitacao`
--
ALTER TABLE `tipo_solicitacao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

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
