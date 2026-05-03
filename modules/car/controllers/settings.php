<?php
/**
 * @filesource modules/car/controllers/settings.php
 */

namespace Car\Settings;

use Car\Helper\Controller as Helper;
use Gcms\Api as ApiController;
use Gcms\Config;
use Kotchasan\Http\Request;
use Kotchasan\Language;

class Controller extends ApiController
{
    /**
     * Get module settings.
     *
     * @param Request $request
     *
     * @return \Kotchasan\Http\Response
     */
    public function get(Request $request)
    {
        try {
            // Validate request method (GET request doesn't need CSRF token)
            ApiController::validateMethod($request, 'GET');

            // Read user from token (Bearer /X-Access-Token param)
            $login = $this->authenticateRequest($request);
            if (!$login) {
                return $this->errorResponse('Unauthorized', 401);
            }

            // Permission check
            if (!ApiController::hasPermission($login, ['can_manage_car', 'can_config'])) {
                return $this->errorResponse('Forbidden', 403);
            }

            return $this->successResponse([
                'data' => (object) [
                    'car_approving' => self::$cfg->car_approving,
                    'car_cancellation' => self::$cfg->car_cancellation,
                    'car_delete' => self::$cfg->car_delete,
                    'car_approve_level' => self::$cfg->car_approve_level === 1 ? count(self::$cfg->car_approve_status) : 0,
                    'car_approve_status' => self::$cfg->car_approve_status,
                    'car_approve_department' => self::$cfg->car_approve_department
                ],
                'options' => (object) [
                    'booking_statuses' => Helper::getStatusOptions(),
                    'status' => \Gcms\Controller::getUserStatusOptions(),
                    'department' => \Gcms\Category::init()->toOptions('department')
                ]
            ], 'Car settings loaded');
        } catch (\Exception $e) {
            return $this->errorResponse($e->getMessage(), $e->getCode() ?: 500, $e);
        }
    }

    /**
     * Save module settings.
     *
     * @param Request $request
     *
     * @return mixed
     */
    public function save(Request $request)
    {
        try {
            ApiController::validateMethod($request, 'POST');
            ApiController::validateCsrfToken($request);

            // Authentication check (required)
            $login = $this->authenticateRequest($request);
            if (!$login) {
                return $this->redirectResponse('/login', 'Unauthorized', 401);
            }

            // Permission check
            if (!ApiController::canModify($login, ['can_manage_car', 'can_config'])) {
                return $this->errorResponse('Permission required', 403);
            }

            $carApproving = $request->post('car_approving')->toInt();
            if (!in_array($carApproving, [
                Helper::APPROVAL_BEFORE_END,
                Helper::APPROVAL_BEFORE_START,
                Helper::APPROVAL_ALWAYS
            ], true)) {
                $carApproving = Helper::APPROVAL_BEFORE_START;
            }

            $carCancellation = $request->post('car_cancellation')->toInt();
            if (!in_array($carCancellation, [
                Helper::CANCELLATION_PENDING_ONLY,
                Helper::CANCELLATION_BEFORE_DATE,
                Helper::CANCELLATION_BEFORE_START,
                Helper::CANCELLATION_BEFORE_END,
                Helper::CANCELLATION_ALWAYS
            ], true)) {
                $carCancellation = Helper::CANCELLATION_PENDING_ONLY;
            }

            $booking_status = Language::get('BOOKING_STATUS');

            $carDelete = [];
            foreach ($request->post('car_delete')->toArray() as $status) {
                if (isset($booking_status[$status])) {
                    $carDelete[] = (int) $status;
                }
            }

            $config = Config::load(ROOT_PATH.'settings/config.php');
            $config->car_approving = $carApproving;
            $config->car_cancellation = $carCancellation;
            $config->car_delete = $carDelete;
            $config->car_approve_level = $request->post('car_approve_level')->toInt();
            $config->car_approve_status = $request->post('car_approve_status', [])->toInt();
            $config->car_approve_department = $request->post('car_approve_department', [])->toInt();

            if (Config::save($config, ROOT_PATH.'settings/config.php')) {
                // Log
                \Index\Log\Model::add(0, 'car', 'Save', 'Save Car Settings', $login->id);

                // Reload page
                return $this->redirectResponse('reload', 'Saved successfully', 200, 1000);
            }
        } catch (\Kotchasan\ApiException $e) {
            // Keep original HTTP code (e.g. 403 CSRF, 405 method)
            return $this->errorResponse($e->getMessage(), $e->getCode() ?: 400);
        }
        // Error save settings
        return $this->errorResponse('Failed to save settings', 500);
    }
}
