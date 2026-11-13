-- -------------------------------------------------------------------------
-- install/database.sql — ข้อมูลตั้งต้นของ carbooking
--
-- ตารางแกนของ Gcms (user, category, logs, login_attempt, number, migration,
-- user_meta, user_session, language) อยู่ใน install/core.sql
-- ตารางของโมดูล car อยู่ใน modules/car/install/database.sql
-- ไฟล์นี้จึงเหลือเฉพาะข้อมูลตั้งต้นที่ลงในตารางแกน ซึ่งไม่มีโมดูลไหนเป็นเจ้าของ
-- -------------------------------------------------------------------------

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
