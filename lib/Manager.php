<?php

use Adescom\SOAP\Webservices;

/**
 * Manager
 *
 
 * @package LMSAdescomPlugin
 */
abstract class Manager
{
    
    /** @var Webservices Webservice */
    protected $webservices;
    
    public function setWebservices(Webservices $webservices)
    {
        $this->webservices = $webservices;
    }
    
}
