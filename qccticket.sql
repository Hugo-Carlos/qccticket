-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 03, 2026 at 12:04 AM
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
-- Database: `qccticket`
--

-- --------------------------------------------------------

--
-- Table structure for table `areas`
--

CREATE TABLE `areas` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `areas`
--

INSERT INTO `areas` (`id`, `nome`, `data_criacao`) VALUES
(1, 'Redes & Sistemas', '2026-07-02 22:02:14'),
(2, 'Desenvolvimento', '2026-07-02 22:02:14');

-- --------------------------------------------------------

--
-- Table structure for table `auditoria`
--

CREATE TABLE `auditoria` (
  `id` int(11) NOT NULL,
  `id_utilizador` int(11) DEFAULT NULL,
  `acao` varchar(100) NOT NULL,
  `detalhes` text NOT NULL,
  `data_registo` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `base_conhecimento`
--

CREATE TABLE `base_conhecimento` (
  `id` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `conteudo` text NOT NULL,
  `categoria` enum('Rede','Email','Acesso','Hardware','Software') NOT NULL,
  `tipo_conteudo` enum('operacional','tecnico','basico') NOT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_atualizacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `base_conhecimento`
--

INSERT INTO `base_conhecimento` (`id`, `titulo`, `conteudo`, `categoria`, `tipo_conteudo`, `data_criacao`, `data_atualizacao`) VALUES
(1, 'Procedimento Sem Internet', '1. Verifique se o cabo de rede está conectado.\n2. Reinicie o switch local.\n3. Caso persista, contacte a equipa de Redes.', 'Rede', 'operacional', '2026-07-02 22:02:14', '2026-07-02 22:02:14'),
(2, 'Senha Bloqueada no Sistema', 'Para desbloquear o acesso às plataformas internas, utilize a opção \"Recuperar Senha\" na página de login ou solicite suporte à área administrativa.', 'Acesso', 'basico', '2026-07-02 22:02:14', '2026-07-02 22:02:14'),
(3, 'Configuração de Email Corporativo', 'Passo a passo avançado para configuração de servidores IMAP/SMTP em novos terminais de atendimento.', 'Email', 'tecnico', '2026-07-02 22:02:14', '2026-07-02 22:02:14');

-- --------------------------------------------------------

--
-- Table structure for table `comentarios`
--

CREATE TABLE `comentarios` (
  `id` int(11) NOT NULL,
  `id_ticket` int(11) NOT NULL,
  `id_utilizador` int(11) NOT NULL,
  `comentario` text NOT NULL,
  `data_envio` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `operacoes`
--

CREATE TABLE `operacoes` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `operacoes`
--

INSERT INTO `operacoes` (`id`, `nome`, `data_criacao`) VALUES
(1, 'Africell', '2026-07-02 22:02:14'),
(2, 'BAI', '2026-07-02 22:02:14'),
(3, 'ENSA', '2026-07-02 22:02:14'),
(4, 'Multichoice', '2026-07-02 22:02:14'),
(5, 'Q-EASY', '2026-07-02 22:02:14');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descricao` text NOT NULL,
  `prioridade` enum('Alta','Média','Baixa') NOT NULL,
  `estado` enum('Aberto','Em Progresso','Aguardando Utilizador','Reencaminhado','Resolvido','Fechado') DEFAULT 'Aberto',
  `anexo` varchar(255) DEFAULT NULL,
  `id_criador` int(11) NOT NULL,
  `id_operacao` int(11) DEFAULT NULL,
  `id_area_destino` int(11) NOT NULL,
  `id_tecnico_atribuido` int(11) DEFAULT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_limite_sla` datetime NOT NULL,
  `data_resolucao` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `utilizadores`
--

CREATE TABLE `utilizadores` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `perfil` enum('Admin','Diretor Geral','Responsavel','Tecnico','Comum','Cliente') NOT NULL,
  `id_area` int(11) DEFAULT NULL,
  `id_operacao` int(11) DEFAULT NULL,
  `estado` enum('Ativo','Inativo') DEFAULT 'Ativo',
  `ultimo_acesso` datetime DEFAULT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `utilizadores`
--

INSERT INTO `utilizadores` (`id`, `nome`, `email`, `username`, `password_hash`, `perfil`, `id_area`, `id_operacao`, `estado`, `ultimo_acesso`, `data_criacao`) VALUES
(1, 'Administrador Geral', 'admin@quality.co.ao', 'admin', '$2y$10$TKh8H1.PfQx37YgCzwiKb.KjNyWgaHb9cbcoQgdIVFlYg7B77UdFm', 'Admin', NULL, NULL, 'Ativo', NULL, '2026-07-02 22:02:14'),
(2, 'Carlos Vissesse', 'carlos.vissesse@quality.co.ao', 'carlos.vissesse', '$2y$10$TKh8H1.PfQx37YgCzwiKb.KjNyWgaHb9cbcoQgdIVFlYg7B77UdFm', 'Responsavel', 2, NULL, 'Ativo', NULL, '2026-07-02 22:02:14'),
(3, 'Erivaldo Guimarães', 'erivaldo.g@quality.co.ao', 'erivaldo.g', '$2y$10$TKh8H1.PfQx37YgCzwiKb.KjNyWgaHb9cbcoQgdIVFlYg7B77UdFm', 'Responsavel', 1, NULL, 'Ativo', NULL, '2026-07-02 22:02:14'),
(4, 'João Geraldo', 'joao.geraldo@quality.co.ao', 'joao.geraldo', '$2y$10$TKh8H1.PfQx37YgCzwiKb.KjNyWgaHb9cbcoQgdIVFlYg7B77UdFm', 'Tecnico', 1, NULL, 'Ativo', NULL, '2026-07-02 22:02:14'),
(5, 'Manuel Comum', 'manuel.comum@quality.co.ao', 'manuel.comum', '$2y$10$TKh8H1.PfQx37YgCzwiKb.KjNyWgaHb9cbcoQgdIVFlYg7B77UdFm', 'Comum', NULL, NULL, 'Ativo', NULL, '2026-07-02 22:02:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Indexes for table `auditoria`
--
ALTER TABLE `auditoria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_utilizador` (`id_utilizador`);

--
-- Indexes for table `base_conhecimento`
--
ALTER TABLE `base_conhecimento`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_ticket` (`id_ticket`),
  ADD KEY `id_utilizador` (`id_utilizador`);

--
-- Indexes for table `operacoes`
--
ALTER TABLE `operacoes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_criador` (`id_criador`),
  ADD KEY `id_operacao` (`id_operacao`),
  ADD KEY `id_area_destino` (`id_area_destino`),
  ADD KEY `id_tecnico_atribuido` (`id_tecnico_atribuido`);

--
-- Indexes for table `utilizadores`
--
ALTER TABLE `utilizadores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_area` (`id_area`),
  ADD KEY `id_operacao` (`id_operacao`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `areas`
--
ALTER TABLE `areas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `auditoria`
--
ALTER TABLE `auditoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `base_conhecimento`
--
ALTER TABLE `base_conhecimento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `operacoes`
--
ALTER TABLE `operacoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `utilizadores`
--
ALTER TABLE `utilizadores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auditoria`
--
ALTER TABLE `auditoria`
  ADD CONSTRAINT `auditoria_ibfk_1` FOREIGN KEY (`id_utilizador`) REFERENCES `utilizadores` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`id_ticket`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`id_utilizador`) REFERENCES `utilizadores` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`id_criador`) REFERENCES `utilizadores` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`id_operacao`) REFERENCES `operacoes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tickets_ibfk_3` FOREIGN KEY (`id_area_destino`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `tickets_ibfk_4` FOREIGN KEY (`id_tecnico_atribuido`) REFERENCES `utilizadores` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `utilizadores`
--
ALTER TABLE `utilizadores`
  ADD CONSTRAINT `utilizadores_ibfk_1` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `utilizadores_ibfk_2` FOREIGN KEY (`id_operacao`) REFERENCES `operacoes` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
