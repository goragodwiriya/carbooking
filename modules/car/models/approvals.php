<?php
/**
 * @filesource modules/car/models/approvals.php
 */

namespace Car\Approvals;

class Model extends \Kotchasan\Model
{
    /**
     * Query bookings for approver view.
     *
     * @param array $params
     * @param object|null $login
     *
     * @return \Kotchasan\QueryBuilder\QueryBuilderInterface
     */
    public static function toDataTable(array $params, $login = null)
    {
        $where = [];
        $approvalScope = null;
        if ($params['department'] !== '') {
            $where[] = ['R.department', $params['department']];
        }
        if ($params['chauffeur'] !== '') {
            $where[] = ['R.chauffeur', (int) $params['chauffeur']];
        }
        if ($params['status'] !== '') {
            $where[] = ['R.status', (int) $params['status']];
        }
        if ($params['vehicle_id'] !== '') {
            $where[] = ['R.vehicle_id', (int) $params['vehicle_id']];
        }
        if ($params['member_id'] !== '') {
            $where[] = ['R.member_id', (int) $params['member_id']];
        }
        if (!empty($params['from'])) {
            $where[] = ['R.begin', '>=', $params['from'].' 00:00:00'];
        }
        if (!empty($params['to'])) {
            $where[] = ['R.begin', '<=', $params['to'].' 23:59:59'];
        }

        $login = isset($params['request_login']) ? $params['request_login'] : null;
        if ($login && !\Gcms\Api::isAdmin($login)) {
            $approvalSteps = \Car\Helper\Controller::getApprovalSteps();
            if (!empty($approvalSteps)) {
                $loginDepartment = isset($login->metas['department'][0]) ? trim((string) $login->metas['department'][0]) : '';
                $q = [];
                foreach ($approvalSteps as $approve => $step) {
                    if ((int) $login->status === (int) $step['status']) {
                        $department = (string) $step['department'];
                        if ($department === '') {
                            // User must be in the same department as the booking
                            if ($loginDepartment !== '') {
                                $loginDepartmentSql = \Kotchasan\Database\Sql::create($loginDepartment);
                                $q[] = "(`R`.`approve` = ".$approve." AND `R`.`department` = $loginDepartmentSql)";
                            }
                        } elseif ($department === $loginDepartment) {
                            $q[] = "(`R`.`approve` = ".$approve.")";
                        }
                    }
                }
                if (!empty($q)) {
                    $approvalScope = \Kotchasan\Database\Sql::create('('.implode(' OR ', $q).')');
                } else {
                    $where[] = ['R.id', 0];
                }
            }
        }

        $query = static::createQuery()
            ->select(
                'R.id',
                'R.member_id',
                'R.vehicle_id',
                'R.reason',
                'R.detail',
                'R.begin',
                'R.end',
                'R.status',
                'R.approve',
                'R.closed',
                'R.chauffeur',
                'R.created_at',
                'R.department',
                'U.name member_name'
            )
            ->from('car_reservation R')
            ->join('user U', ['U.id', 'R.member_id'], 'LEFT')
            ->where($where);

        if ($approvalScope !== null) {
            $query->where($approvalScope);
        }

        if (!empty($params['search'])) {
            $search = '%'.$params['search'].'%';
            $query->where([
                ['R.detail', 'LIKE', $search],
                ['R.reason', 'LIKE', $search]
            ], 'OR');
        }

        return $query;
    }

    /**
     * Remove reservations by IDs.
     *
     * @param array $ids
     *
     * @return bool
     */
    public static function remove(array $ids): bool
    {
        $db = \Kotchasan\DB::create();
        $db->delete('car_reservation', ['id', $ids], 0);
        $db->delete('car_reservation_data', ['reservation_id', $ids], 0);

        return true;
    }
}
