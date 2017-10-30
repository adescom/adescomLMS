<?php

use Adescom\SOAP\PlatformWebservice;
use Adescom\SOAP\Webservices;

/**
 * VoipAccountListHandler
 *
 
 */
class VoipAccountListHandler
{
    
    private $xajax;

    /**
     * Adds some data to VoIP accounts list template
     * 
     * @param array $hook_data Hook data
     * @return array Hook data
     */
    public function voipAccountListBeforeDisplay(array $hook_data)
    {
        global $SESSION;

        try {
            if (!empty($hook_data['voipaccountlist'])) {
                $db = LMSDB::getInstance();
                foreach ($hook_data['voipaccountlist'] as &$voipaccount) {
                    $voipaccount['phone'] = $db->GetOne(
                        'SELECT phone FROM voip_numbers WHERE voip_account_id = ? ORDER BY number_index LIMIT 1', 
                        array($voipaccount['id'])
                    );
                    $clids[] = $voipaccount['phone'];
                }
                
                $webservice = new PlatformWebservice();
                $webservice->setConnection(AdescomConnection::getConnection());

                $webservices = new Webservices();
                $webservices['platform'] = $webservice;

                $clid_manager = new AdescomClidManager();
                $clid_limit_manager = new AdescomClidLimitManager();
                $tariff_manager = new AdescomTariffManager();
                $tariff_manager->setWebservices($webservices);
                
                $clids_status = $clid_manager->getCLIDsStatus($clids);
                $clids_postpaid_limits = $clid_limit_manager->getCLIDsPostpaidLimits($clids);
                $soap_clids = $clid_manager->getCLIDs($clids);
                $tariffs = $tariff_manager->getTariffs();
                
                $clid_ported = array();
                $clid_active = array();

                foreach ($soap_clids as $soap_clid) {
                    $callerid = $soap_clid['callerid'];

                    if ($soap_clid['ported'] == true) {
                        $clid_ported[] = $callerid;
                    }

                    if ($soap_clid['active'] == true) {
                        $clid_active[] = $callerid;
                    }
                    
                    $soap_clids_assoc[$callerid] = $soap_clid;
                }

                foreach ($clids_status as $clid_status) {
                    $callerid = $clid_status['callerID'];
                    $clids_status_assoc[$callerid] = $clid_status;
                }

                foreach ($clids_postpaid_limits as $clid_postpaid_limits) {
                    $callerid = $clid_postpaid_limits['callerID'];
                    $clids_postpaid_limits_assoc[$callerid] = $clid_postpaid_limits;
                }

                foreach ($hook_data['voipaccountlist'] as &$voipaccount) {

                    $phone = $voipaccount['phone'];

                    $clid_status = isset($clids_status_assoc[$phone]) ? $clids_status_assoc[$phone] : null;
                    $clid_postpaid_limits = isset($clids_postpaid_limits_assoc[$phone]) ? $clids_postpaid_limits_assoc[$phone] : null;

                    $voipaccount['status'] = $clid_status ? $clid_status['status'] : 0;
                    $voipaccount['ip_address'] = $clid_status ? $clid_status['ip_address'] : null;
                    $voipaccount['port'] = $clid_status ? $clid_status['port'] : null;
                    $voipaccount['ctm_node_name'] = $clid_status ? $clid_status['ctm_node_name'] : null;

                    if ($clid_postpaid_limits) {
                        $voipaccount['absolute_limit'] = $clid_postpaid_limits['absoluteLimit'];
                    }

                    foreach ($tariffs->getItems() as $t) {
                        if ($t->getId() === $soap_clids_assoc[$phone]['tariffid']) {
                            $voipaccount['tariff'] = $t;
                            break;
                        }
                    }
                    
                    if ($voipaccount['passwd'] !== $soap_clids_assoc[$phone]['passwd']) {
                        $voipaccount['passwd_missmatch'] = true;
                        $voipaccount['passwd'] = $soap_clids_assoc[$phone]['passwd'];
                    }
                    
                }
            }
        } catch (SoapFault $e) {
            error_log(__METHOD__ . ': ' . $e->getMessage());
            $SESSION->save('adescom_error_code', $e->detail->code);
            $SESSION->redirect('?m=adescom_error');
        } catch (Exception $e) {
            error_log(__METHOD__ . ': ISE');
            $SESSION->save('adescom_error_code', 'ise');
            $SESSION->redirect('?m=adescom_error');
        }

        return $hook_data;
    }

    public function voipAccountListOnLoad()
    {
        global $SMARTY, $LMS;

        require_once(LIB_DIR . '/xajax/xajax_core/xajax.inc.php');
        $this->xajax = new xajax();
        $LMS->xajax = $this->xajax;
        $this->xajax->configure('errorHandler', true);
        if (property_exists('xajaxScriptPlugin', 'sJavaScriptURI')) {
            $this->xajax->configure('javascript URI', 'img/xajax_js');
            $this->xajax->configure('javascript Dir', SYS_DIR . DIRECTORY_SEPARATOR . 'img' . DIRECTORY_SEPARATOR . 'xajax_js');
        } else {
            $this->xajax->configure('javascript URI', 'img');
        }
        $this->xajax->register(XAJAX_FUNCTION, array('load_voip_accounts_states', $this, 'loadVoipAccountsStates'));
        $this->xajax->processRequest();

        $SMARTY->assign('xajax', $this->xajax->getJavascript());
        return;
    }
    
    public function loadVoipAccountsStates(array $voip_accounts_id = array())
    {
        $voip_accounts_manager = new AdescomVoipAccountManager(LMSDB::getInstance());
        $voip_accounts_phone_numbers = $voip_accounts_manager->getPhoneNumbersById($voip_accounts_id);
        
        $phone_numbers = array();
        foreach ($voip_accounts_phone_numbers as $voip_account) {
            $phone_numbers[] = $voip_account['phone'];
        }
        
        $clid_limit_manager = new AdescomClidLimitManager();
        $clids_account_state = $clid_limit_manager->getCLIDsAccountState($phone_numbers);
        
        $response = new xajaxResponse();
        if ($clids_account_state !== null) {
            
            $account_state_template = "voip_account_%d_account_state";
            $account_state_type_template = "voip_account_%d_account_state_type";
            
            $clids_account_state_by_phone = array();
            foreach ($clids_account_state as $account_state) {
                $phone = $account_state['callerID'];
                $clids_account_state_by_phone[$phone] = $account_state;
            }
            
            foreach ($voip_accounts_phone_numbers as $id => $voip_account) {
                $phone = $voip_account['phone'];
                $account_state_id = sprintf($account_state_template, $id);
                $account_state_type_id = sprintf($account_state_type_template, $id);
                if (array_key_exists($phone, $clids_account_state_by_phone)) {
                    $account_state = $clids_account_state_by_phone[$phone];
                    if ($account_state['isPrepaid']) {
                        $response->assign($account_state_type_id, 'innerHTML', trans('Yes'));
                    } else {
                        $response->assign($account_state_type_id, 'innerHTML', trans('No'));
                    }
                    $response->assign($account_state_id, 'innerHTML', moneyf($account_state['value']));
                } else {
                    $response->assign($account_state_type_id, 'innerHTML', trans('No data'));
                    $response->assign($account_state_id, 'innerHTML', trans('No data'));
                }
            }
        }
        return $response;
    }
    
}
