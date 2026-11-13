-- ---------------------------------------------------------------------------
-- modules/car/install/database.sql — ตารางที่โมดูล car เป็นเจ้าของ
--
-- **ประกาศที่นี่ที่เดียว** ห้ามประกาศซ้ำใน install/database.sql ของโปรเจ็ค
-- และห้ามเขียน CREATE TABLE ซ้ำไว้ในตัวปรับรุ่นอีกชุด
--
-- ข้อกำหนด: InnoDB + utf8mb4 และเขียน PRIMARY KEY/KEY ไว้ในคำสั่ง CREATE TABLE
-- เลย — ของเดิมแยกไปเป็น ALTER TABLE ท้ายไฟล์แบบที่ phpMyAdmin ส่งออกมา
-- ทำให้ตารางที่ ensureTable สร้างตอนปรับรุ่นไม่ได้ดัชนีติดมาด้วย
-- ---------------------------------------------------------------------------

CREATE TABLE `{prefix}_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) NOT NULL DEFAULT '',
  `color` varchar(20) NOT NULL DEFAULT '',
  `detail` text NOT NULL,
  `seats` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `{prefix}_vehicles_meta` (
  `vehicle_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `value` varchar(150) NOT NULL,
  KEY `idx_vehicle_meta` (`vehicle_id`,`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `{prefix}_car_reservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `closed` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_vehicle_availability` (`vehicle_id`,`status`,`approve`,`begin`,`end`),
  KEY `member_id` (`member_id`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `{prefix}_car_reservation_data` (
  `reservation_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `value` varchar(150) NOT NULL,
  UNIQUE KEY `idx_reservation` (`reservation_id`,`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `{prefix}_vehicles` (`id`, `number`, `color`, `detail`, `seats`, `is_active`) VALUES
(1, 'นม 6', '#304FFE', 'พร้อมเครื่องเสียงชุดใหญ่', 50, 1),
(2, 'บจ 888', '#4A148C', '', 13, 1),
(3, 'กข 1234', '#B71C1C', '', 4, 1);

INSERT INTO `{prefix}_vehicles_meta` (`vehicle_id`, `name`, `value`) VALUES
(1, 'car_brand', '1'),
(1, 'car_type', '8'),
(2, 'car_brand', '2'),
(2, 'car_type', '7'),
(3, 'car_brand', '1'),
(3, 'car_type', '3');
