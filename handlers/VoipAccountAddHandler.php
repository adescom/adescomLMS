<?php

use Adescom\SOAP\PlatformWebservice;
use Adescom\SOAP\Webservices;

/**
 * VoipAccountAddHandler
 *
 
 */
class VoipAccountAddHandler extends VoipAccountHandlerAbstract
{

    private $xajax;

    /**
     * Triggers after phone is selected. Returns additional options.
     * 
     * @param int $phoneid Phone id
     * @param string $phone_line_templates Template name
     * @return \xajaxResponse Response
     */
    public function select_phone($phoneid, $phone_line_templates = null)
    {
        return parent::select_phone($phoneid, 'voipaccount/voipaccountlines.tpl');
    }
    
    /**
     * Adds some actions on load of VoIP account add module
     * 
     * @global Smarty $SMARTY Smarty
     * @global Session $SESSION Session
     * @return null
     */
    public function voipAccountAddOnLoad()
    {
        global $SMARTY, $SESSION;

        if (isset($_POST['pool_search'])) {
            if (isset($_POST['voipaccountdata'])) {
                $SESSION->save('voipaccountdata', $_POST['voipaccountdata']);
            }

            $SESSION->save('pool_search_ref', '?m=voipaccountadd&return=true');

            $SESSION->redirect('?m=poolsearch&pool=' . $_POST['pool_search']);

            die();
        }

        require_once(LIB_DIR . '/xajax/xajax_core/xajax.inc.php');
        $this->xajax = new xajax();
        $this->xajax->configure('errorHandler', true);
        if (property_exists('xajaxScriptPlugin', 'sJavaScriptURI')) {
            $this->xajax->configure('javascript URI', 'img/xajax_js');
            $this->xajax->configure('javascript Dir', SYS_DIR . DIRECTORY_SEPARATOR . 'img' . DIRECTORY_SEPARATOR . 'xajax_js');
        } else {
            $this->xajax->configure('javascript URI', 'img');
        }
        $this->xajax->register(XAJAX_FUNCTION, array('select_phone', $this, 'select_phone'));
        $this->xajax->register(XAJAX_FUNCTION, array('pool_first_free', $this, 'pool_first_free'));
        $this->xajax->register(XAJAX_FUNCTION, array('generate_license', $this, 'generate_license'));
        $this->xajax->register(XAJAX_FUNCTION, array('customer_email', $this, 'customer_email'));
        $this->xajax->register(XAJAX_FUNCTION, array('getGeoLocationCountiesByState', $this, 'getGeoLocationCountiesByState'));
        $this->xajax->register(XAJAX_FUNCTION, array('getGeoLocationCommunesByState', $this, 'getGeoLocationCommunesByState'));
        $this->xajax->register(XAJAX_FUNCTION, array('load_voip_accounts_states', 'VoipAccountListHandler', 'loadVoipAccountsStates'));
        $this->xajax->processRequest();

        $SMARTY->assign('xajax', $this->xajax->getJavascript());
        return;
    }

    /**
     * Adds some validation before VoIP add form is submitted
     * 
     * @param array $hook_data Hook data
     * @return array Hook data
     */
    public function voipAccountAddBeforeSubmit(array $hook_data)
    {
        global $DB;
        
        $errors = !empty($hook_data['error']) ? $hook_data['error'] : array();
        
        unset($errors['login']);
        unset($errors['phone']);
        unset($errors['passwd']);
        
        $model = new ClidWrapper();
        $model->fromArray($hook_data['voipaccountdata']);
        $model->prepareLogin();
        $model->preparePhone();
        $model->validate();
        
        $hook_data['voipaccountdata'] = $model->toArray();
        $hook_data['error'] = array_merge($errors, $model->getErrors());
        if (!empty($hook_data['error'])) {
            // propagate error info to voipAccountAddBeforeDisplay
            $hook_data['voipaccountdata']['error'] = true;
        }
        
        $customer_zip = $DB->getOne('SELECT zip FROM customers WHERE id = ?', array($hook_data['voipaccountdata']['ownerid']));
        if (empty($customer_zip)) {
            $customer_zip = $DB->getOne('SELECT a.zip FROM addresses a WHERE a.id = (select address_id from customer_addresses ca where ca.type = 1 and ca.customer_id = ?)', array($hook_data['voipaccountdata']['ownerid']));
            if (empty($customer_zip)) {
                $hook_data['error']['customerid'] = trans('Customer has not zip code!');
            }
        }
        
        return $hook_data;
    }

    /**
     * Calls some Adescom webservices after VoIP add form is saved
     * 
     * @param array $hook_data Hook data
     * @return array Hook data
     */
    public function voipAccountAddAfterSubmit($hook_data)
    {
        return $hook_data;
    }

    /**
     * Adds some data to VoIP add form template
     * 
     * @global Session $SESSION Session
     * @param array $hook_data Hook data
     * @return array Hook data
     */
    public function voipAccountAddBeforeDisplay(array $hook_data)
    {
        global $SESSION;
        
        $webservice = new PlatformWebservice();
        $webservice->setConnection(AdescomConnection::getConnection());

        $webservices = new Webservices();
        $webservices['platform'] = $webservice;
        
        $ctm_manager = new AdescomCTMManager();
        $phone_manager = new AdescomPhoneManager();
        $context_manager = new AdescomContextManager();
        $tariff_manager = new AdescomTariffManager();
        $pool_manager = new AdescomPoolManager();
        $clid_services_manager = new AdescomClidServiceManager();
        $geolocation_manager = new AdescomGeoLocationManager();
        
        $geolocation_manager->setWebservices($webservices);
        $tariff_manager->setWebservices($webservices);
        
        $ctms = $ctm_manager->getCTMNodes();
        $phones = $phone_manager->getPhones();
        $contexts = $context_manager->getContexts(false);
        $contexts_emergency = $context_manager->getContexts(true);
        $contexts_emergency_states = $geolocation_manager->getGeoLocationStates();
        $tariffs = $tariff_manager->getTariffs();
        $pools = $pool_manager->getAllPools();
        $blocklevels = $clid_services_manager->getBlockLevels();
        
        $hook_data['smarty']->assign('ctms', $ctms);
        $hook_data['smarty']->assign('phones', $phones);
        $hook_data['smarty']->assign('contexts', $contexts);
        $hook_data['smarty']->assign('contexts_emergency', $contexts_emergency);
        $hook_data['smarty']->assign('contexts_emergency_states', $contexts_emergency_states);
        $hook_data['smarty']->assign('voip_tariffs', $tariffs);
        $hook_data['smarty']->assign('pools', $pools);
        $hook_data['smarty']->assign('blocklevels', $blocklevels);

        if (isset($_GET['return'])) {
            $SESSION->restore('voipaccountdata', $hook_data['voipaccountdata']);
        }
        
        $model = new ClidWrapper();
        $model->fromArray($hook_data['voipaccountdata']);
        if (!isset($hook_data['voipaccountdata']['error'])) {
            $model->setDefaults();
        }
        
        $hook_data['voipaccountdata'] = array_filter($model->toArray());
        
        if (isset($hook_data['voipaccountdata']['phoneid'])) {
            $selectedPhone = ArrayHelper::arrayGetValue($hook_data['voipaccountdata']['phoneid'], $phones);
            $hook_data['smarty']->assign('selectedPhone', $selectedPhone);
        }
        
        $hook_data['smarty']->assign('hide_voipaccount_login', ConfigHelper::checkConfig('adescom.hide_voipaccount_login'));
        $hook_data['smarty']->assign('hide_voipaccount_status', ConfigHelper::checkConfig('adescom.hide_voipaccount_status'));
        $hook_data['smarty']->assign('hide_voipaccount_location', ConfigHelper::checkConfig('adescom.hide_voipaccount_location'));
        
        return $hook_data;
    }

}
