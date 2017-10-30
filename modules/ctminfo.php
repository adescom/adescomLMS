<?php

use Adescom\SOAP\PlatformWebservice;
use Adescom\SOAP\Webservices;

$webservice = new PlatformWebservice();
$webservice->setConnection(AdescomConnection::getConnection());
    
$webservices = new Webservices();
$webservices['platform'] = $webservice;

$ctm_manager = new AdescomCTMManager();
$ctm_manager->setWebservices($webservices);

$layout['pagetitle'] = trans('CTM informations');

$SMARTY->assign('version', $ctm_manager->getVersion());

$SMARTY->display('ctminfo.tpl');