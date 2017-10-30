<?php

/**
 * AdescomLiabilityManager
 *
 * @author ADESCOM <info@adescom.pl>
 */
class AdescomLiabilityManager
{
    /**
     * Sets client liability
     * 
     * @param int $clientID Client id
     * @param string $name Liability name
     * @param array $liability Liability
     * @param AdescomSoapClient $connection Connection
     * @return stdClass Result
     */
    public function setClientLiability($clientID, $name, array $liability, AdescomSoapClient $connection = null)
    {
        if ($connection === null) {
            $connection = AdescomConnection::getConnection();
        }

        $entry = new stdClass();
        $entry->clientID = $clientID;
        $entry->name = $name;
        $entry->settlement = $liability['settlement'];
        $entry->fraction = $liability['fraction'];
        $entry->history = new stdClass();
        $entry->history->items = array();

        foreach ($liability['history'] as $history) {
            $history_entry = new stdClass();
            $history_entry->date = $history['date'];
            $history_entry->price = str_replace(',', '.', $history['price']);
            $entry->history->items[] = $history_entry;
        }
        
        $entry->history->count = count($entry->history->items);
        return $connection->setClientLiabilityByExternalID($clientID, $entry);
    }

    /**
     * Returns client liability
     * 
     * @param int $clientID Client id
     * @param string $name Liability name
     * @param AdescomSoapClient $connection Connection
     * @return array Liabilities
     */
    public function getClientLiability($clientID, $name, AdescomSoapClient $connection = null)
    {
        if ($connection === null) {
            $connection = AdescomConnection::getConnection();
        }
        $liability = $connection->getClientLiabilityByExternalID($clientID, $name);
        return $this->getLiabilityArray($liability);
    }
    
    /**
     * Deletes client liability
     * 
     * @param int $clientID Client id
     * @param string $name Liability name
     * @param int $id Liability id
     * @param AdescomSoapClient $connection Connection
     */
    public function deleteClientLiability($clientID, $name, $id, AdescomSoapClient $connection = null)
    {
        if ($connection === null) {
            $connection = AdescomConnection::getConnection();
        }
        $connection->deleteClientLiabilityByExternalID($clientID, $name, $id);
    }
    
    /**
     * Converts libility object to array
     * 
     * @param stdClass $liability Liability
     * @return array Liability
     */
    static private function getLiabilityArray(stdClass $liability)
    {
        $item = array();
        $item['clientid'] = $liability->clientExternalID;
        $item['name'] = $liability->name;
        $item['history'] = array();
        $item['settlement'] = $liability->settlement;
        $item['fraction'] = $liability->fraction;

        $time = time();

        $current_history = null;

        if (is_array($liability->history->items)) {
            foreach ($liability->history->items as $entry) {
                $stamp = strtotime($entry->date);

                $history_item = array();

                $history_item['date'] = $stamp;
                $history_item['price'] = $entry->price;
                $history_item['id'] = $entry->id;

                $item['history'][] = $history_item;

                if ($stamp <= $time) {
                    $current_history = $history_item;
                }
            }
        }

        $item['current_history'] = $current_history;
        return $item;
    }

}
