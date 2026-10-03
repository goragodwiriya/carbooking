<?php
/**
 * @filesource modules/car/controllers/statistics.php
 */

namespace Car\Statistics;

use Car\Helper\Controller as Helper;
use Gcms\Api as ApiController;
use Kotchasan\Database\Sql;
use Kotchasan\Http\Request;

class Controller extends ApiController
{
    /**
     * Get booking statistics for current user and approvals.
     *
     * @param Request $request
     *
     * @return \Kotchasan\Http\Response
     */
    public function index(Request $request)
    {
        try {
            ApiController::validateMethod($request, 'GET');

            $login = $this->authenticateRequest($request);
            if (!$login) {
                // Guest
                return $this->successResponse(null, 'Statistics retrieved');
            }

            // My bookings counts
            $query = \Kotchasan\Model::createQuery()
                ->select(Sql::COUNT('id', 'count'), 'status')
                ->from('car_reservation')
                ->where(['member_id', (int) $login->id])
                ->groupBy('status')
                ->cacheOn();
            $rows = [];
            foreach ($query->fetchAll() as $row) {
                // Process each row
                $rows[$row->status] = (int) $row->count;
            }
            $my = [
                'pending' => (int) ($rows[Helper::STATUS_PENDING_REVIEW] ?? 0),
                'returned' => (int) ($rows[Helper::STATUS_RETURNED_FOR_EDIT] ?? 0),
                'approved' => (int) ($rows[Helper::STATUS_APPROVED] ?? 0)
            ];

            // Approvals (if user can approve)
            $approvals = ['pending' => 0];
            if (Helper::canAccessApprovalArea($login)) {
                $approveLevel = Helper::getApproveLevel($login);
                $q = \Kotchasan\Model::createQuery()
                    ->select(Sql::COUNT('id', 'count'))
                    ->from('car_reservation')
                    ->where(['status', Helper::STATUS_PENDING_REVIEW]);

                if ($approveLevel !== -1) {
                    $q->where(['approve', $approveLevel]);
                }

                $row = $q->first();
                $approvals['pending'] = (int) ($row ? $row->count : 0);
            }

            return $this->successResponse([
                'my' => $my,
                'approvals' => $approvals
            ], 'Statistics retrieved');
        } catch (\Exception $e) {
            return $this->errorResponse($e->getMessage(), $e->getCode() ?: 500, $e);
        }
    }
}
