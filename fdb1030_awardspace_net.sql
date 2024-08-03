-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: fdb1030.awardspace.net
-- Generation Time: Aug 03, 2024 at 06:22 PM
-- Server version: 8.0.32
-- PHP Version: 8.1.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `4508142_mbproject`
--
CREATE DATABASE IF NOT EXISTS `4508142_mbproject` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `4508142_mbproject`;

-- --------------------------------------------------------

--
-- Table structure for table `Notes`
--

CREATE TABLE `Notes` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `modified_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Notes`
--

INSERT INTO `Notes` (`id`, `user_id`, `title`, `content`, `modified_time`) VALUES
(9, 2, '2nd one', 'edited now', '2024-08-03 01:28:54'),
(10, 2, 'title 2', 'something is added here', '2024-08-03 01:28:40'),
(13, 3, 'task added', 'now and updated', '2024-08-03 02:52:26'),
(15, 3, '', 'not titled', '2024-08-03 02:52:37'),
(17, 9, 'note 1', '', '2024-08-03 02:54:30'),
(21, 10, 'hellooo', 'miss you', '2024-08-03 12:52:38'),
(22, 10, 'ishf', '', '2024-08-03 12:39:56'),
(26, 1, 'note 2', 'aade', '2024-08-03 17:52:49');

-- --------------------------------------------------------

--
-- Table structure for table `ToDos`
--

CREATE TABLE `ToDos` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `todo_text` varchar(255) NOT NULL,
  `is_done` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `ToDos`
--

INSERT INTO `ToDos` (`id`, `user_id`, `todo_text`, `is_done`) VALUES
(6, 2, '2nd task', 0),
(7, 1, 'also final taskkkkkkkkk', 1),
(12, 10, 'hiii', 0),
(13, 10, 'nasilsin', 0),
(17, 1, 'a new', 0);

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`id`, `username`, `password_hash`) VALUES
(1, 'israa2', '$2y$10$LS6/XcxV77xj4EDstupAzu3Vvlu/Bm.O6CZSP6HRDYDOhiz.04dkG'),
(2, 'israa3', '$2y$10$pLAjA8J509seenLYgGPpeed6YD5QKngW5pIxeJetvajRlEv/GvwBq'),
(3, 'israa4', '$2y$10$vo.IKzuAEfxnp5MapxaXcOIAtyDLSLbRyIlZCU4AQm3lhtTLBomB6'),
(4, 'israa5', '$2y$10$WIRArICAaP.lLimB5BKJxeDFIfuh5pCWI7uKQotsXjvAxUuMkPf5O'),
(5, 'israa6', '$2y$10$9efuqUTptpmBAhPgqWQH4OC/LzJNAfK0h66wtB5IcaHTTrJnKoaF2'),
(6, 'israa7', '$2y$10$w2QBUG4KCZz9TMb3URyGE.gANo3HVzfqXhZcwL7Yg2wX7bcSh0/Yy'),
(7, 'israafinal', '$2y$10$jPOE8RgQDANE2rvKQBUXMuXtErvdscGvJ0hGIJu95SYz9RV8kLNHq'),
(8, 'israatest1', '$2y$10$az0z5Zr/16MTCJCUNcoRN.703z6efgNn/PlPF9ffkLIgggPu5kAGq'),
(9, 'israatest2', '$2y$10$cGd8eR.HVaaHRMAa/YtlhezjwpgH.y/tDa/SkuEsnw9PHHvEjAFB.'),
(10, 'shaimaa', '$2y$10$DSYDwJU0U74wxTEVBxMSkul0ZtKdXSjFabOAfRohAmrMCyzfriOeC'),
(11, 'israa', '$2y$10$rdRUmDBeEAVKsy7yhRB9IOt4KkdG1ot/ZsOSMb9Ztryiqnr4LYlbW');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Notes`
--
ALTER TABLE `Notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `ToDos`
--
ALTER TABLE `ToDos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Notes`
--
ALTER TABLE `Notes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `ToDos`
--
ALTER TABLE `ToDos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Notes`
--
ALTER TABLE `Notes`
  ADD CONSTRAINT `Notes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

--
-- Constraints for table `ToDos`
--
ALTER TABLE `ToDos`
  ADD CONSTRAINT `ToDos_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
