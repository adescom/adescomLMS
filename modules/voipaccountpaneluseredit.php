<?php

use Adescom\SOAP\PlatformWebservice;
use Adescom\SOAP\Webservices;
use Adescom\SOAP\Common\StringsArray;
use Adescom\SOAP\Platform\CredentialArray;
use Adescom\SOAP\Platform\PanelUserParam;
use Adescom\SOAP\Platform\PanelUserParams;
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

function check_clids_count_diffs(array $post_data, PanelUser $panel_user)
{
    $panelu_user_clids_count = 0;
    if ($panel_user->getClids() !== null && count($panel_user->getClids()->getItems()) > 0) {
        $panelu_user_clids_count = count($panel_user->getClids()->getItems());
    }
    return count($post_data['clids']) !== $panelu_user_clids_count;
}

function check_trunks_count_diffs(array $post_data, PanelUser $panel_user)
{
    $panelu_user_trunks_count = 0;
    if ($panel_user->getTrunks() !== null && count($panel_user->getTrunks()->getItems()) > 0) {
        $panelu_user_trunks_count = count($panel_user->getTrunks()->getItems());
    }
    return count($post_data['trunks']) !== $panelu_user_trunks_count;
}

function check_credentials_count_diffs(array $post_data, PanelUser $panel_user)
{
    $panelu_user_credentials_count = 0;
    if ($panel_user->getCredentials() !== null && count($panel_user->getCredentials()->getItems()) > 0) {
        $panelu_user_credentials_count = count($panel_user->getCredentials()->getItems());
    }
    return count($post_data['credentials']) !== $panelu_user_credentials_count;
}

function check_clids_entries_diffs(array $post_data, PanelUser $panel_user)
{
    $result = false;
    if ($panel_user->getClids()) {
        foreach ($panel_user->getClids()->getItems() as $clid) {
            if (!in_array($clid, $post_data['clids'])) {
                $result = true;
                break;
            }
        }
    }
    return $result;
}

function check_trunks_entries_diffs(array $post_data, PanelUser $panel_user)
{
    $result = false;
    if ($panel_user->getTrunks()) {
        foreach ($panel_user->getTrunks()->getItems() as $trunk) {
            if (!in_array($trunk, $post_data['trunks'])) {
                $result = true;
                break;
            }
        }
    }
    return $result;
}

function check_credentials_entries_diffs(array $post_data, PanelUser $panel_user)
{
    $result = false;
    if ($panel_user->getCredentials()) {
        foreach ($panel_user->getCredentials()->getItems() as $credential) {
            if (!in_array($credential, $post_data['credentials'])) {
                $result = true;
                break;
            }
        }
    }
    return $result;
}

$id_options = array(
    'options' => array(
        'min_range' => 1, 
    )
);

$customer_id = filter_input(INPUT_GET, 'customer_id', FILTER_VALIDATE_INT, $id_options);
if ($customer_id === null) {
    $SESSION->redirect('?m=voipaccountpaneluserlist');
}

$panel_user_id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT, $id_options);
if ($panel_user_id === null) {
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

$webservice = new PlatformWebservice();
$webservice->setConnection(AdescomConnection::getConnection());

$webservices = new Webservices();
$webservices['platform'] = $webservice;

$panel_user_manager = new AdescomPanelUserManager();
$panel_user_manager->setWebservices($webservices);

$panel_user = $panel_user_manager->getPanelUser($panel_user_id);

if ($post_data) {
    
    $errors = array();
    
    if (empty($post_data['name'])) {
        $errors['name'] = trans('Name cannot be empty!');
    }
    
    if (!empty($post_data['password']) && $post_data['password'] !== $post_data['password_repeat']) {
        $errors['password_repeat'] = trans('Passwords are different!');
    }
    
    if (empty($errors)) {
    
        $parameters = array();
        
        if ($post_data['name'] !== $panel_user->getName()) {
            $parameter = new PanelUserParam();
            $parameter->setName($post_data['name']);
            $parameters[] = $parameter;
            $panel_user->setName($post_data['name']);
        }
        
        if (!empty($post_data['password'])) {
            $parameter = new PanelUserParam();
            $parameter->setPassword($post_data['password']);
            $parameters[] = $parameter;
            $panel_user->setPassword($post_data['password']);
        }
        
        if ($post_data['enable_webservices'] !== $panel_user->getEnableWebservices()) {
            $parameter = new PanelUserParam();
            $parameter->setEnableWebservices($post_data['enable_webservices']);
            $parameters[] = $parameter;
            $panel_user->setEnableWebservices($post_data['enable_webservices']);
        }
        
        if ($post_data['enable_sms_webservices'] !== $panel_user->getEnableSmsWebservices()) {
            $parameter = new PanelUserParam();
            $parameter->setEnableSmsWebservices($post_data['enable_sms_webservices']);
            $parameters[] = $parameter;
            $panel_user->setEnableSmsWebservices($post_data['enable_sms_webservices']);
        }
        
        if (check_clids_count_diffs($post_data, $panel_user) || check_clids_entries_diffs($post_data, $panel_user)) {
            $parameter = new PanelUserParam();
            $panel_user_clids = new StringsArray();
            $panel_user_clids->setItems($post_data['clids']);
            $parameter->setClids($panel_user_clids);
            $parameters[] = $parameter;
            $panel_user->setClids($panel_user_clids);
        }
        
        if (check_trunks_count_diffs($post_data, $panel_user) || check_trunks_entries_diffs($post_data, $panel_user)) {
            $parameter = new PanelUserParam();
            $panel_user_trunks = new IntegersArray();
            $panel_user_trunks->setItems($post_data['trunks']);
            $parameter->setTrunks($panel_user_trunks);
            $parameters[] = $parameter;
            $panel_user->setTrunks($panel_user_trunks);
        }
        
        if (check_credentials_count_diffs($post_data, $panel_user) || check_credentials_entries_diffs($post_data, $panel_user)) {
            $parameter = new PanelUserParam();
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
            $parameter->setCredentials($panel_user_credentials);
            $parameters[] = $parameter;
            $panel_user->setCredentials($panel_user_credentials);
        }
        
        if (!empty($parameters)) {
            
            $panel_user_parameters = new PanelUserParams();
            $panel_user_parameters->setItems($parameters);
            
            try {
                $panel_user_manager->editPanelUserForClient($panel_user->getId(), $panel_user_parameters);
            } catch (SoapFault $sf) {
                $errors['password'] = $sf->getMessage();
            }
            
        }
        
        $SESSION->redirect('?m=voipaccountpaneluserlist');
        
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

if ($panel_user->getCredentials() && $panel_user->getCredentials()->getCount() !== 0) {
    $credentials_selected = array();
    foreach ($panel_user->getCredentials()->getItems() as $credential) {
        $credentials_selected[] = $credential->getName();
    }
    $SMARTY->assign('credentials_selected', $credentials_selected);
}

$layout['pagetitle'] = trans('Edit panel user');

$SMARTY->assign('clids', $clids);
$SMARTY->assign('customer_id', $customer_id);
$SMARTY->assign('panel_user', $panel_user);

$SMARTY->display('voipaccount/paneluser/edit.tpl');