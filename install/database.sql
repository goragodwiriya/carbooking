-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 24, 2026 at 12:27 PM
-- Server version: 10.4.34-MariaDB
-- PHP Version: 7.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_car_reservation`
--

CREATE TABLE `{prefix}_car_reservation` (
  `id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `department` varchar(10) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `detail` text NOT NULL,
  `chauffeur` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `travelers` int(11) NOT NULL,
  `begin` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `reason` text DEFAULT NULL,
  `approve` tinyint(1) NOT NULL,
  `closed` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_car_reservation_data`
--

CREATE TABLE `{prefix}_car_reservation_data` (
  `reservation_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `value` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_category`
--

CREATE TABLE `{prefix}_category` (
  `type` varchar(20) NOT NULL,
  `category_id` varchar(10) DEFAULT '0',
  `language` varchar(2) DEFAULT '',
  `topic` varchar(150) NOT NULL,
  `color` varchar(16) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `{prefix}_category`
--

INSERT INTO `{prefix}_category` (`type`, `category_id`, `language`, `topic`, `color`, `is_active`) VALUES
('department', '2', '', 'ไม่ทราบ', NULL, 1),
('department', '1', '', 'ยานพาหนะ', NULL, 1),
('car_accessory', '2', '', 'น้ำมันเต็มถัง', NULL, 1),
('car_accessory', '1', '', 'เครื่องกระจายเสียง', NULL, 1),
('car_type', '7', '', 'รถตู้', NULL, 1),
('car_type', '6', '', 'รถบรรทุก 10 ล้อ', NULL, 1),
('car_type', '5', '', 'รถบรรทุกเล็ก 6 ล้อ', NULL, 1),
('car_brand', '6', '', 'Chevtolet', NULL, 1),
('car_brand', '5', '', 'Mazda', NULL, 1),
('car_brand', '4', '', 'Nissan', NULL, 1),
('car_brand', '3', '', 'Misubishi', NULL, 1),
('car_brand', '2', '', 'Honda', NULL, 1),
('car_brand', '12', '', 'GM', NULL, 1),
('car_type', '4', '', 'รถกระบะบรรทุก', NULL, 1),
('car_brand', '11', '', 'Hino', NULL, 1),
('car_type', '3', '', 'รถกระบะ CAB 4 ประตู', NULL, 1),
('car_brand', '10', '', 'Volvo', NULL, 1),
('car_brand', '1', '', 'Toyota', NULL, 1),
('car_type', '2', '', 'รถกระบะ CAB 2 ประตู', NULL, 1),
('car_type', '1', '', 'รถเก๋ง', NULL, 1),
('car_brand', '7', '', 'Bmw', NULL, 1),
('car_brand', '8', '', 'Benz', NULL, 1),
('car_brand', '9', '', 'Ford', NULL, 1),
('car_type', '8', '', 'รถมินิบัส', NULL, 1),
('car_type', '9', '', 'รถบัส', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_language`
--

CREATE TABLE `{prefix}_language` (
  `id` int(11) NOT NULL,
  `key` text NOT NULL,
  `type` varchar(5) NOT NULL,
  `th` text DEFAULT NULL,
  `en` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_logs`
--

CREATE TABLE `{prefix}_logs` (
  `id` int(11) NOT NULL,
  `src_id` int(11) NOT NULL,
  `module` varchar(20) NOT NULL,
  `action` varchar(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `reason` text DEFAULT NULL,
  `member_id` int(11) NOT NULL,
  `topic` text NOT NULL,
  `datas` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_user`
--

CREATE TABLE `{prefix}_user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `salt` varchar(32) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL,
  `token` varchar(512) DEFAULT NULL,
  `token_expires` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `permission` text DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `id_card` varchar(13) DEFAULT NULL,
  `tax_id` varchar(13) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `address` varchar(64) DEFAULT NULL,
  `address2` varchar(64) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `phone1` varchar(20) DEFAULT NULL,
  `provinceID` smallint(3) DEFAULT NULL,
  `province` varchar(64) DEFAULT NULL,
  `zipcode` varchar(5) DEFAULT NULL,
  `country` varchar(2) DEFAULT 'TH',
  `created_at` datetime DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `social` enum('user','facebook','google','line','telegram') DEFAULT 'user',
  `line_uid` varchar(33) DEFAULT NULL,
  `telegram_id` varchar(20) DEFAULT NULL,
  `activatecode` varchar(64) DEFAULT NULL,
  `visited` int(11) NOT NULL DEFAULT 0,
  `website` varchar(255) DEFAULT NULL,
  `company` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_user_meta`
--

CREATE TABLE `{prefix}_user_meta` (
  `value` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `member_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_vehicles`
--

CREATE TABLE `{prefix}_vehicles` (
  `id` int(11) NOT NULL,
  `number` varchar(20) NOT NULL DEFAULT '',
  `color` varchar(20) NOT NULL DEFAULT '',
  `detail` text NOT NULL,
  `seats` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `{prefix}_vehicles`
--

INSERT INTO `{prefix}_vehicles` (`id`, `number`, `color`, `detail`, `seats`, `is_active`) VALUES
(1, 'นม 6', '#304FFE', 'พร้อมเครื่องเสียงชุดใหญ่', 50, 1),
(2, 'บจ 888', '#4A148C', '', 13, 1),
(3, 'กข 1234', '#B71C1C', '', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_vehicles_meta`
--

CREATE TABLE `{prefix}_vehicles_meta` (
  `vehicle_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `value` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `{prefix}_vehicles_meta`
--

INSERT INTO `{prefix}_vehicles_meta` (`vehicle_id`, `name`, `value`) VALUES
(1, 'car_brand', '1'),
(1, 'car_type', '8'),
(2, 'car_brand', '2'),
(2, 'car_type', '7'),
(3, 'car_brand', '1'),
(3, 'car_type', '3');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `{prefix}_car_reservation`
--
ALTER TABLE `{prefix}_car_reservation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_vehicle_availability` (`vehicle_id`,`status`,`approve`,`begin`,`end`),
  ADD KEY `member_id` (`member_id`,`created_at`);

--
-- Indexes for table `{prefix}_car_reservation_data`
--
ALTER TABLE `{prefix}_car_reservation_data`
  ADD UNIQUE KEY `idx_reservation` (`reservation_id`,`name`) USING BTREE;

--
-- Indexes for table `{prefix}_category`
--
ALTER TABLE `{prefix}_category`
  ADD KEY `type` (`type`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `language` (`language`);

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
  ADD KEY `action` (`action`),
  ADD KEY `created_at` (`created_at`);

--
-- Indexes for table `{prefix}_user`
--
ALTER TABLE `{prefix}_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `id_card` (`id_card`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `token` (`token`) USING HASH,
  ADD KEY `activatecode` (`activatecode`),
  ADD KEY `line_uid` (`line_uid`),
  ADD KEY `telegram_id` (`telegram_id`),
  ADD KEY `idx_status` (`active`,`status`);

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
  ADD KEY `idx_vehicle_meta` (`vehicle_id`,`name`) USING BTREE;

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
