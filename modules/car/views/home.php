<?php
/**
 * @filesource modules/car/views/home.php
 *
 * @copyright 2016 Goragod.com
 * @license https://www.kotchasan.com/license/
 *
 * @see https://www.kotchasan.com/
 */

namespace Car\Home;

use Kotchasan\Html;

/**
 * หน้า Home
 *
 * @author Goragod Wiriya <admin@goragod.com>
 *
 * @since 1.0
 */
class View extends \Gcms\View
{
    /**
     * หน้า Home
     *
     * @param object $index
     * @param array  $login
     *
     * @return string
     */
    public function render($index, $login)
    {
        $section = Html::create('div');
        $section->add('header', array(
            'innerHTML' => '<h2 class="icon-shipping">{LNG_Booking calendar} {LNG_Vehicle}</h2>'
        ));
        $div = $section->add('div', array(
            'class' => 'setup_frm'
        ));
        $div->add('div', array(
            'id' => 'car-calendar'
        ));
        // สีทั้งหมด (ที่เผยแพร่)
        $query = \Car\Vehicles\Model::toDataTable()->cacheOn();
        $cars = '';
        foreach ($query->execute() as $item) {
            $cars .= '<a id=car_'.$item->id.' class="item cuttext"><span style="background-color:'.$item->color.'"></span>'.$item->number.'</a>';
        }
        $div->add('div', array(
            'id' => 'car_links',
            'class' => 'calendar_links clear document-list col3',
            'innerHTML' => $cars
        ));
        // คืนค่าปีที่มีการจองสูงสุดและต่ำสุด
        $range = \Car\Home\Model::getYearRange();
        /* Javascript */
        $section->script('initCarCalendar('.$range->min.', '.$range->max.');');
        // คืนค่า HTML
        return $section->render();
    }
}
