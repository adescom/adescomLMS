<?php

function module_external_login()
{
    global $SMARTY,$SESSION;
    $userpanel_manager = new AdescomUserpanelManager();
    $username = $userpanel_manager->userpanelGetExternalUserName($SESSION->id);
    if ($username === null) {
        return;
    }
    $response = $userpanel_manager->userpanelExternalLogin($username, ConfigHelper::getConfig('adescom.userpanel_security_template'));
    if ($response === null) {
        return;
    }
    $SMARTY->assign('url', ConfigHelper::getConfig('adescom.userpanel_login_url'));
    $SMARTY->assign('sessionID', $response->sessionID);
    $SMARTY->assign('challengeHash', $response->challengeHash);
    $SMARTY->display('module:external_login.tpl');
}

function module_main()
{
    module_external_login();
}
