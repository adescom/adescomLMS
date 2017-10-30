<?php

/**
 * AdescomCTMManager
 *
 * @author ADESCOM <info@adescom.pl>
 */
class AdescomCTMManager extends Manager
{
    
    /**
     * Returns CTM nodes
     * 
     * @param AdescomSoapClient $connection Connection
     * @return array CTM nodes
     */
    public function getCTMNodes(AdescomSoapClient $connection = null)
    {
        if ($connection === null) {
            $connection = AdescomConnection::getConnection();
        }

        $response = $connection->getCTMNodeList();

        $results = array();

        if (is_array($response->items)) {
            foreach ($response->items as $ctm) {
                $results[$ctm->id] = array('id' => $ctm->id, 'name' => $ctm->name);
            }
        }

        return $results;
    }
    
    public function getVersion()
    {
        $version = '';
        try {
            $version = $this->webservices['platform']->getVersion();
        } catch (SoapFault $ex) {
            error_log(__METHOD__ . ': ' . $ex->getMessage());
            $version = trans('software version cannot be defined!');
        }
        return $version;
    }
    
}
