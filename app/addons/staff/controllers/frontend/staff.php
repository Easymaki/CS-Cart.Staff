<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) {
    die('Access denied');
}

$params = $_REQUEST;

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    return array(CONTROLLER_STATUS_OK, 'staff.list');
}

if ($mode == 'list') {

    list($staff, $params) = fn_staff_get_staff(DESCR_SL, $_REQUEST);

    Tygh::$app['view']->assign('search', $params);
    Tygh::$app['view']->assign('staff', $staff);
}

if ($mode == 'view') {

    $person = fn_staff_get_person_data($_REQUEST['person_id'], DESCR_SL);
    $person_id = $_REQUEST['person_id'];
    $countries = fn_get_countries(DESCR_SL);
    $states = fn_get_states(DESCR_SL);

    Tygh::$app['view']->assign('states', $states);
    Tygh::$app['view']->assign('countries', $countries);
    Tygh::$app['view']->assign('person_id', $person_id);
    Tygh::$app['view']->assign('person', $person);
}
