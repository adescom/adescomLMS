<?php

use Adescom\SOAP\PlatformWebservice;
use Adescom\SOAP\Webservices;

$page_options = array(
    'default' => 1,
    'min_range' => 1,
);

$date_options = array(
    'regexp' => '/^\d{4}\/\d{2}\/\d{2} \d{2}:\d{2}(:\d{2})?$/',
);

$filter_options = array(
    'page' => array(
        'filter' => FILTER_VALIDATE_INT,
        'options' => $page_options,
    ),
    'incoming' => array(
        'filter' => FILTER_VALIDATE_BOOLEAN,
        'flags' => FILTER_NULL_ON_FAILURE,
    ),
    'outgoing' => array(
        'filter' => FILTER_VALIDATE_BOOLEAN,
        'flags' => FILTER_NULL_ON_FAILURE,
    ),
    'remoteMask' => array(
        'filter' => FILTER_SANITIZE_STRING
    ),
    'fromDate' => array(
        'filter' => FILTER_VALIDATE_REGEXP,
        'options' =>$date_options,
    ),
    'toDate' => array(
        'filter' => FILTER_VALIDATE_REGEXP,
        'options' => $date_options,
    ),
    'includeZeroDuration' => array(
        'filter' => FILTER_VALIDATE_BOOLEAN,
        'flags' => FILTER_NULL_ON_FAILURE,
    ),
    'clientExtraClids' => array(
        'filter' => FILTER_VALIDATE_INT,
        'flags'  => FILTER_REQUIRE_ARRAY,
        'options' => array('min_range' => 1),
    ),
);

$common_id_options = array(
    'options' => array(
        'default' => null,
        'min_range' => 1,
    )
);

$filter = filter_input_array(INPUT_POST, $filter_options);

if (empty($filter)) {
    if ($SESSION->is_set('filter')) {
        $SESSION->restore('filter', $filter);
    } else {
        $filter['incoming'] = false;
        $filter['outgoing'] = true;
        $filter['remoteMask'] = null;
        $filter['fromDate'] = date('Y/m/01 00:00:00');
        $filter['toDate'] = date('Y/m/t 23:59:59');
        $filter['includeZeroDuration'] = false;
        $filter['page'] = filter_input(INPUT_GET, 'page', FILTER_VALIDATE_INT, array('options' => $page_options));
    }
}

$client_id = filter_input(INPUT_GET, 'client_id', FILTER_VALIDATE_INT, $common_id_options);
$voip_account_id = filter_input(INPUT_GET, 'voip_account_id', FILTER_VALIDATE_INT, $common_id_options);

$trunk_names = array();
$voip_accounts = array();
$clients_names = $LMS->getCustomerNames();

$voip_manager = new AdescomVoipAccountManager($DB);

$clients = array();
if ($client_id !== null) {
    $SMARTY->assign('client_id', $client_id);
    $voip_accounts = $voip_manager->getCustomerVoIPAccountsPhoneNumbers($client_id);
    if ($voip_account_id !== null) {
        $filter['clientExtraClids'] = array($voip_account_id);
    }
    $clients[] = $client_id;
} else {
    $voip_accounts = $voip_manager->getCustomersVoIPAccountsPhoneNumbers();
    $clients = array_keys($voip_accounts);
}

if (!empty($clients)) {
    try {
        $trunk_manager = new AdescomTrunkManager();
        $trunks = $trunk_manager->getTrunksForClients($clients);
    } catch (SoapFault $e) {
        error_log(__METHOD__ . ': ' . $e->getMessage());
        $SESSION->save('adescom_error_code', $e->detail->code);
        $SESSION->redirect('?m=adescom_error');
    } catch (Exception $e) {
        error_log(__METHOD__ . ': ISE');
        $SESSION->save('adescom_error_code', 'ise');
        $SESSION->redirect('?m=adescom_error');
    }
}


$records = array();

if (!empty($filter) && !empty($clients)) {
    
    $filter['perPage'] = 20;
    
    $webservice = new PlatformWebservice();
    $webservice->setConnection(AdescomConnection::getConnection());
    
    $webservices = new Webservices();
    $webservices['platform'] = $webservice;
    
    $billing_manager = new AdescomBillingManager();
    $billing_manager->setWebservices($webservices);

    $errors = $billing_manager->validateGetBillingForClientsFilters($filter);

    if (empty($errors)) {
        try {
            $response = $billing_manager->getBillingForClients($clients, $filter, $voip_accounts);

            $listdata = array(
                'page' => $filter['page'],
                'pages' => ceil($response->total / $filter['perPage']),
                'total' => $response->total,
                'totalPrice' => $response->totalPrice,
                'totalDuration' => $response->totalDuration,
            );
            $SMARTY->assign('listdata', $listdata);

            $records = $response->items;

        } catch (SoapFault $e) {
            switch ($e->detail->code) {
                case 'clid_not_found':
                    $error['localnumber'] = trans('Invalid value!');
                    break;
                default:
                    error_log(__METHOD__ . ': ' . $e->getMessage());
                    $SESSION->save('adescom_error_code', $e->detail->code);
                    $SESSION->redirect('?m=adescom_error');
                    break;
            }
        }
        
        foreach ($trunks as $trunk) {
            $trunk_names[$trunk['nr']] = $trunk['name'];
        }
        $SMARTY->assign('trunknames', $trunk_names);
        
        
    } else {
        foreach ($errors as $i => $error) {
            $errors[$i] = trans($error);
        }
        $SMARTY->assign('error', $errors);
    }
    
}

$layout['pagetitle'] = trans('Billing records');

$SESSION->save('filter', $filter);
$SESSION->save('backto', $_SERVER['QUERY_STRING']);

$SMARTY->assign('records', $records);
$SMARTY->assign('voipaccounts', $voip_accounts);
$SMARTY->assign('filter', $filter);
$SMARTY->assign('clients_names', $clients_names);

$SMARTY->display('billinglist.tpl');