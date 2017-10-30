<?php

use Adescom\SOAP\PlatformWebservice;
use Adescom\SOAP\Webservices;
use Adescom\SOAP\Platform\GetPanelUsersForClientRequest;

$customer_id_options = array(
    'options' => array(
        'min_range' => 1, 
    )
);

$customer_id = filter_input(INPUT_POST, 'customer_id', FILTER_VALIDATE_INT, $customer_id_options);
if ($SESSION->is_set('vapulp') && !$customer_id) {
    $SESSION->restore('vapulp', $customer_id);
} else {
    $SESSION->save('vapulp', $customer_id);
}

$customers = $DB->getAllByKey(
    'SELECT c.id, ' . $DB->Concat('c.lastname', "' '", 'c.name') . ' AS customer_name
    FROM customers c
    JOIN voipaccounts v ON c.id = v.ownerid
    GROUP BY c.id, c.name, c.lastname',
    'id'
);

if (array_key_exists($customer_id, $customers)) {
    
    $webservice = new PlatformWebservice();
    $webservice->setConnection(AdescomConnection::getConnection());
    
    $webservices = new Webservices();
    $webservices['platform'] = $webservice;
    
    $panel_user_manager = new AdescomPanelUserManager();
    $panel_user_manager->setWebservices($webservices);
    
    $request = new GetPanelUsersForClientRequest();
    $request->setClientExternalId($customer_id);
    
    $panel_users = $panel_user_manager->getPanelUsersForClient($request);
    
    $SMARTY->assign('panel_users', $panel_users);
}

$layout['pagetitle'] = trans('Panel users');

$SMARTY->assign('customers', $customers);
$SMARTY->assign('customer_id', $customer_id);
$SMARTY->display('voipaccount/paneluser/list.tpl');