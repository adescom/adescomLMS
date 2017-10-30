<?php

/**
 * AdescomContextManager
 *
 * @author ADESCOM <info@adescom.pl>
 */
class AdescomContextManager
{
    /**
     * Returns contexts
     * 
     * @param boolean $emergency Emergency
     * @param AdescomSoapClient $connection Connection
     * @return array Contexts
     */
    public function getContexts($emergency = null, AdescomSoapClient $connection = null)
    {
        if ($connection === null) {
            $connection = AdescomConnection::getConnection();
        }

        $response = $connection->getContexts($emergency);

        $results = array();

        if (is_array($response->items)) {
            foreach ($response->items as $context) {
                $results[] = array('name' => $context->name);
            }
        }

        return $results;
    }

}
