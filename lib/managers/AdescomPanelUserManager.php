<?php

use Adescom\SOAP\Platform\PanelUser;
use Adescom\SOAP\Platform\PanelUserParams;
use Adescom\SOAP\Platform\GetPanelUsersForClientRequest;

/**
 * AdescomPanelUserManager
 *
 * @author ADESCOM <info@adescom.pl>
 * @package LMSAdescomPlugin
 */
class AdescomPanelUserManager extends Manager
{
    
    public function addPanelUserForClientByExternalId($client_id, PanelUser $panel_user)
    {
        return $this->webservices['platform']->addPanelUserForClientByExternalId($client_id, $panel_user);
    }
    
    public function getCredential()
    {
        return $this->webservices['platform']->getCredential();
    }
    
    public function editPanelUserForClient($panel_user_id, PanelUserParams $parameters)
    {
        return $this->webservices['platform']->editPanelUserForClient($panel_user_id, $parameters);
    }
    
    public function getPanelUsersForClient(GetPanelUsersForClientRequest $request)
    {
        return $this->webservices['platform']->getPanelUsersForClient($request);
    }
    
    public function getPanelUser($panel_user_id)
    {
        return $this->webservices['platform']->getPanelUser($panel_user_id);
    }
    
}
