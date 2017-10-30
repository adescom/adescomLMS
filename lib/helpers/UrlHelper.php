<?php

/**
 * UrlHelper
 *
 
 */
class UrlHelper
{

    public static function isDomainAvailible($domain)
    {
        $available = false;
        if (self::checkUrlIsValid($domain)) {
            $curl_init = curl_init($domain);
            curl_setopt($curl_init, CURLOPT_CONNECTTIMEOUT, 10);
            curl_setopt($curl_init, CURLOPT_HEADER, true);
            curl_setopt($curl_init, CURLOPT_NOBODY, true);
            curl_setopt($curl_init, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($curl_init, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($curl_init, CURLOPT_FOLLOWLOCATION, true);
            $available = curl_exec($curl_init);
            if (!$available) {
                error_log(__METHOD__ . ': CURL ERROR: ' . curl_error($curl_init));
            }
            curl_close($curl_init);
        } else {
            error_log(__METHOD__ . ': Domain is not a valid URL');
        }
        return $available;
    }
    
    private static function checkUrlIsValid($domain)
    {
        $valid = true;
        if (ConfigHelper::checkValue(ConfigHelper::getConfig('adescom.check_url_is_valid', true))) {
            $valid = filter_var($domain, FILTER_VALIDATE_URL) !== false;
        }
        return $valid;
    }

}
