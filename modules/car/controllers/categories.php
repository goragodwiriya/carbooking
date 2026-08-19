<?php
/**
 * @filesource modules/car/controllers/categories.php
 */

namespace Car\Categories;

class Controller extends \Index\Categories\Controller
{
    /**
     * Supported category types and their labels.
     *
     * @var array
     */
    protected $categories = [
        'car_type' => '{LNG_Car type}',
        'car_brand' => '{LNG_Car brand}',
        'car_accessory' => '{LNG_Car accessory}'
    ];
}