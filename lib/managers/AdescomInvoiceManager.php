<?php

/**
 * AdescomInvoiceManager
 *
 * @author ADESCOM <info@adescom.pl>
 */
class AdescomInvoiceManager
{
    /**
     * Returns invoice positions
     * 
     * @return array Invoice positions
     */
    public function getInvoiceExtraPositions()
    {
        $positions = array();
        $positions['voip_calls'] = array(
            'type' => 'voip_calls', 
            'name' => ConfigHelper::getConfig('adescom.invoice_position_calls_name', 'VOIP calls'),
            'text' => ConfigHelper::getConfig('adescom.invoice_position_calls_text', 'VOIP calls from $a to $b'),
        );
        return $positions;
    }

    /**
     * Returns VoIP calls invoice positions
     * 
     * @param int $customerID Customer id
     * @param string $dateFrom Date from
     * @param string $dateTo Date to
     * @param AdescomSoapClient $connection Connection
     * @return array VoIP invoice positions
     */
    public function getVoipCallsInvoicePosition($customerID, $dateFrom, $dateTo, AdescomSoapClient $connection = null)
    {
        if ($connection === null) {
            $connection = AdescomConnection::getConnection();
        }

        $subscribes = array('CLIENT_SUBSCRIBE');

        setlocale(LC_NUMERIC, "POSIX");

        $response = $connection->getBillingForClientByExternalID($customerID, $dateFrom, $dateTo, (object) array('incoming' => false, 'outgoing' => true, 'includeZeroDuration' => false));

        $results = array();

        if (is_array($response->items)) {
            foreach ($response->items as $record) {
                $fraction = $record->fraction;
                $destination = $record->destination;
                $price = $record->priceInclTaxes;
                $period = strtotime($record->startDate);

                if (!$fraction) {
                    continue;
                }

                if (in_array($destination, $subscribes)) {
                    $fraction = 'SUBSCRIBE_' . $record->id;

                    if ($period == $dateTo) {
                        $period += 1;
                    }

                    $subscribe = true;
                } else {
                    $subscribe = false;
                }

                if (!array_key_exists($fraction, $results)) {
                    $results[$fraction] = array('fraction' => $fraction, 'cost' => 0, 'count' => 0, 'period' => $period, 'subscribe' => $subscribe);
                }

                $results[$fraction]['cost'] += $price;
                $results[$fraction]['count'] ++;
            }
        }

        return array_values($results);
    }
    
    
}
