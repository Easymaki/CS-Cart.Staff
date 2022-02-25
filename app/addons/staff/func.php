<?php

use Tygh\Registry;
use Tygh\Languages\Languages;
use Tygh\Template\Mail\Service;

function fn_staff_get_staff($lang_code = CART_LANGUAGE, $params = array())
{
    $join = '';

    $fields = array(
        '?:staff.person_id',
        '?:staff.position',
        '?:staff.email',
        '?:staff.status',
        '?:staff_descriptions.name',
        '?:staff_descriptions.post',

    );

    $join .= db_quote(' LEFT JOIN ?:staff_descriptions ON ?:staff_descriptions.person_id = ?:staff.person_id AND ?:staff_descriptions.lang_code = ?s', $lang_code);

    $items_per_page = 12;
    $total_items = db_get_field("SELECT COUNT(*) FROM ?:staff $join WHERE 1");

    $default_params = array(
        'page' => 1,
        'items_per_page' => $items_per_page,
        'total_items' => $total_items
    );

    $params = array_merge($default_params, $params);

    $sortings = array(
        'position' => '?:staff.position',
    );

    $sorting = db_sort($params, $sortings, 'position', 'asc');

    $limit = db_paginate($params['page'], $params['items_per_page'], $params['total_items']);

    $staff = db_get_hash_array(
        "SELECT ?p FROM ?:staff " .
            $join .
            "WHERE 1 ?p ?p",
        'person_id',
        implode(', ', $fields),
        $sorting,
        $limit
    );

    if (AREA == 'C') {
        foreach ($staff as $key => $value) {
            $staff[$key]['image'] = fn_get_image_pairs($value['person_id'], 'staff', 'M', true, false, $lang_code);
        }
    }

    return array($staff, $params);
}

function fn_staff_get_person_data($person_id = 0, $lang_code = CART_LANGUAGE)
{
    $fields = $joins = array();
    $condition = '';

    $fields = array(
        '?:staff.*',
        '?:staff_descriptions.*',
    );

    $joins[] = db_quote("LEFT JOIN ?:staff_descriptions ON ?:staff_descriptions.person_id = ?:staff.person_id AND ?:staff_descriptions.lang_code = ?s", $lang_code);
    $condition = db_quote("WHERE ?:staff.person_id = ?i", $person_id);
    $condition .= (AREA == 'A') ? '' : " AND ?:staff.status IN ('A', 'H') ";

    $person = db_get_row("SELECT " . implode(", ", $fields) . " FROM ?:staff " . implode(" ", $joins) . " $condition");

    if (!empty($person)) {
        $person['main_pair'] = fn_get_image_pairs($person_id, 'staff', 'M', true, false, $lang_code);
    }

    return $person;
}

function fn_staff_update_person(&$person, &$person_id, $lang_code = DESCR_SL)
{
    if (!empty($person_id)) {
        db_query("UPDATE ?:staff SET ?u WHERE person_id = ?i", $person, $person_id);
        db_query("UPDATE ?:staff_descriptions SET ?u WHERE person_id = ?i AND lang_code = ?s", $person, $person_id, $lang_code);
    } else {
        $person_id = $person['person_id'] = db_query("REPLACE INTO ?:staff ?e", $person);

        foreach (Languages::getAll() as $person['lang_code'] => $v) {
            db_query("REPLACE INTO ?:staff_descriptions ?e", $person);
        }
    }

    return $person_id;
}

function fn_staff_delete_person_by_id(&$person_id)
{
    if (!empty($person_id)) {
        db_query("DELETE FROM ?:staff WHERE person_id = ?i", $person_id);
        db_query("DELETE FROM ?:staff_descriptions WHERE person_id = ?i", $person_id);
    }
}
