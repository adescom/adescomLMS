<?php

/**
 * DbHelper
 *
 
 * @package LMSAdescomPlugin
 */
class DbHelper
{
    
    public static function groupResultSetByKey($group_key, $result_key = null, array $results = array())
    {
        $grouped_result_set = array();
        if (!empty($results)) {
            if (!array_key_exists($group_key, $results[0])) {
                throw new InvalidArgumentException('Result set has rows but without "group key" colum!');
            } elseif ($result_key !== null && !array_key_exists($result_key, $results[0])) {
                throw new InvalidArgumentException('Result set has rows but without "result key" colum!');
            }
            foreach ($results as $result) {
                if (!array_key_exists($result[$group_key], $grouped_result_set)) {
                    $grouped_result_set[$result[$group_key]] = array();
                }
                if ($result_key !== null) {
                    $grouped_result_set[$result[$group_key]][$result[$result_key]] = $result;
                } else {
                    $grouped_result_set[$result[$group_key]][] = $result;
                }
            }
        }
        return $grouped_result_set;
    }
    
}
