<?php

use Adescom\SOAP\PlatformWebservice;
use Adescom\SOAP\Webservices;
use Adescom\SOAP\Common\IntegerArray;
use Adescom\SOAP\Common\StringsArray;
use Adescom\SOAP\Platform\CredentialArray;
use Adescom\SOAP\Platform\PanelUser;

function filter_nested_boolean($value) {
    return filter_var($value, FILTER_VALIDATE_BOOLEAN);
}

function filter_nested_string($value) {
    return filter_var($value, FILTER_SANITIZE_STRING);
}

function filter_nested_integer($value) {
    return filter_var($value, FILTER_VALIDATE_INT);
}

$customer_id_options = array(
    'options' => array(
        'min_range' => 1, 
    )
);

$customer_id = filter_input(INPUT_GET, 'customer_id', FILTER_VALIDATE_INT, $customer_id_options);
if ($customer_id === null) {
    $SESSION->redirect('?m=voipaccountpaneluserlist');
}

$post_validators = array(
    'name' => array(
        'filter' => FILTER_SANITIZE_STRING
    ),
    'password' => array(
        'filter' => FILTER_SANITIZE_STRING
    ),
    'password_repeat' => array(
        'filter' => FILTER_SANITIZE_STRING
    ),
    'enable_webservices' => array(
        'filter' => FILTER_VALIDATE_BOOLEAN,
        'flags' => FILTER_NULL_ON_FAILURE,
    ),
    'enable_sms_webservices' => array(
        'filter' => FILTER_VALIDATE_BOOLEAN,
        'flags' => FILTER_NULL_ON_FAILURE,
    ),
    'clids' => array(
        'filter' => FILTER_CALLBACK,
        'options' => 'filter_nested_string',
    ),
    'trunks' => array(
        'filter' => FILTER_CALLBACK,
        'options' => 'filter_nested_integer',
    ),
    'credentials' => array(
        'filter' => FILTER_CALLBACK,
        'options' => 'filter_nested_boolean',
    ),
);

$post_data = filter_input_array(INPUT_POST, $post_validators);

if ($post_data) {
    
    $errors = array();
    
    if (empty($post_data['name'])) {
        $errors['name'] = trans('Name cannot be empty!');
    }
    
    if (empty($post_data['password'])) {
        $errors['password'] = trans('Password cannot be empty!');
    } else {
        if ($post_data['password'] !== $post_data['password_repeat']) {
            $errors['password_repeat'] = trans('Passwords are different!');
        }
    }
    
    if (empty($errors)) {
        
        $webservice = new PlatformWebservice();
        $webservice->setConnection(AdescomConnection::getConnection());
    
        $webservices = new Webservices();
        $webservices['platform'] = $webservice;
    
        $panel_user_manager = new AdescomPanelUserManager();
        $panel_user_manager->setWebservices($webservices);
    
        $panel_user = new PanelUser();
        $panel_user->setName($post_data['name']);
        $panel_user->setPassword($post_data['password']);
        $panel_user->setEnableWebservices($post_data['enable_webservices']);
        $panel_user->setEnableSMSWebservices($post_data['enable_sms_webservices']);
        if (!empty($post_data['clids'])) {
            $panel_user_clids = new StringsArray();
            $panel_user_clids->setItems($post_data['clids']);
            $panel_user->setClids($panel_user_clids);
        }
        if (!empty($post_data['trunks'])) {
            $panel_user_trunks = new IntegerArray();
            $panel_user_trunks->setItems($post_data['trunks']);
            $panel_user->setTrunks($panel_user_trunks);
        }
        if (!empty($post_data['credentials'])) {
            $panel_user_credentials = new CredentialArray();
            $items = array();
            $credentials = $panel_user_manager->getCredential();
            foreach ($credentials->getItems() as $credential) {
                if (array_key_exists($credential->getName(), $post_data['credentials'])) {
                    $items[] = $credential;
                }
            }
            $panel_user_credentials->setItems($items);
            $panel_user_credentials->setCount(count($items));
            $panel_user->setCredentials($panel_user_credentials);
        }
        
        try {
            $panel_user_manager->addPanelUserForClientByExternalId($customer_id, $panel_user);
            $SESSION->redirect('?m=voipaccountpaneluserlist');
        } catch (SoapFault $sf) {
            $errors['password'] = $sf->getMessage();
        }
        
    }
    
    $SMARTY->assign('error', $errors);
    $SMARTY->assign('post_data', $post_data);
    
}

$clids = $DB->getAll(
    'SELECT phone
    FROM voipaccounts va
    JOIN voip_numbers vn ON vn.voip_account_id = va.id
    WHERE va.ownerid = ?',
    array($customer_id)
);

$layout['pagetitle'] = trans('Add panel user');

$SMARTY->assign('clids', $clids);
$SMARTY->assign('customer_id', $customer_id);

$SMARTY->display('voipaccount/paneluser/add.tpl');