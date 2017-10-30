<?php

/**
 * InitHandler
 *
 
 */
class InitHandler
{

    /**
     * Sets plugin managers
     * 
     * @param LMS $hook_data Hook data
     */
    public function lmsInit(LMS $hook_data)
    {
        
        require_once 'vendor' . DIRECTORY_SEPARATOR . 'autoload.php';
        
        if ($hook_data->getDb() === null) {
            throw new RuntimeException(__METHOD__ . ': Database connection object is required for Adescom plugin! Check other plugins!');
        }
        
        $ini_only_adescom_settings = array(
            "'wsdl_url'",
            "'location_url'",
            "'username'",
            "'password'",
            "'webservice_type'",
            "'userpanel_global_password'",
            "'userpanel_challange_salt'",
            "'userpanel_login_url'",
            "'userpanel_security_template'",
            "'check_url_is_valid'",
            "'allow_self_signed'",
        );
        
        
        $ini_only_adescom_settings_count = $hook_data->getDb()->GetOne(
            "SELECT COUNT(*) 
            FROM uiconfig 
            WHERE section = 'adescom' 
            AND disabled = 0 
            AND var IN (" . implode(',', $ini_only_adescom_settings) . ")
        ");
        
        if ($ini_only_adescom_settings_count > 0) {
            throw new RuntimeException(__METHOD__ . ': You should not store critical Adescom plugin settings in uiconfig table!');
        }
        
        $hook_data->setFinanaceManager(
            new AdescomFinanceManager(
                $hook_data->getDb(), $hook_data->getAuth(), $hook_data->getCache(), $hook_data->getSyslog()
            )
        );
        $hook_data->setVoipAccountManager(
            new AdescomVoipAccountManager(
                $hook_data->getDb(), $hook_data->getAuth(), $hook_data->getCache(), $hook_data->getSyslog()
            )
        );
        $hook_data->setCustomerManager(
            new AdescomLMSCustomerManager(
                $hook_data->getDb(), $hook_data->getAuth(), $hook_data->getCache(), $hook_data->getSyslog()
            )
        );
        
        $access_table = array(
            'LMSAdescomPlugin_voipsettings' => array(
                'label' => trans('VoIP gateway settings access'),
                'allow_regexp' => '^voipsettings$'
            ),
            'LMSAdescomPlugin_voipassignments' => array(
                'label' => trans('VoIP assignments list access'),
                'allow_regexp' => '^voipassignments$'
            ),
            'LMSAdescomPlugin_billinglist' => array(
                'label' => trans('VoIP billing list access'),
                'allow_regexp' => '^billinglist$'
            ),
            'LMSAdescomPlugin_voipaccountrechargeprepaid' => array(
                'label' => trans('VoIP account recharge prepaid access'),
                'allow_regexp' => '^voipaccountrechargeprepaid$'
            ),
            'LMSAdescomPlugin_voippoolselect' => array(
                'label' => trans('VoIP account pool access access'),
                'allow_regexp' => '^pool(selectnumber|search)$'
            ),
            'LMSAdescomPlugin_voipaccountprint' => array(
                'label' => trans('VoIP account print info access'),
                'allow_regexp' => '^voipaccountprint$'
            ),
        );

        $access = AccessRights::getInstance();
        foreach ($access_table as $name => $permission) {
            $access->appendPermission(new Permission(
                $name,
                $permission['label'],
                $permission['allow_regexp'],
                null
            ));
        }
        
        return $hook_data;
    }

    /**
     * Sets plugin Smarty templates directory
     * 
     * @param Smarty $hook_data Hook data
     * @return \Smarty Hook data
     */
    public function smartyInit(Smarty $hook_data)
    {
        $hook_data->registerPlugin('modifier', 'secs2hms', array('DateTimeHelper', 'secsToHms'));
        
        $template_dirs = $hook_data->getTemplateDir();
        $plugin_templates = $this->getPluginDir() . 'templates';
        array_unshift($template_dirs, $plugin_templates);
        $hook_data->setTemplateDir($template_dirs);
        return $hook_data;
    }

    /**
     * Sets plugin Smarty modules directory
     * 
     * @param array $hook_data Hook data
     * @return array Hook data
     */
    public function modulesDirInit(array $hook_data = array())
    {
        $plugin_modules = $this->getPluginDir() . 'modules';
        array_unshift($hook_data, $plugin_modules);
        return $hook_data;
    }

    /**
     * Sets plugin menu entries
     * 
     * @param array $hook_data Hook data
     * @return array Hook data
     */
    public function menuInit(array $hook_data = array())
    {
        $adescom_submenus = array(
            array(
                'name' => trans('VoIP gateway settings'),
                'link' => '?m=voipsettings',
                'tip' => trans('Allows you to set some global VOIP settings'),
                'prio' => 100,
            ),
            array(
                'name' => trans('VoIP assignments'),
                'link' => '?m=voipassignments',
                'tip' => trans('Shows VoIP assignments list'),
                'prio' => 110,
            ),
            array(
                'name' => trans('VoIP billing'),
                'link' => '?m=billinglist',
                'tip' => trans('Shows VoIP billing list'),
                'prio' => 120,
            ),
            array(
                'name' => trans('Panel users'),
                'link' => '?m=voipaccountpaneluserlist',
                'tip' => trans('Shows VoIP panel users list'),
                'prio' => 130,
            ),
            array(
                'name' => trans('CTM informations'),
                'link' => '?m=ctminfo',
                'tip' => trans('Shows CTM details'),
                'prio' => 140,
            ),
        );
        $hook_data['VoIP']['submenu'] = array_merge($hook_data['VoIP']['submenu'], $adescom_submenus);
        return $hook_data;
    }
    
    private function getPluginDir()
    {
        return PLUGINS_DIR . DIRECTORY_SEPARATOR . LMSAdescomPlugin::PLUGIN_DIRECTORY_NAME . DIRECTORY_SEPARATOR;
    }

}
