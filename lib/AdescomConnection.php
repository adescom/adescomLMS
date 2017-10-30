<?php

/**
 * AdescomConnection
 *
 * @author ADESCOM <info@adescom.pl>
 */
class AdescomConnection
{

    const PLATFORM_WEBSERVICE = 'platform';
    const FRONTEND_WEBSERVICE = 'frontend';

    private static $connection;

    /**
     * Returns Adescom webservice connection
     * 
     * @return AdescomConnection Connection
     */
    public static function getConnection()
    {
        if (self::$connection === null) {
            // connect to our Webservices
            
            $wsdl = ConfigHelper::getConfig('adescom.wsdl_url');
            $location = ConfigHelper::getConfig('adescom.location_url');
            
            if (UrlHelper::isDomainAvailible($wsdl) === false) {
                throw new RuntimeException('Adescom WSDL URL is not valid!');
            }
            if (UrlHelper::isDomainAvailible($location) === false) {
                throw new RuntimeException('Adescom location URL is not valid!');
            }
            
            $soap_options = array(
                'location' => $location,
                'soap_version' => SOAP_1_1,
                'features' => SOAP_SINGLE_ELEMENT_ARRAYS | SOAP_USE_XSI_ARRAY_TYPE,
            );
            
            if (ConfigHelper::checkConfig('adescom.allow_self_signed')) {
                $context = stream_context_create(array(
                    'ssl' => array(
                        'verify_peer' => false,
                        'verify_peer_name' => false,
                        'allow_self_signed' => true
                    )
                ));
                $soap_options['stream_context'] = $context;
            }
            
            self::$connection = new AdescomSoapClient(
                $wsdl, 
                $soap_options
            );

            // login using provided username and password
            $session_id = self::$connection->login(
                ConfigHelper::getConfig('adescom.username'),
                ConfigHelper::getConfig('adescom.password'), 
                3600
            );

            // use returned sessionID for further calls
            self::$connection->__setCookie('sessionID', $session_id);
        }

        // finally return SOAP client object
        return self::$connection;
    }

}
