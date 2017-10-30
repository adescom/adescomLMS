<?php

use Adescom\SOAP\PlatformWebservice;
use Adescom\SOAP\Webservices;

/**
 * AdescomVoipAccountManager
 *
 * @author ADESCOM <info@adescom.pl>
 */
class AdescomVoipAccountManager extends LMSVoipAccountManager implements LMSVoipAccountManagerInterface
{

    public function getCustomerVoipAccounts($id)
    {
        $customervoipaccounts = parent::getCustomerVoipAccounts($id);

        try {
            
            $client_manager = new AdescomClientManager();
            $client = $client_manager->getClient($id);
            
            if ($client && $customervoipaccounts['accounts'] && !empty($customervoipaccounts['accounts'])) {
                foreach ($customervoipaccounts['accounts'] as &$voipaccount) {
                    $voipaccount['phone'] = $this->db->GetOne(
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
                $clids_details = $clid_manager->getCLIDsForClient($id);
                $clids_limits = $clid_limit_manager->getCLIDsPostpaidLimits($clids);
                $tariffs = $tariff_manager->getTariffs();
                $soap_clids = $clid_manager->getCLIDs($clids);
                
                $soap_clids_assoc = array();
                $clids_status_assoc = array();
                $clids_account_state_assoc = array();
                $clids_details_assoc = array();
                $clids_limits_assoc = array();
                
                foreach ($soap_clids as $soap_clid) {
                    $callerid = $soap_clid['callerid'];
                    $soap_clids_assoc[$callerid] = $soap_clid;
                }

                foreach ($clids_status as $clid_status) {
                    $clids_status_assoc[$clid_status['callerID']] = $clid_status;
                }

                foreach ($clids_details as $clid_details) {
                    $clids_details_assoc[$clid_details['callerid']] = $clid_details;
                }

                foreach ($clids_limits as $clid_limit) {
                    $clids_limits_assoc[$clid_limit['callerID']] = $clid_limit;
                }


                foreach ($customervoipaccounts['accounts'] as &$voipaccount) {
                    $phone = $voipaccount['phone'];

                    $clid_status = isset($clids_status_assoc[$phone]) ? $clids_status_assoc[$phone] : null;
                    $clid_details = isset($clids_details_assoc[$phone]) ? $clids_details_assoc[$phone] : null;
                    $clid_limit = isset($clids_limits_assoc[$phone]) ? $clids_limits_assoc[$phone] : null;

                    $voipaccount['status'] = $clid_status ? $clid_status : 0;

                    if ($clid_details !== null) {
                        $voipaccount['is_prepaid'] = $clid_details['is_prepaid'];
                    }

                    if ($clid_limit !== null) {
                        $voipaccount['absolute_limit'] = $clid_limit['absoluteLimit'];
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
            $this->auth->SESSION->save('adescom_error_code', $e->detail->code);
            $this->auth->SESSION->redirect('?m=adescom_error');
        } catch (Exception $e) {
            error_log(__METHOD__ . ': ISE');
            $this->auth->SESSION->save('adescom_error_code', 'ise');
            $this->auth->SESSION->redirect('?m=adescom_error');
        }

        return $customervoipaccounts;
    }

    public function VoipAccountAdd($voipaccountdata)
    {
        $voipaccountid = null;

        try {
            $this->db->BeginTrans();

            $voipaccountdata['access'] = 1;
            $voipaccountid = parent::voipAccountAdd($voipaccountdata);

            if ($voipaccountid) {
                $client_manager = new AdescomClientManager();
                $clid_manager = new AdescomClidManager();
                $clid_service_manager = new AdescomClidServiceManager();
                $clid_limits_manager = new AdescomClidLimitManager();
                $client = $client_manager->getClient($voipaccountdata['ownerid']);

                
                if ($client === null) {
                    $customer_manager = new LMSCustomerManager($this->db, $this->auth, $this->cache, $this->syslog);
                    $customerinfo = $customer_manager->GetCustomer($voipaccountdata['ownerid']);
                    $customerinfo['tariffid'] = $voipaccountdata['tariffid'];
                    $client_manager->addClient($customerinfo);
                } elseif($client['deleted'] === true) {
                    $webservices_type = ConfigHelper::getConfig('adescom.webservices_type');
                    if ($webservices_type === AdescomConnection::FRONTEND_WEBSERVICE) {
                        $this->db->RollbackTrans();
                        error_log('Client is marked as deleted at CTM and you are using frontend webservices!');
                        header('Location: ?m=adescom_error');
                        die;
                    } else {
                        $restored = $client_manager->restoreClient($voipaccountdata['ownerid']);
                        if (!$restored) {
                            $this->db->RollbackTrans();
                            error_log('Client is marked as deleted at CTM and can not be restored!');
                            header('Location: ?m=adescom_error');
                            die;
                        }
                    }
                }

                $clid_manager->addCLID($voipaccountdata['ownerid'], $voipaccountdata);

                $clid_service_manager->saveCLIDServices($voipaccountdata['phone'][0], $voipaccountdata);

                if (isset($voipaccountdata['is_prepaid'])) {
                    $clid_limits_manager->addCLIDPrepaidAccountState($voipaccountdata['phone'][0], array('expire_date' => null, 'value' => $voipaccountdata['prepaid_state']));
                } elseif (array_key_exists('absolute_cost_limit', $voipaccountdata) && !empty($voipaccountdata['absolute_cost_limit'])) {
                    $clid_limits_manager->setCLIDPostpaidLimit($voipaccountdata['phone'][0], array('absolute_limit' => $voipaccountdata['absolute_cost_limit'], 'relative_limit' => null));
                }
            }
            $this->db->CommitTrans();
        } catch (SoapFault $e) {
            $this->db->RollbackTrans();
            error_log(__METHOD__ . ': ' . $e->getMessage());
            $this->auth->SESSION->save('adescom_error_code', $e->detail->code);
            $this->auth->SESSION->redirect('?m=adescom_error');
        } catch (Exception $e) {
            $this->db->RollbackTrans();
            error_log(__METHOD__ . ': ISE');
            $this->auth->SESSION->save('adescom_error_code', $e->getCode());
            $this->auth->SESSION->redirect('?m=adescom_error');
        }

        return $voipaccountid;
    }

    public function VoipAccountUpdate($voipaccountedit)
    {
        $result = null;
        
        try {
            $this->db->BeginTrans();

            $current_voipaccount_ownerid = parent::getVoipAccountOwner($voipaccountedit['id']);
            
            $result = parent::VoipAccountUpdate($voipaccountedit);

            $clid_manager = new AdescomClidManager();
            $clid_service_manager = new AdescomClidServiceManager();
            $clid_limits_manager = new AdescomClidLimitManager();

            if ($voipaccountedit['ownerid'] !== $current_voipaccount_ownerid) {

                $client_manager = new AdescomClientManager();
                $client = $client_manager->getClient($voipaccountedit['ownerid']);
                if ($client === null) {
                    $customer_manager = new LMSCustomerManager($this->db, $this->auth, $this->cache, $this->syslog);
                    $customerinfo = $customer_manager->GetCustomer($voipaccountedit['ownerid']);
                    $customerinfo['tariffid'] = $voipaccountedit['tariffid'];
                    $client_manager->addClient($customerinfo);
                }
                $current_clid = $clid_manager->getCLID($voipaccountedit['phone'][0]);
                $voipaccountedit['poolid'] = $current_clid['poolid'];
                $voipaccountedit['ported'] = $current_clid['ported'];
                $voipaccountedit['active'] = true;
                $clid_manager->deleteCLID($voipaccountedit['phone'][0]);
                $clid_manager->addCLID($voipaccountedit['ownerid'], $voipaccountedit);
            } else {
                $clid_manager->modifyCLID($voipaccountedit['phone'][0], $voipaccountedit);
            }

            $clid_service_manager->saveCLIDServices($voipaccountedit['phone'][0], $voipaccountedit);

            if (!$voipaccountedit['is_prepaid']) {
                if (array_key_exists('absolute_cost_limit', $voipaccountedit) && !empty($voipaccountedit['absolute_cost_limit'])) {
                    $clid_limits_manager->setCLIDPostpaidLimit(
                            $voipaccountedit['phone'][0], array(
                        'absolute_limit' => $voipaccountedit['absolute_cost_limit'],
                        'relative_limit' => null
                            )
                    );
                }
            }
            $this->db->CommitTrans();
            
        } catch (SoapFault $e) {
            $this->db->RollbackTrans();
            error_log(__METHOD__ . ': ' . $e->getMessage());
            $this->auth->SESSION->save('adescom_error_code', $e->detail->code);
            $this->auth->SESSION->redirect('?m=adescom_error');
        } catch (Exception $e) {
            $this->db->RollbackTrans();
            error_log(__METHOD__ . ': ISE');
            $this->auth->SESSION->save('adescom_error_code', $e->getCode());
            $this->auth->SESSION->redirect('?m=adescom_error');
        }

        return $result;
    }

    public function deleteVoipAccount($id)
    {
        $result = null;

        try {
            $this->db->BeginTrans();
            $clid_manager = new AdescomClidManager();
            $clid_manager->deleteCLID($this->db->GetOne(
                'SELECT phone FROM voip_numbers WHERE voip_account_id = ? ORDER BY number_index LIMIT 1', 
                array($id)
            ));
            $result = parent::deleteVoipAccount($id);
            $this->db->CommitTrans();
        } catch (SoapFault $e) {
            $this->db->RollbackTrans();
            error_log(__METHOD__ . ': ' . $e->getMessage());
            $this->auth->SESSION->save('adescom_error_code', $e->detail->code);
            $this->auth->SESSION->redirect('?m=adescom_error');
        } catch (Exception $e) {
            $this->db->RollbackTrans();
            error_log(__METHOD__ . ': ISE');
            $this->auth->SESSION->save('adescom_error_code', $e->getCode());
            $this->auth->SESSION->redirect('?m=adescom_error');
        }

        return $result;
    }

    public function getPhoneNumbersById(array $id)
    {
        if (empty($id)) {
            return array();
        } else {
            return $this->db->getAllByKey(
                'SELECT voip_account_id AS id, phone FROM voip_numbers vn WHERE voip_account_id IN ('
                . implode(',', array_map('intval', $id))
                . ') AND number_index = (SELECT MIN(number_index) FROM voip_numbers WHERE voip_account_id = vn.voip_account_id)',
                'id'
            );
        }
    }
    
    public function getCustomerVoIPAccountsPhoneNumbers($customer_id)
    {
        $result = array();
        $voip_accounts = $this->db->getAll(
            'SELECT va.id, va.ownerid, vn.phone
            FROM voip_numbers vn
            JOIN voipaccounts va ON vn.voip_account_id = va.id
            WHERE vn.id IN (
                SELECT MIN(id)
                FROM voip_numbers
                GROUP BY voip_account_id
            ) AND va.ownerid = ?',
            array($customer_id)
        );
        if (!empty($voip_accounts)) {
            $result = DbHelper::groupResultSetByKey('ownerid', 'id', $voip_accounts);
        }
        return $result;
    }
    
    public function getCustomersVoIPAccountsPhoneNumbers()
    {
        $result = array();
        $voip_accounts = $this->db->getAll(
            'SELECT va.id, va.ownerid, vn.phone
            FROM voip_numbers vn
            JOIN voipaccounts va ON vn.voip_account_id = va.id
            WHERE vn.id IN (
                SELECT MIN(id)
                FROM voip_numbers
                GROUP BY voip_account_id
            )'
        );
        if (!empty($voip_accounts)) {
            $result = DbHelper::groupResultSetByKey('ownerid', 'id', $voip_accounts);
        }
        return $result;
    }
    
}
