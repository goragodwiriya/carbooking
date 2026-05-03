<?php
/**
 * @filesource modules/car/controllers/init.php
 */

namespace Car\Init;

use Car\Helper\Controller as Helper;
use Gcms\Api as ApiController;

class Controller extends \Gcms\Controller
{
    /**
     * Register car permissions.
     *
     * @param array $permissions
     * @param mixed $params
     * @param object|null $login
     *
     * @return array
     */
    public static function initPermission($permissions, $params = null, $login = null)
    {
        $permissions[] = [
            'value' => 'can_manage_car',
            'text' => '{LNG_Can manage} {LNG_Car booking}'
        ];
        $permissions[] = [
            'value' => 'can_drive_car',
            'text' => '{LNG_Can drive car}'
        ];

        return $permissions;
    }

    /**
     * Register car menus.
     *
     * @param array $menus
     * @param mixed $params
     * @param object|null $login
     *
     * @return array
     */
    public static function initMenus($menus, $params = null, $login = null)
    {
        if (!$login) {
            return $menus;
        }

        $memberMenu = [
            [
                'title' => '{LNG_My bookings}',
                'url' => '/my-bookings',
                'icon' => 'icon-list'
            ],
            [
                'title' => '{LNG_Book a car}',
                'url' => '/car-booking',
                'icon' => 'icon-edit'
            ],
            [
                'title' => '{LNG_All vehicles}',
                'url' => '/cars',
                'icon' => 'icon-car'
            ]
        ];

        if (Helper::canAccessApprovalArea($login)) {
            $memberMenu[] = [
                'title' => '{LNG_Car approvals}',
                'url' => '/car-approvals',
                'icon' => 'icon-verfied'
            ];
        }

        $menus = parent::insertMenuAfter($menus, $memberMenu, 0);

        if (!ApiController::hasPermission($login, ['can_manage_car', 'can_config'])) {
            return $menus;
        }

        $children = [
            [
                'title' => '{LNG_Settings}',
                'url' => '/car-settings',
                'icon' => 'icon-cog'
            ],
            [
                'title' => '{LNG_Vehicles}',
                'url' => '/vehicles',
                'icon' => 'icon-car'
            ]
        ];
        $categories = \Car\Category\Controller::items();
        foreach ($categories as $key => $menu) {
            $children[] = [
                'title' => $menu,
                'url' => '/car-categories?type='.$key,
                'icon' => 'icon-tags'
            ];
        }

        $settingsMenu = [
            [
                'title' => '{LNG_Car booking}',
                'icon' => 'icon-car',
                'children' => $children
            ]
        ];

        return parent::insertMenuChildren($menus, $settingsMenu, 'settings', null, 1);
    }
}
