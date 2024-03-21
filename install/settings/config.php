<?php
/* config.php */
return array(
    'version' => '6.0.5',
    'web_title' => 'CRS',
    'web_description' => 'Car Reservation Service',
    'timezone' => 'Asia/Bangkok',
    'member_status' => array(
        0 => 'สมาชิก',
        1 => 'ผู้ดูแลระบบ',
        2 => 'พนักงานขับรถ'
    ),
    'color_status' => array(
        0 => '#259B24',
        1 => '#FF0000',
        2 => '#0E0EDA'
    ),
    'default_icon' => 'icon-shipping',
    'user_forgot' => 0,
    'user_register' => 0,
    'welcome_email' => 0,
    'car_w' => 600,
    'chauffeur_status' => 2,
    'car_approving' => 0,
    'car_delete' => 0,
    'car_notifications' => 0,
    'car_cancellation' => 0,
    'car_approve_status' => array(
        1 => 0
    ),
    'car_approve_department' => array(
        1 => '1'
    )
);
