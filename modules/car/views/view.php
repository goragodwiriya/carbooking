<?php
/**
 * @filesource modules/car/views/view.php
 *
 * @copyright 2016 Goragod.com
 * @license https://www.kotchasan.com/license/
 *
 * @see https://www.kotchasan.com/
 */

namespace Car\View;

use Kotchasan\Language;

/**
 * Show document details (modal)
 *
 * @author Goragod Wiriya <admin@goragod.com>
 *
 * @since 1.0
 */
class View extends \Kotchasan\KBase
{
    /**
     * Render booking details for modal/email style output.
     *
     * @param array $index
     * @param bool $email
     *
     * @return string
     */
    public static function render($index, $email = false)
    {
        $content = [];
        $escape = static function ($value) {
            return htmlspecialchars((string) $value, ENT_QUOTES, 'UTF-8');
        };
        $escapeMultiline = static function ($value) use ($escape) {
            return nl2br($escape($value));
        };

        if ($email) {
            $content[] = '<header>';
            $content[] = '<h4>{LNG_Reservation details} '.$escape($index['vehicle_number']).'</h4>';
            $content[] = '</header>';
        }

        if (!empty($index['vehicle_image_url']) && !$email) {
            $content[] = '<p class="center"><img src="'.$escape($index['vehicle_image_url']).'" alt="'.$escape($index['vehicle_number']).'" style="max-width:100%;max-height:240px"></p>';
        }

        $content[] = '<table class="fullwidth">';
        $content[] = '<tr><td class="item"><span class="icon-user">{LNG_Name}</span></td><td class="item"> : </td><td class="item">'.$escape($index['member_name']).'</td></tr>';
        if (!empty($index['department_name'])) {
            $content[] = '<tr><td class="item"><span class="icon-group">{LNG_Department}</span></td><td class="item"> : </td><td class="item">'.$escape($index['department_name']).'</td></tr>';
        }
        $content[] = '<tr><td class="item"><span class="icon-car">{LNG_Vehicle}</span></td><td class="item"> : </td><td class="item">'.$escape($index['vehicle_number']).'</td></tr>';
        if (!empty($index['detail'])) {
            $content[] = '<tr><td class="item"><span class="icon-file">{LNG_Detail}</span></td><td class="item"> : </td><td class="item">'.$escapeMultiline($index['detail']).'</td></tr>';
        }
        if (!empty($index['comment'])) {
            $content[] = '<tr><td class="item"><span class="icon-comments">{LNG_Notes}</span></td><td class="item"> : </td><td class="item">'.$escapeMultiline($index['comment']).'</td></tr>';
        }
        $content[] = '<tr><td class="item"><span class="icon-calendar">{LNG_Reservation period}</span></td><td class="item"> : </td><td class="item">'.$escape($index['begin_text']).' - '.$escape($index['end_text']).'</td></tr>';
        $content[] = '<tr><td class="item"><span class="icon-group">{LNG_Travelers}</span></td><td class="item"> : </td><td class="item">'.$escape($index['travelers']).'</td></tr>';
        if (!empty($index['driver_text'])) {
            $content[] = '<tr><td class="item"><span class="icon-customer">{LNG_Driver}</span></td><td class="item"> : </td><td class="item">'.$escape($index['driver_text']).'</td></tr>';
        }
        if (!empty($index['accessories_text'])) {
            $content[] = '<tr><td class="item"><span class="icon-list">{LNG_Accessories}</span></td><td class="item"> : </td><td class="item">'.$escape($index['accessories_text']).'</td></tr>';
        }
        $content[] = '<tr><td class="item"><span class="icon-star0">{LNG_Status}</span></td><td class="item"> : </td><td class="item">'.$escape($index['status_text']).'</td></tr>';
        if (!empty($index['reason'])) {
            $content[] = '<tr><td class="item"><span class="icon-download">{LNG_Reason}</span></td><td class="item"> : </td><td class="item">'.$escapeMultiline($index['reason']).'</td></tr>';
        }
        $content[] = '</table>';
        // Restore HTML
        return implode("\n", $content);
    }

    /**
     * Build the shared modal action payload for booking details.
     *
     * @param array $index
     *
     * @return array
     */
    public static function buildModalAction(array $index): array
    {
        return [
            'type' => 'modal',
            'action' => 'show',
            'html' => Language::trans(static::render($index)),
            'title' => trim(Language::get('Details of').' '.$index['vehicle_number']),
            'titleClass' => 'icon-car'
        ];
    }
}
