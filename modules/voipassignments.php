<?php

$order_by = null;
$order_direction = "asc";
if ($SESSION->is_set('vaalo') && !isset($_GET['o'])) {
    $SESSION->restore('vaalo', $order_by);
    $SESSION->restore('vaald', $order_direction);
} else {
    $page_options = array(
        'options' => array(
            'default' => 1,
            'min_range' => 1, 
        )
    );
    $order = filter_input(INPUT_GET, 'o', FILTER_SANITIZE_STRING, FILTER_FLAG_NO_ENCODE_QUOTES);
    if ($order) {
        $allowed_order_by = array('customerid', 'liabilities_count', 'tariffs_count');
        $allowed_order_direction = array('asc', 'desc');
        list($order_by, $order_direction) = explode(',', $order);
        if (!in_array($order_direction, $allowed_order_direction)) {
            $order_direction = 'asc';
        }
        if (!in_array($order_by, $allowed_order_by)) {
            $order_by = null;
        }
    }
}
$SESSION->save('vaalo', $order_by);
$SESSION->save('vaald', $order_direction);

$page = null;
if ($SESSION->is_set('vaalp') && !isset($_GET['page'])) {
    $SESSION->restore('vaalp', $page);
} else {
    $page_options = array(
        'options' => array(
            'default' => 1,
            'min_range' => 1, 
        )
    );
    $page = filter_input(INPUT_GET, 'page', FILTER_VALIDATE_INT, $page_options);
}
$SESSION->save('vaalp', $page);

$limit_options = array(
    'options' => array(
        'default' => 100,
        'min_range' => 1, 
        'max_range' => 1000, 
    )
);
$limit = filter_input(INPUT_GET, 'limit', FILTER_VALIDATE_INT, $limit_options);

$offset = ($page - 1) * $limit;

$error = array();

$voip_assignments_count = count($DB->getAll(
    "SELECT c.id 
    FROM assignments a 
    JOIN customers c ON c.id = a.customerid
    LEFT JOIN liabilities l ON l.id = a.liabilityid 
    LEFT JOIN tariffs t ON t.id = a.tariffid 
    WHERE (t.type = 4 OR t.type IS NULL) 
    AND (l.name = 'ADESCOM_AUTO_VOIP_CALL' OR l.name IS NULL)
    GROUP BY c.id
    HAVING COUNT(l.id) > 0 OR COUNT(t.id) > 0"
));

$voip_assignments = array();

if ($voip_assignments_count > 0) {
    $voip_assignments = $DB->getAll(
        "SELECT a.customerid, COUNT(l.id) AS liabilities_count, COUNT(t.id) AS tariffs_count, " 
        . $DB->Concat('c.lastname', "' '", 'c.name') . " AS customername
        FROM assignments a 
        JOIN customers c ON c.id = a.customerid
        LEFT JOIN liabilities l ON l.id = a.liabilityid 
        LEFT JOIN tariffs t ON t.id = a.tariffid 
        WHERE (t.type = 4 OR t.type IS NULL) 
        AND (l.name = 'ADESCOM_AUTO_VOIP_CALL' OR l.name IS NULL) 
        GROUP BY a.customerid, c.name, c.lastname
        HAVING COUNT(l.id) > 0 OR COUNT(t.id) > 0
        ORDER BY"
        . (($order_by === null) ? " a.customerid " : " $order_by ")
        . (($order_by === null) ? " ASC " : " $order_direction ")
        . "LIMIT ?
        OFFSET ?",
        array($limit, $offset)
    );
}

$listdata = array(
    'total' => $voip_assignments_count,
    'offset' => $offset,
    'limit' => $limit,
    'page' => $page,
    'pages' => ceil($voip_assignments_count/$limit) + 1,
);

$layout['pagetitle'] = trans('VoIP assigmnents');
$SMARTY->assign('error', $error);
$SMARTY->assign('order_by', $order_by);
$SMARTY->assign('order_direction', $order_direction);
$SMARTY->assign('listdata', $listdata);
$SMARTY->assign('voipassignments', $voip_assignments);
$SMARTY->display('voipaccount/voipassignments.tpl');