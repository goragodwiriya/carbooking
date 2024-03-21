<?php
/* settings/database.php */

return array(
    'mysql' => array(
        'dbdriver' => 'mysql',
        'username' => 'root',
        'password' => '',
        'dbname' => 'car_booking',
        'prefix' => 'app'
    ),
    'tables' => array(
        'category' => 'category',
        'language' => 'language',
        'line' => 'line',
        'car_reservation' => 'car_reservation',
        'car_reservation_data' => 'car_reservation_data',
        'vehicles' => 'vehicles',
        'vehicles_meta' => 'vehicles_meta',
        'user' => 'user'
    )
);
