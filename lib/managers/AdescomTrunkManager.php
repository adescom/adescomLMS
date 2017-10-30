<?php

/**
 * AdescomTrunkManager
 *
 * @author ADESCOM <info@adescom.pl>
 */
class AdescomTrunkManager
{

    /**
     * Returns client trunks
     * 
     * @param int $clientID Client id
     * @param AdescomSoapClient $connection Connection
     * @return array Trunks
     */
    public function getTrunksForClient($clientID, AdescomSoapClient $connection = null)
    {
        if ($connection === null) {
            $connection = AdescomConnection::getConnection();
        }

        $response = $connection->getTrunkgroupsForClientByExternalID($clientID);

        $results = array();

        if (is_array($response->items)) {
            foreach ($response->items as $trunk) {
                $results[] = self::getTrunkArray($trunk);
            }
        }

        return $results;
    }
    
    /**
     * Returns clients trunks
     * 
     * @param int $clients_id Clients id
     * @param AdescomSoapClient $connection Connection
     * @return array Trunks
     */
    public function getTrunksForClients(array $clients_id, AdescomSoapClient $connection = null)
    {
        $trunks = array();
        foreach ($clients_id as $client_id) {
            $trunks[$client_id] = $this->getTrunksForClient($client_id, $connection);
        }
        return $trunks;
    }

    /**
     * Converts trunk object to array
     * 
     * @param stdClass $trunk Trunk
     * @return array Trunk
     */
    static private function getTrunkArray(stdClass $trunk = null)
    {
        if ($trunk === null) {
            return null;
        }

        $result = array();
        $result['id'] = $trunk->id;
        $result['nr'] = $trunk->nr;
        $result['name'] = $trunk->name;
        return $result;
    }

}
