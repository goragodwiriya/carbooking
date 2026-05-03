<?php
/**
 * @filesource modules/car/controllers/calendar.php
 */

namespace Car\Calendar;

use Car\Helper\Controller as Helper;
use Gcms\Api as ApiController;
use Kotchasan\Http\Request;

class Controller extends ApiController
{
    /**
     * Get reservation events for EventCalendar.
     *
     * @param Request $request
     *
     * @return \Kotchasan\Http\Response
     */
    public function index(Request $request)
    {
        try {
            ApiController::validateMethod($request, 'GET');

            $start = $request->get('start')->date();
            $end = $request->get('end')->date();

            $query = \Kotchasan\Model::createQuery()
                ->select(
                    'R.id',
                    'R.begin',
                    'R.end',
                    'V.number',
                    'V.color',
                    'U.name member_name'
                )
                ->from('car_reservation R')
                ->join('vehicles V', ['V.id', 'R.vehicle_id'], 'LEFT')
                ->join('user U', ['U.id', 'R.member_id'], 'LEFT')
                ->where([
                    ['R.status', self::$cfg->car_calendar_status],
                    ['R.begin', '<=', $end.' 23:59:59'],
                    ['R.end', '>=', $start.' 00:00:00']
                ])
                ->orderBy('R.begin')
                ->cacheOn();

            $events = [];
            foreach ($query->fetchAll() as $item) {
                $events[] = [
                    'id' => (string) $item->id,
                    'title' => $item->number.', '.Helper::formatBookingTime($item, true),
                    'start' => $item->begin,
                    'end' => $item->end,
                    'scheduleType' => 'continuous',
                    'allDay' => false,
                    'color' => $item->color ?: '#4285F4'
                ];
            }

            return $this->successResponse([
                'data' => $events
            ], 'Calendar data retrieved');
        } catch (\Exception $e) {
            return $this->errorResponse($e->getMessage(), $e->getCode() ?: 500, $e);
        }
    }
}
