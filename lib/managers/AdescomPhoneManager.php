<?php

/**
 * AdescomPhoneManager
 *
 * @author ADESCOM <info@adescom.pl>
 */
class AdescomPhoneManager
{
    /**
     * Returns phones
     * 
     * @param AdescomSoapClient $connection Connection
     * @return array Phones
     */
    public function getPhones(AdescomSoapClient $connection = null)
    {
        if ($connection === null) {
            $connection = AdescomConnection::getConnection();
        }

        $response = $connection->getPhones();
        $results = array();
        if (is_array($response->phones)) {
            foreach ($response->phones as $phone) {
                $results[$phone->id] = array('id' => $phone->id, 'name' => $phone->name, 'lines' => $phone->lines);
            }
        }
        if (is_array($response->items)) {
            foreach ($response->items as $phone) {
                $results[$phone->id] = array('id' => $phone->id, 'name' => $phone->name, 'lines' => $phone->lines);
            }
        }

        return $results;
    }

    /**
     * Returns phone
     * 
     * @param int $id Phone id
     * @param AdescomSoapClient $connection Connection
     * @return array Phone
     */
    public function getPhone($id, AdescomSoapClient $connection = null)
    {
        if ($connection === null) {
            $connection = AdescomConnection::getConnection();
        }

        $phone = $connection->getPhone($id);

        if ($phone === null) {
            return null;
        }

        return array('id' => $phone->id, 'name' => $phone->name, 'lines' => $phone->lines);
    }
}
