# Car booking - ระบบจองรถออนไลน์

โปรเจ็กต์นี้เป็นระบบจองรถองค์กรที่ทำงานแบบ frontend SPA + PHP API

- frontend shell ใช้ `index.html`
- frontend bootstrap อยู่ที่ `js/main.js`
- backend API หลักเข้าได้ผ่าน `api.php`
- งานส่งออกและงานพิมพ์เข้าได้ผ่าน `export.php`
- LINE Messaging API callback เข้าได้ผ่าน `line/webhook.php`
- business logic หลักของระบบจองรถอยู่ใน `modules/car/`
- ความสามารถส่วนกลางของแพลตฟอร์มอยู่ใน `modules/index/`

## Stack และ runtime model

### Frontend

- Now.js เป็น framework ฝั่ง client สำหรับ route, component, template binding, auth integration และ UI managers
- SPA shell โหลด bundle จาก `Now/dist/`
- template ของหน้าใช้งานจริงถูก render ตาม route จากโฟลเดอร์ `templates/` และ `templates/car/`
- `modules/car/admin.js` ลงทะเบียน route ฝั่งระบบจองรถเพิ่มเติม เช่น `/cars`, `/my-bookings`, `/car-booking`, `/car-approvals`, `/vehicles`, `/car-settings`

### Backend

- Kotchasan เป็น framework ฝั่ง PHP ที่รับผิดชอบ routing, request/response, model/query, config และ utilities
- GCMS layer ให้ base controller สำหรับ admin/API/table workflow
- controller ฝั่ง PHP จัดตาม module namespace เช่น `Car\\Booking\\Controller`, `Car\\Review\\Controller`, `Index\\Config\\Controller`

## Entry points ที่สำคัญ

| Entry point | หน้าที่ |
| --- | --- |
| `index.html` | SPA shell หลักของระบบ |
| `js/main.js` | initialize Now.js, auth, csrf, i18n, router และ route ฝั่ง settings/platform |
| `api.php` | จุดเข้า API หลักของแอป |
| `export.php` | จุดเข้างาน export/print |
| `line/webhook.php` | รับ LINE webhook |
| `load.php` | bootstrap ค่าระบบ, debug flags, DB logging และ include Kotchasan |

## โครงสร้างโมดูลหลัก

### `modules/car/`

โมดูลนี้เป็นแกนธุรกิจของระบบจองรถ แบ่งหน้าที่หลักดังนี้

- `controllers/booking.php` รับผิดชอบโหลดและบันทึกคำขอจองรถ
- `controllers/approvals.php` และ `controllers/review.php` ดูแลหน้ารายการรออนุมัติและคำตัดสิน
- `controllers/calendar.php` และ `controllers/statistics.php` ป้อนข้อมูลให้ dashboard และปฏิทิน
- `controllers/vehicle.php` และ `controllers/vehicles.php` ใช้จัดการข้อมูลรถและรูปภาพรถ
- `controllers/settings.php` ใช้กำหนด policy ของระบบจองรถ
- `controllers/email.php` ส่ง notification ไปยัง Email, LINE และ Telegram
- `models/` รวม query และ data shaping ของ reservation, approvals, vehicles และ review
- `views/view.php` ใช้ render รายละเอียดการจองสำหรับ notification หรือ modal

### `modules/index/`

โมดูลนี้เป็น shared platform layer ของ repository

- auth และ session restore
- profile และ user management
- permissions และ user status
- settings pages หลายหมวด เช่น general, company, email, api, theme, line, telegram, sms
- public config endpoint สำหรับ login page และ frontend theme/config
- social login callback/config

### `modules/download/`

- ใช้แสดงรายการไฟล์แนบ ดาวน์โหลดไฟล์ และช่วยดึง attachment metadata
- ใช้ร่วมกับระบบรูปภาพรถ โดยไฟล์อยู่ภายใต้ `datas/car/<id>/`

### `modules/export/`

- มี shared export controller สำหรับ HTML print page และ CSV export
- `export.php` จะชี้งานไปยัง controller ฝั่ง export ของระบบ

## Frontend routing model

`js/main.js` เป็นจุดรวม route ฝั่งแพลตฟอร์ม เช่น login, profile, users, settings และ system pages ส่วน route ของระบบจองรถถูกเพิ่มผ่าน `modules/car/admin.js`

route ฝั่งจองรถที่สำคัญ เช่น

- `/` ใช้หน้า reservation calendar
- `/cars` ใช้หน้า vehicle catalog
- `/my-bookings` ใช้หน้ารายการจองของผู้ใช้
- `/car-booking` ใช้หน้าฟอร์มจองรถ
- `/car-approvals` ใช้หน้ารายการสำหรับผู้อนุมัติ
- `/car-review` ใช้หน้ารีวิวคำขอ
- `/vehicles` ใช้หน้าจัดการรถ
- `/car-settings` ใช้หน้าตั้งค่าของโมดูลจองรถ

## Business rules ที่ควรรู้

### การจองรถ

- ผู้ใช้ต้องมี `department` ใน profile จึงจะจองรถได้
- ระบบ validate ช่วงเวลาเริ่มและสิ้นสุดก่อนบันทึก
- ระบบตรวจ availability ของรถก่อน save
- ถ้ารายการเคยถูกส่งกลับให้แก้ไข การบันทึกใหม่จะพา state กลับไปสู่ pending review

### Approval workflow

- workflow อิงกับ status ของสมาชิกและ department
- การตั้งค่า approval step มาจาก `car_approve_level`, `car_approve_status`, `car_approve_department`
- admin สามารถเข้าถึง approval area ได้
- final approval จะตรวจ availability ซ้ำอีกครั้ง
- final approval ต้องมี self-drive หรือ assigned driver ที่ใช้ได้จริง

### Cancellation policy

- requester cancellation policy ถูกกำหนดจาก config
- รองรับหลายระดับ เช่น pending-only, before date, before start, before end, always
- officer cancellation แยก flow ออกจาก requester cancellation

## Data model ที่สำคัญ

| Table | บทบาท |
| --- | --- |
| `car_reservation` | reservation header เช่น รถ, ผู้จอง, เวลา, สถานะ, approve step |
| `car_reservation_data` | reservation metadata เช่น accessory หรือ review note |
| `vehicles` | ข้อมูลรถหลัก |
| `vehicles_meta` | metadata ของรถ เช่น brand และ type |
| `category` | master data กลาง เช่น department, car_brand, car_type, car_accessory |
| `user` | บัญชีผู้ใช้, social identity, permissions, status |
| `user_meta` | metadata ของผู้ใช้ เช่น department |
| `logs` | audit/history ภายในระบบ |

แนวทาง data modeling ของ repo นี้ใช้ table หลักร่วมกับ meta table เพื่อให้ขยายข้อมูลเพิ่มได้โดยไม่ต้องแก้ schema หลักบ่อย

## Notification และ external integration

### ที่ใช้จริงในระบบจองรถ

- Email
- LINE
- Telegram

`modules/car/controllers/email.php` จะ aggregate ผู้เกี่ยวข้อง เช่น ผู้จอง คนขับ แอดมิน และ approver ที่ตรงกับ step ปัจจุบัน แล้วค่อยส่งข้อความตาม channel ที่เปิดใช้ใน config

### ความสามารถเพิ่มเติมในระดับแพลตฟอร์ม

- social login: Google, Facebook, LINE, Telegram
- LINE callback และ LINE webhook
- Telegram settings
- SMS settings

## การติดตั้ง

ระบบมี installer ในโฟลเดอร์ `install/` ซึ่งรองรับทั้งการติดตั้งใหม่และการอัปเกรดเวอร์ชัน

### สิ่งที่ installer ตรวจ

- PHP 7.4 ขึ้นไป
- PDO MySQL
- mbstring
- zlib
- JSON
- XML
- OpenSSL
- GD
- cURL

### สิ่งที่ installer ทำ

1. รับค่าการเชื่อมต่อฐานข้อมูล
2. สร้างฐานข้อมูลเมื่อยังไม่มี
3. import schema จาก `install/database.sql`
4. seed ข้อมูลเริ่มต้นของระบบ
5. สร้าง `settings/database.php` และ `settings/config.php`
6. สร้าง admin account เริ่มต้น

## Logging, debug และ validation notes

- `load.php` กำหนด `DEBUG`, `DB_LOG`, `DB_LOG_FILE`, `DB_LOG_RETENTION_DAYS`
- เมื่อเปิด SQL log ข้อมูล query จะถูกส่งไปที่ `datas/logs/sql_log.php`
