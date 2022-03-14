<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) {
    die('Access denied');
}

if ($mode == 'list') {

    list($staff, $params) = fn_staff_get_staff(DESCR_SL, $_REQUEST);

    Tygh::$app['view']->assign('search', $params);
    Tygh::$app['view']->assign('staff', $staff);
}

if ($mode == 'view') {

    $person = fn_staff_get_person_data($_REQUEST['person_id'], DESCR_SL);
    $person_id = $_REQUEST['person_id'];

    $person['country_descr'] = fn_get_country_name($person['lang_code'], DESCR_SL);
    $person['state_descr'] = fn_get_state_name($person['state'], DESCR_SL);

    Tygh::$app['view']->assign('person_id', $person_id);
    Tygh::$app['view']->assign('person', $person);
}
