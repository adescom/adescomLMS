<?php

use Adescom\SOAP\Platform\BillingQueryOptions;
use Adescom\SOAP\Platform\BillingQueryOrderBy;
use Adescom\SOAP\Platform\BillingQueryOrderByList;
use Adescom\SOAP\Common\StringsArray;
use Adescom\SOAP\Platform\BillingClientQueryOptions;

/**
 * AdescomBillingManager
 *
 * @author ADESCOM <info@adescom.pl>
 */
class AdescomBillingManager extends Manager
{

    public function getBillingForClients(array $clients, array $filter, array $clients_voip_accounts)
    {
        if (!empty($filter['remoteMask'])) {
            $remote_mask = new StringsArray();
            $remote_mask->setItems(array($filter['remoteMask']));
            $filter['remoteMask'] = $remote_mask;
        } else {
            unset($filter['remoteMask']);
        }
        
        $local_numbers = ArrayHelper::arrayGetValue('clientExtraClids', $filter);
        if (!empty($local_numbers)) {
            $client_extra_clids_items = array();
            foreach ($local_numbers as $voip_id) {
                foreach ($clients_voip_accounts as $client_voips) {
                    if (array_key_exists($voip_id, $client_voips)) {
                        $client_extra_clids_items[] = $client_voips[$voip_id]['phone'];
                        break;
                    }
                }
            }
            if (!empty($client_extra_clids_items)) {
                $client_extra_clids = new StringsArray();
                $client_extra_clids->setItems($client_extra_clids_items);
                $client_extra = new BillingClientQueryOptions();
                $client_extra->setClids($client_extra_clids);
                $filter['clientExtra'] = $client_extra;
            }
        }
        
        $filter['page'] -= 1;
        
        unset($filter['clientExtraClids']);
        
        $response = $this->webservices['platform']->getBillingForClientsByExternalID(
            $clients,  $filter['fromDate'], $filter['toDate'], $this->prepareBillingQueryOptions($filter)
        );
        
        $records = new stdClass();
        $records->items = array();

        if (property_exists($response, 'totalCount')) {
            $records->total = $response->totalCount;
        }

        if (property_exists($response, 'totalPrice')) {
            $records->totalPrice = $response->totalPrice;
        }

        if (property_exists($response, 'totalDuration')) {
            $records->totalDuration = $response->totalDuration;
        }

        if (is_array($response->items)) {
            foreach ($response->items as $record) {
                $records->items[] = self::getCDRArray($record);
            }
        }

        return $records;
    }
    
    /**
     * Converts CDR object to CDR array
     * 
     * @param stdClass $cdr CDR object
     * @return array CDR array
     */
    static private function getCDRArray(stdClass $cdr = null)
    {
        if ($cdr === null) {
            return null;
        }

        $result = array();
        $result['id'] = $cdr->id;
        $result['start_date'] = strtotime($cdr->startDate);
        $result['end_date'] = strtotime($cdr->endDate);
        $result['duration'] = $cdr->duration;
        $result['outgoing'] = $cdr->outgoing;
        $result['source'] = $cdr->source;
        $result['destination'] = $cdr->destination;
        $result['price'] = $cdr->price;
        $result['fraction'] = $cdr->fraction;
        $result['prefix'] = $cdr->prefix;
        $result['prefix_name'] = $cdr->prefixName;
        $result['tg_in'] = $cdr->tgInNr;
        $result['tg_out'] = $cdr->tgOutNr;

        return $result;
    }
    
    public function prepareBillingQueryOptions(array $filter)
    {
        $billing_query_options = new BillingQueryOptions();
        $billing_query_options->setIncoming(ArrayHelper::arrayGetValue('incoming', $filter, false));
        $billing_query_options->setOutgoing(ArrayHelper::arrayGetValue('outgoing', $filter, false));
        $billing_query_options->setIncludeZeroDuration(ArrayHelper::arrayGetValue('includezero', $filter, false));
        $billing_query_options->setPage(ArrayHelper::arrayGetValue('page', $filter, 0));
        $billing_query_options->setPerPage(ArrayHelper::arrayGetValue('perPage', $filter, 10));
        $billing_query_options->setClientExtra(ArrayHelper::arrayGetValue('clientExtra', $filter, null));
        $billing_query_options->setOrderBy(ArrayHelper::arrayGetValue('orderBy', $filter, $this->prepareDefaultBillingQueryOptionsOrderBy()));
        $billing_query_options->setCountCDRs(ArrayHelper::arrayGetValue('countCDRs', $filter, true));
        $billing_query_options->setSumCDRs(ArrayHelper::arrayGetValue('sumCDRs', $filter, true));
        return $billing_query_options;
    }
    
    private function prepareDefaultBillingQueryOptionsOrderBy()
    {
        $order_by = new BillingQueryOrderBy();
        $order_by->setName('startDate');
        $order_by->setDescending(true);
        $order_by_list = new BillingQueryOrderByList();
        $order_by_list->setItems(array($order_by));
        return $order_by_list;
    }
    
    public function validateGetBillingForClientsFilters(array $filters)
    {
        $errors = array();
        $this->validateFromDate($filters, $errors);
        $this->validateToDate($filters, $errors);
        return $errors;

    }
    
    private function validateFromDate(array $filters, array &$errors = array())
    {
        if (!isset($filters['fromDate'])) {
            $errors['fromDate'] = 'Date/time is required!';
        } elseif (!strtotime($filters['fromDate'])) {
            $errors['fromDate'] = 'Invalid value!';
        }
    }
    
    private function validateToDate(array $filters, array &$errors = array())
    {
        if (!isset($filters['fromDate'])) {
            $errors['fromDate'] = 'Date/time is required!';
        } elseif (!strtotime($filters['fromDate'])) {
            $errors['fromDate'] = 'Invalid value!';
        }
    }

}
