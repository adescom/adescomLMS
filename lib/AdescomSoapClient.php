<?php

/**
 * AdescomSoapClient
 *
 * @author ADESCOM <info@adescom.pl>
 */
class AdescomSoapClient extends SoapClient
{

    /**
     * Calls webservice
     * 
     * @param string $function_name Function name
     * @param array $arguments Arguments
     * @return string Response
     */
    public function __call($function_name, $arguments)
    {
        $old_locale = setlocale(LC_ALL, "0");
        setlocale(LC_ALL, "C");
        $ret = parent::__call($function_name, $arguments);
        setlocale(LC_ALL, $old_locale);
        return $ret;
    }

    public function testConnection()
    {
        // do nothing
    }

}
