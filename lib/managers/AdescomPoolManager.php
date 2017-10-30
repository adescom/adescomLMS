<?php

/**
 * AdescomPoolManager
 *
 * @author ADESCOM <info@adescom.pl>
 */
class AdescomPoolManager
{
    /**
     * Returns pools
     * 
     * @param AdescomSoapClient $connection Connection
     * @return array Pools
     * @throws Exception if webservice is unknown
     */
    public function getAllPools(AdescomSoapClient $connection = null)
    {
        if ($connection === null) {
            $connection = AdescomConnection::getConnection();
        }
        $webservices_type = ConfigHelper::getConfig('adescom.webservices_type');
        switch ($webservices_type) {
            case AdescomConnection::PLATFORM_WEBSERVICE:
                $response = $connection->getPools();
                break;
            case AdescomConnection::FRONTEND_WEBSERVICE:
                $response = $connection->getNumberPools();
                break;
            default:
                throw new Exception('Unknown webservice type!'); 
        }

        $pools = array();

        if (is_array($response->pools)) {
            foreach ($response->pools as $item) {
                $pools[] = array(
                    'id' => $item->poolID, 
                    'name' => '', 
                    'countrycode' => $item->countryCode, 
                    'areacode' => $item->areaCode, 
                    'fromnumber' => $item->fromNumber, 
                    'tonumber' => $item->toNumber
                );
            }
        }
        if (is_array($response->items)) {
            foreach ($response->items as $item) {
                $pools[] = array(
                    'id' => $item->id, 
                    'name' => '', 
                    'countrycode' => $item->countryCode, 
                    'areacode' => $item->areaCode, 
                    'fromnumber' => $item->fromNumber, 
                    'tonumber' => $item->toNumber
                );
            }
        }


        return $pools;
    }

    /**
     * Returns pool free numbers
     * 
     * @param int $id Id
     * @param int $total Total
     * @param array $options Options
     * @param AdescomSoapClient $connection Connection
     * @return array Free numbers
     */
    private function getRemotePoolFreeNumbers($id, & $total, array $options = null, AdescomSoapClient $connection = null)
    {
        if ($connection === null) {
            $connection = AdescomConnection::getConnection();
        }

        $page = ArrayHelper::arrayGetValue('page', $options, 1);
        $per_page = ArrayHelper::arrayGetValue('per_page', $options);

        $response = $connection->getFreeNumbersFromPool($id, array('page' => $page - 1, 'perPage' => $per_page));

        $total = $response->totalCount;

        $results = array();

        $webservices_type = ConfigHelper::getConfig('adescom.webservices_type');
        switch ($webservices_type) {
            case AdescomConnection::PLATFORM_WEBSERVICE:
                if (is_array($response->numbers)) {
                    foreach ($response->numbers as $item) {
                        $results[] = array($item->countryCode, $item->areaCode, $item->shortCLID);
                    }
                }
                break;
            case AdescomConnection::FRONTEND_WEBSERVICE:
                if (is_array($response->items)) {
                    foreach ($response->items as $item) {
                        $results[] = array($response->countryCode, $response->areaCode, $item);
                    }
                }
                break;
            default:
                throw new Exception('Unknown webservice type!'); 
        }

        return $results;
    }

    /**
     * Returns pool first free number
     * 
     * @param int $id Pool id
     * @param AdescomSoapClient $connection Connection
     * @return array First free number
     * @throws Exception if webservice is unknown
     */
    public function getPoolFirstFree($id, AdescomSoapClient $connection = null)
    {
        if ($connection === null) {
            $connection = AdescomConnection::getConnection();
        }

        $webservices_type = ConfigHelper::getConfig('adescom.webservices_type');
        switch ($webservices_type) {
            case AdescomConnection::PLATFORM_WEBSERVICE:
                $response = $connection->getNumberFromPool($id, false);
                break;
            case AdescomConnection::FRONTEND_WEBSERVICE:
                $response = $connection->getFirstFreeNumberFromPool($id);
                break;
            default:
                throw new Exception('Unknown webservice type!'); 
        }
        
        if (empty($response)) {
            return null;
        }

        return array($response->countryCode, $response->areaCode, $response->shortCLID);
    }

    /**
     * Returns pool free numbers
     * 
     * @param int $id Pool id
     * @param int $total Total
     * @param array $options Options
     * @param AdescomSoapClient $connection Connection
     * @return array Free numbers
     */
    public function getPoolFreeNumbers($id, & $total, array $options = null, AdescomSoapClient $connection = null)
    {
        return $this->getRemotePoolFreeNumbers($id, $total, $options, $connection);
    }
}
