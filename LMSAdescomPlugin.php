<?php

/**
 * LMSAdescomPlugin
 *
 * @author ADESCOM <info@adescom.pl>
 */
class LMSAdescomPlugin extends LMSPlugin
{
    const PLUGIN_NAME = 'LMS Adescom Plugin';
    const PLUGIN_AUTHOR = 'Adescom';
    const PLUGIN_DIRECTORY_NAME = 'LMSAdescomPlugin';
    const PLUGIN_DESCRIPTION = 'version: 1.4.9';
    
    public function registerHandlers()
    {
        $this->handlers = array(
            'lms_initialized' => array(
                'class' => 'InitHandler',
                'method' => 'lmsInit'
            ),
            'smarty_initialized' => array(
                'class' => 'InitHandler',
                'method' => 'smartyInit'
            ),
            'modules_dir_initialized' => array(
                'class' => 'InitHandler',
                'method' => 'modulesDirInit'
            ),
            'menu_initialized' => array(
                'class' => 'InitHandler',
                'method' => 'menuInit'
            ),
            'voipaccountadd_on_load' => array(
                'class' => 'VoipAccountAddHandler',
                'method' => 'voipAccountAddOnLoad'
            ),
            'voipaccountadd_before_submit' => array(
                'class' => 'VoipAccountAddHandler',
                'method' => 'voipAccountAddBeforeSubmit'
            ),
            'voipaccountadd_before_display' => array(
                'class' => 'VoipAccountAddHandler',
                'method' => 'voipAccountAddBeforeDisplay'
            ),
            'voipaccountedit_on_load' => array(
                'class' => 'VoipAccountEditHandler',
                'method' => 'voipAccountEditOnLoad'
            ),
            'voipaccountedit_before_submit' => array(
                'class' => 'VoipAccountEditHandler',
                'method' => 'voipAccountEditBeforeSubmit'
            ),
            'voipaccountedit_before_display' => array(
                'class' => 'VoipAccountEditHandler',
                'method' => 'voipAccountEditBeforeDisplay'
            ),
            'voipaccountinfo_before_display' => array(
                'class' => 'VoipAccountInfoHandler',
                'method' => 'voipAccountInfoBeforeDisplay'
            ),
            'voipaccountlist_before_display' => array(
                'class' => 'VoipAccountListHandler',
                'method' => 'voipAccountListBeforeDisplay'
            ),
            'voipaccountlist_on_load' => array(
                'class' => 'VoipAccountListHandler',
                'method' => 'voipAccountListOnLoad'
            ),
            'customerassignmentadd_validation_before_submit' => array(
                'class' => 'CustomerAssignmentAddHandler',
                'method' => 'customerAssignmentAddValidationBeforeSubmit'
            ),
            'customerassignmentadd_before_display' => array(
                'class' => 'CustomerAssignmentAddHandler',
                'method' => 'customerAssignmentAddBeforeDisplay'
            ),
            'customerassignmentedit_validation_before_submit' => array(
                'class' => 'CustomerAssignmentEditHandler',
                'method' => 'customerAssignmentEditValidationBeforeSubmit'
            ),
            'customerassignmentedit_after_submit' => array(
                'class' => 'CustomerAssignmentEditHandler',
                'method' => 'customerAssignmentEditAfterSubmit'
            ),
            'customerassignmentedit_before_display' => array(
                'class' => 'CustomerAssignmentEditHandler',
                'method' => 'customerAssignmentEditBeforeDisplay'
            ),
            'customerinfo_on_load' => array(
                'class' => 'VoipAccountListHandler',
                'method' => 'voipAccountListOnLoad'
            ),
            'customeredit_on_load' => array(
                'class' => 'VoipAccountListHandler',
                'method' => 'voipAccountListOnLoad'
            ),
            'voipaccountinfo_on_load' => array(
                'class' => 'VoipAccountListHandler',
                'method' => 'voipAccountListOnLoad'
            ),
            'nodeadd_on_load' => array(
                'class' => 'VoipAccountListHandler',
                'method' => 'voipAccountListOnLoad'
            ),
            'nodeedit_on_load' => array(
                'class' => 'VoipAccountListHandler',
                'method' => 'voipAccountListOnLoad'
            ),
            'nodeinfo_on_load' => array(
                'class' => 'VoipAccountListHandler',
                'method' => 'voipAccountListOnLoad'
            ),
            'nodescan_on_load' => array(
                'class' => 'VoipAccountListHandler',
                'method' => 'voipAccountListOnLoad'
            ),
        );
    }
}
