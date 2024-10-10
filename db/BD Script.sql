-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 10, 2024 at 08:11 PM
-- Server version: 10.6.18-MariaDB-0ubuntu0.22.04.1
-- PHP Version: 7.4.33

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
(1, 'i0f0A5OiSTqfjjJ', 'perussilucas@hotmail.com', 'Bem-vindo(a) à secretaria online do SEPT!', 1, 'Este é um teste!', '200', '2024-10-10 20:05:21', NULL, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fila_emails`
--
ALTER TABLE `fila_emails`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fila_emails`
--
ALTER TABLE `fila_emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
