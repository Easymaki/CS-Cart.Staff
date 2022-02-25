<?php

use Tygh\Registry;
use Tygh\Languages\Languages;

if (!defined('BOOTSTRAP')) {
    die('Access denied');
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if ($mode == 'update') {
        $person_id = fn_staff_update_person($_REQUEST['person_data'], $_REQUEST['person_id'], DESCR_SL);
        fn_attach_image_pairs('staff_main', 'staff', $person_id, $lang_code);
    } elseif ($mode == 'delete') {
        if (!empty($_REQUEST['person_id'])) {
            fn_staff_delete_person_by_id($_REQUEST['person_id']);
        }
    }
    return array(CONTROLLER_STATUS_OK, 'staff.manage');
}

if ($mode == 'manage') {

    list($staff, $params) = fn_staff_get_staff(DESCR_SL, $_REQUEST);

    Tygh::$app['view']->assign(array(
        'staff'  => $staff,
        'search' => $params,
    ));
}

if ($mode == 'update' || $mode == 'add') {
    $person_id = !empty($_REQUEST['person_id']) ? $_REQUEST['person_id'] : 0;

    $person = fn_staff_get_person_data($_REQUEST['person_id'], DESCR_SL);
    $countries = fn_get_countries(DESCR_SL);
    $states = fn_get_states(DESCR_SL);

    Tygh::$app['view']->assign('states', $states);
    Tygh::$app['view']->assign('person', $person);
    Tygh::$app['view']->assign('countries', $countries);
}
