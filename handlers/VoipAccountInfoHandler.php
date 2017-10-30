<?php

use Adescom\SOAP\PlatformWebservice;
use Adescom\SOAP\Webservices;

/**
 * VoipAccountInfoHandler
 *
 
 */
class VoipAccountInfoHandler
{

    /**
     * Adds some data to VoIP account info template
     * 
     * @param array $hook_data Hook data
     * @return array Hook data
     */
    public function voipAccountInfoBeforeDisplay(array $hook_data)
    {
        global $SESSION;
        
        try {
            
            $webservice = new PlatformWebservice();
            $webservice->setConnection(AdescomConnection::getConnection());

            $webservices = new Webservices();
            $webservices['platform'] = $webservice;
            
            $tariff_manager = new AdescomTariffManager();
            $clid_manager = new AdescomClidManager();
            $clid_limits_manager = new AdescomClidLimitManager();
            
            $tariff_manager->setWebservices($webservices);
            
            $caller_id = $hook_data['voipaccountinfo']['phones'][0]['phone'];
            
            $voipdetails = $clid_manager->getCLID($caller_id);
            $state = $clid_limits_manager->getCLIDAccountState($caller_id);
            $status = $clid_manager->getCLIDStatus($caller_id);

            $postpaid_limits = $clid_limits_manager->getCLIDsPostpaidLimits(array($caller_id));
            $tariffs = $tariff_manager->getTariffs();
            foreach ($tariffs->getItems() as $t) {
                if ($t->getId() === $voipdetails['tariffid']) {
                    $voipdetails['tariff'] = $t;
                    break;
                }
            }

            if ($state && $state['valid']) {
                $hook_data['voipaccountinfo']['account_state_type'] = $state['isPrepaid'];
                $hook_data['voipaccountinfo']['account_state'] = $state['value'];
            } else {
                $hook_data['voipaccountinfo']['account_state'] = null;
            }

            if (count($postpaid_limits)) {
                $postpaid_limit = end($postpaid_limits);
                $hook_data['voipaccountinfo']['absolute_limit'] = $postpaid_limit['absoluteLimit'];
            }

            if ($status !== null) {
                $hook_data['voipaccountinfo']['status'] = $status->status;
                $hook_data['voipaccountinfo']['ip_address'] = $status->ipAddress;
                $hook_data['voipaccountinfo']['port'] = $status->port;
            }

            
            $hook_data['voipaccountinfo'] = array_merge($hook_data['voipaccountinfo'], $voipdetails);
            
            
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

}
