<?php

use Adescom\SOAP\PlatformWebservice;
use Adescom\SOAP\Webservices;

/**
 * VoipAccountHandlerAbstract
 *
 * @package 
 
 */
abstract class VoipAccountHandlerAbstract
{
    /**
     * Triggers after phone is selected. Returns additional options.
     * 
     * @global Smarty $SMARTY Smarty
     * @param int $phoneid Phone id
     * @param string $phone_line_templates Template name
     * @return \xajaxResponse Response
     */
    public function select_phone($phoneid, $phone_line_templates = null)
    {
        global $SMARTY;
        $phone_manager = new AdescomPhoneManager();
        $phone = $phone_manager->getPhone($phoneid);
        $SMARTY->assign('phone', $phone);
        $output = $SMARTY->fetch($phone_line_templates);
        $response = new xajaxResponse();
        $response->assign('voipaccountdata_line_parent', 'innerHTML', $output);
        return $response;
    }
    
    /**
     * Triggers after first free request is selected
     * 
     * @param int $poolid Pool id
     * @return \xajaxResponse Response
     */
    public function pool_first_free($poolid)
    {
        $pool_manager = new AdescomPoolManager();
        $number = $pool_manager->getPoolFirstFree($poolid);
        $response = new xajaxResponse();
        if ($number !== null) {
            $response->assign('voipaccountdata_countrycode', 'value', $number[0]);
            $response->assign('voipaccountdata_areacode', 'value', $number[1]);
            $response->assign('voipaccountdata_shortclid', 'value', $number[2]);
        }
        return $response;
    }
    
    /**
     * Triggers after generate license request is selected
     * 
     * @return \xajaxResponse Response
     */
    public function generate_license()
    {
        $clid_manager = new AdescomClidManager();
        $license = $clid_manager->generateCLIDLicense();
        $response = new xajaxResponse();
        $response->assign('voipaccountdata_password', 'value', $license);
        return $response;
    }
    
    /**
     * @global LMS $LMS LMS
     * @param intger $customer_id LMS customer id
     * @return \xajaxResponse Response
     */
    public function customer_email($customer_id)
    {
        global $LMS;
        $customer_email = $LMS->getCustomerEmail($customer_id);
        $response = new xajaxResponse();
        if (!empty($customer_email)) {
            $response->assign('voipaccountdata_email', 'value', $customer_email[0]);
        }
        return $response;
    }
    
    public function getGeoLocationCountiesByState($state_id)
    {
        $geolocation_manager = $this->getGeoLocationManager();
        $counties = $geolocation_manager->getGeoLocationCountiesByState($state_id);
        $options = array();
        $option_template = "<option value='%d'>%s</option>";
        if ($counties->getCount()) {
            foreach ($counties->getItems() as $county) {
                $options[] = sprintf($option_template, $county->getId(), $county->getName());
            }
        }
        
        $response = new xajaxResponse();
        $response->assign('select_county', 'innerHTML', implode('', $options));
        return $response;
    }
    
    public function getGeoLocationCommunesByState($county_id)
    {
        $geolocation_manager = $this->getGeoLocationManager();
        $counties = $geolocation_manager->getGeoLocationCommunesByCounty($county_id);
        $options = array();
        $option_template = "<option value='%s'>%s</option>";
        if ($counties->getCount()) {
            foreach ($counties->getItems() as $county) {
                $options[] = sprintf($option_template, $county->getEmergencyContext(), $county->getName());
            }
        }
        $response = new xajaxResponse();
        $response->assign('select_commune', 'innerHTML', implode('', $options));
        return $response;
    }
    
    /**
     * @return AdescomGeoLocationManager Geo location manager
     */
    private function getGeoLocationManager()
    {
        $webservice = new PlatformWebservice();
        $webservice->setConnection(AdescomConnection::getConnection());
        $webservices = new Webservices();
        $webservices['platform'] = $webservice;
        $geolocation_manager = new AdescomGeoLocationManager();
        $geolocation_manager->setWebservices($webservices);
        return $geolocation_manager;
    }
    
}
