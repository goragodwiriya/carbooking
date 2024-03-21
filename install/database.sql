-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 02, 2024 at 08:26 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 7.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_car_reservation`
--

CREATE TABLE `{prefix}_car_reservation` (
  `id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `department` varchar(10) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `detail` text DEFAULT NULL,
  `chauffeur` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `travelers` int(11) NOT NULL,
  `begin` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `reason` text DEFAULT NULL,
  `approve` tinyint(1) NOT NULL,
  `closed` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_car_reservation_data`
--

CREATE TABLE `{prefix}_car_reservation_data` (
  `reservation_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `value` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_category`
--

CREATE TABLE `{prefix}_category` (
  `type` varchar(20) NOT NULL,
  `category_id` varchar(10) DEFAULT '0',
  `topic` varchar(150) NOT NULL,
  `color` varchar(16) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `{prefix}_category`
--

INSERT INTO `{prefix}_category` (`type`, `category_id`, `topic`, `color`, `published`) VALUES
('department', '1', 'อนุมัติรถ', NULL, 1),
('department', '2', 'จัดซื้อจัดจ้าง', NULL, 1),
('department', '3', 'บุคคล', NULL, 1),
('car_accessories', '2', 'น้ำมันเต็มถัง', NULL, 1),
('car_accessories', '1', 'เครื่องกระจายเสียง', NULL, 1),
('car_type', '9', 'รถบัส', NULL, 1),
('car_type', '6', 'รถบรรทุก 10 ล้อ', NULL, 1),
('car_type', '5', 'รถบรรทุกเล็ก 6 ล้อ', NULL, 1),
('car_type', '7', 'รถตู้', NULL, 1),
('car_brand', '10', 'Volvo', NULL, 1),
('car_brand', '1', 'Toyota', NULL, 1),
('car_brand', '4', 'Nissan', NULL, 1),
('car_brand', '3', 'Misubishi', NULL, 1),
('car_brand', '5', 'Mazda', NULL, 1),
('car_brand', '2', 'Honda', NULL, 1),
('car_brand', '11', 'Hino', NULL, 1),
('car_brand', '9', 'Ford', NULL, 1),
('car_type', '4', 'รถกระบะบรรทุก', NULL, 1),
('car_brand', '12', 'GM', NULL, 1),
('car_type', '3', 'รถกระบะ CAB 4 ประตู', NULL, 1),
('car_brand', '6', 'Chevtolet', NULL, 1),
('car_brand', '7', 'Bmw', NULL, 1),
('car_type', '2', 'รถกระบะ CAB 2 ประตู', NULL, 1),
('car_brand', '8', 'Benz', NULL, 1),
('car_type', '8', 'รถมินิบัส', NULL, 1),
('car_type', '1', 'รถเก๋ง', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_language`
--

CREATE TABLE `{prefix}_language` (
  `id` int(11) NOT NULL,
  `key` text NOT NULL,
  `type` varchar(5) NOT NULL,
  `owner` varchar(20) NOT NULL,
  `js` tinyint(1) NOT NULL,
  `th` text DEFAULT NULL,
  `en` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_logs`
--

CREATE TABLE `{prefix}_logs` (
  `id` int(11) NOT NULL,
  `src_id` int(11) NOT NULL,
  `module` varchar(20) NOT NULL,
  `action` varchar(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `reason` text DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  `topic` text NOT NULL,
  `datas` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_user`
--

CREATE TABLE `{prefix}_user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `salt` varchar(32) NOT NULL,
  `password` varchar(50) NOT NULL,
  `token` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `permission` text NOT NULL,
  `name` varchar(150) NOT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `id_card` varchar(13) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `provinceID` varchar(3) DEFAULT NULL,
  `province` varchar(50) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `country` varchar(2) DEFAULT 'TH',
  `create_date` datetime DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `social` tinyint(1) DEFAULT 0,
  `line_uid` varchar(33) DEFAULT NULL,
  `activatecode` varchar(32) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_user_meta`
--

CREATE TABLE `{prefix}_user_meta` (
  `value` varchar(10) NOT NULL,
  `name` varchar(10) NOT NULL,
  `member_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_vehicles`
--

CREATE TABLE `{prefix}_vehicles` (
  `id` int(11) NOT NULL,
  `number` varchar(20) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `detail` text DEFAULT NULL,
  `published` int(1) NOT NULL DEFAULT 1,
  `seats` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `{prefix}_vehicles`
--

INSERT INTO `{prefix}_vehicles` (`id`, `number`, `color`, `detail`, `published`, `seats`) VALUES
(1, 'นม 6', '#304FFE', 'พร้อมเครื่องเสียงชุดใหญ่', 1, 50),
(2, 'บจ 888', '#4A148C', '', 1, 13),
(3, 'กข 1234', '#B71C1C', '', 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_vehicles_meta`
--

CREATE TABLE `{prefix}_vehicles_meta` (
  `vehicle_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `value` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `{prefix}_vehicles_meta`
--

INSERT INTO `{prefix}_vehicles_meta` (`vehicle_id`, `name`, `value`) VALUES
(2, 'car_brand', '2'),
(2, 'car_type', '7'),
(1, 'car_brand', '8'),
(1, 'car_type', '9'),
(3, 'car_brand', '12'),
(3, 'car_type', '3');

-- --------------------------------------------------------

--
-- Indexes for table `{prefix}_car_reservation`
--
ALTER TABLE `{prefix}_car_reservation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `{prefix}_car_reservation_data`
--
ALTER TABLE `{prefix}_car_reservation_data`
  ADD KEY `reservation_id` (`reservation_id`) USING BTREE;

--
-- Indexes for table `{prefix}_category`
--
ALTER TABLE `{prefix}_category`
  ADD KEY `type` (`type`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `{prefix}_language`
--
ALTER TABLE `{prefix}_language`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `{prefix}_logs`
--
ALTER TABLE `{prefix}_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `src_id` (`src_id`),
  ADD KEY `module` (`module`),
  ADD KEY `action` (`action`);

--
-- Indexes for table `{prefix}_user`
--
ALTER TABLE `{prefix}_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `line_uid` (`line_uid`),
  ADD KEY `username` (`username`),
  ADD KEY `token` (`token`),
  ADD KEY `phone` (`phone`),
  ADD KEY `id_card` (`id_card`),
  ADD KEY `activatecode` (`activatecode`);

--
-- Indexes for table `{prefix}_user_meta`
--
ALTER TABLE `{prefix}_user_meta`
  ADD KEY `member_id` (`member_id`,`name`);

--
-- Indexes for table `{prefix}_vehicles`
--
ALTER TABLE `{prefix}_vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `{prefix}_vehicles_meta`
--
ALTER TABLE `{prefix}_vehicles_meta`
  ADD KEY `vehicle_id` (`vehicle_id`);

--
-- AUTO_INCREMENT for table `{prefix}_car_reservation`
--
ALTER TABLE `{prefix}_car_reservation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `{prefix}_language`
--
ALTER TABLE `{prefix}_language`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `{prefix}_logs`
--
ALTER TABLE `{prefix}_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `{prefix}_user`
--
ALTER TABLE `{prefix}_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `{prefix}_vehicles`
--
ALTER TABLE `{prefix}_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
