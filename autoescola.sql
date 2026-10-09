-- phpMyAdmin SQL Dump
-- version 6.0.0-dev+20261008.cdc90e2a8d
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 09, 2026 at 02:31 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `autoescola`
--

-- --------------------------------------------------------

--
-- Table structure for table `alunos`
--
CREATE TABLE `alunos` (
  `id` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `data_nascimento` date NOT NULL,
  `data_cadastro` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `alunos`
--

INSERT INTO `alunos` (`id`, `nome`, `email`, `telefone`, `data_nascimento`, `data_cadastro`) VALUES
(1, 'Maria Oliveira', 'maria.oliveira@example.com', '11987654321', '2000-05-15', '2026-10-09 12:47:39'),
(2, 'João Silva', 'joao.silva@example.com', '11923456789', '1995-08-25', '2026-10-09 12:47:39'),
(3, 'Ana Costa', 'ana.costa@example.com', '11934567890', '1990-12-10', '2026-10-09 12:47:39'),
(4, 'Anna Teste', 'anna.teste@examplo.com', '12987654321', '2009-10-15', '2026-10-09 14:02:54'),
(5, 'Annao Teste', 'teeeesste2@email.com', '12391938192', '2009-10-15', '2026-10-09 14:20:43'),
(6, 'Lucas Alunao', 'lucastestealuno@example.com', '12391938144', '1886-07-07', '2026-10-09 14:22:45');

-- --------------------------------------------------------

--
-- Table structure for table `aulas`
--
CREATE TABLE `aulas` (
  `id` int NOT NULL,
  `data_aula` datetime NOT NULL,
  `aluno_id` int NOT NULL,
  `instrutor_id` int NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `observacoes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `aulas`
--

INSERT INTO `aulas` (`id`, `data_aula`, `aluno_id`, `instrutor_id`, `tipo`, `observacoes`) VALUES
(1, '2024-09-05 10:00:00', 1, 1, 'prática', 'Iniciar com manobras básicas.'),
(2, '2024-09-06 14:00:00', 2, 2, 'teórica', 'Revisão das regras de trânsito.'),
(3, '2024-09-07 09:00:00', 3, 3, 'prática', 'Aula de estacionamento e baliza.');

-- --------------------------------------------------------

--
-- Table structure for table `instrutores`
--
CREATE TABLE `instrutores` (
  `id` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `categoria_cnh` varchar(50) NOT NULL,
  `data_cadastro` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `instrutores`
--

INSERT INTO `instrutores` (`id`, `nome`, `email`, `telefone`, `categoria_cnh`, `data_cadastro`) VALUES
(1, 'Carlos Santos', 'carlos.santos@example.com', '11912345678', 'Categoria B', '2026-10-09 12:47:39'),
(2, 'Fernanda Lima', 'fernanda.lima@example.com', '11987654321', 'Categoria A', '2026-10-09 12:47:39'),
(3, 'Roberto Almeida', 'roberto.almeida@example.com', '11911223344', 'Categoria C', '2026-10-09 12:47:39'),
(4, 'Lucas Teste', 'lucas.teste@example.com', '11988887777', 'Categoria B', '2026-10-09 14:08:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alunos`
--
ALTER TABLE `alunos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `aulas`
--
ALTER TABLE `aulas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aluno_id` (`aluno_id`),
  ADD KEY `instrutor_id` (`instrutor_id`);

--
-- Indexes for table `instrutores`
--
ALTER TABLE `instrutores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alunos`
--
ALTER TABLE `alunos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `aulas`
--
ALTER TABLE `aulas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `instrutores`
--
ALTER TABLE `instrutores`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `aulas`
--
ALTER TABLE `aulas`
  ADD CONSTRAINT `aulas_ibfk_1` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`),
  ADD CONSTRAINT `aulas_ibfk_2` FOREIGN KEY (`instrutor_id`) REFERENCES `instrutores` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
