<?php

$error_code = $SESSION->get('adescom_error_code');
$error_message = null;

switch ((string)$error_code) {
    case 'number_already_in_use':
        $error_message = trans('Specified phone is in use!');
        break;
    case 'number_part_missing':
        $error_message = trans('Missing part of number!');
        break;
    case 'inconsistent_number':
        $error_message = trans('Incosistent number value!');
        break;
    case 'invalid_registration_type':
        $error_message = trans('Invalid registration type!');
        break;
    case 'client_not_found':
        $error_message = trans('Client not found!');
        break;
    case 'unable_save_clid':
        $error_message = trans('Unable to save changes!');
        break;
    case 'invalid_field_value':
        $error_message = trans('Invalid field value!');
        break;
    case 'unable_add_prepaid_amount':
        $error_message = trans('Unable to add prepaid amount!');
        break;
    case 'customer_not_found':
        $error_message = trans('Unable to find billing customer!');
        break;
    default:
        $error_message = trans('Unknown error!');
        break;
}

$layout['pagetitle'] = trans('Internal Server Error');

$SMARTY->assign('error_message', $error_message);
$SMARTY->display('adescom_error.tpl');