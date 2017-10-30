<?php

/**
 * AdescomGeoLocationManager
 *
 * @author ADESCOM <info@adescom.pl>
 * @package LMSAdescomPlugin
 */
class AdescomGeoLocationManager extends Manager
{
    
    /**
     * @return Adescom\SOAP\Platform\GeoLocationStates States
     */
    public function getGeoLocationStates()
    {
        return $this->webservices['platform']->getGeoLocationStates();
    }
    
    /**
     * @return Adescom\SOAP\Platform\GeoLocationCounties Counties
     */
    public function getGeoLocationCountiesByState($state_id)
    {
        return $this->webservices['platform']->getGeoLocationCountiesByState($state_id);
    }
    
    /**
     * @return Adescom\SOAP\Platform\GeoLocationCommunes Communes
     */
    public function getGeoLocationCommunesByCounty($county_id)
    {
        return $this->webservices['platform']->getGeoLocationCommunesByCounty($county_id);
    }
    
    /**
     * @return Adescom\SOAP\Platform\GeoLocationState State
     */
    public function getGeoLocationState($state_id)
    {
        return $this->webservices['platform']->getGeoLocationState($state_id);
    }
    
    /**
     * @return Adescom\SOAP\Platform\GeoLocationCounty County
     */
    public function getGeoLocationCounty($county_id)
    {
        return $this->webservices['platform']->getGeoLocationCounty($county_id);
    }
    
    /**
     * @return Adescom\SOAP\Platform\GeoLocationCommune Commune
     */
    public function getGeoLocationCommune($commune_id)
    {
        return $this->webservices['platform']->getGeoLocationCommune($commune_id);
    }
    
}
