<?php

/**
 * DateTimeHelper
 *
 
 */
class DateTimeHelper
{
    const DATE_TRUNC_STEP_YEAR = 'year';
    const DATE_TRUNC_STEP_MONTH = 'month';
    const DATE_TRUNC_STEP_DAY = 'day';
    const DATE_TRUNC_STEP_HOUR = 'hour';
    
    /**
     * Truncates date
     * 
     * @param mixed $date Date
     * @param string $step Step
     * @param boolean $upper Upper round
     * @return array
     * @throws Exception If unknown date trunc step
     */
    public static function dateTrunc($date, $step, $upper = false)
    {
        if (!is_array($date)) {
            $date = self::dateParseStamp($date);
        }

        // parse step value
        switch ($step) {
            case self::DATE_TRUNC_STEP_YEAR:
                $date['month'] = $upper ? 12 : 1;
                // fallthrough
            case self::DATE_TRUNC_STEP_MONTH:
                $num = cal_days_in_month(CAL_GREGORIAN, intval($date['month']), intval($date['year']));
                $date['day'] = $upper ? $num : 1;
                // fallthrough
            case self::DATE_TRUNC_STEP_DAY:
                $date['hour'] = $upper ? 23 : 0;
                // fallthrough
            case self::DATE_TRUNC_STEP_HOUR:
                $date['second'] = $upper ? 59 : 0;
                $date['minute'] = $upper ? 59 : 0;
                break;
            default:
                throw new Exception('Unknow date trunc step!');
        }

        return $date;
    }

    /**
     * Converts timestamp to date array
     * 
     * @param int $stamp Timestamp
     * @return array Date
     */
    public static function dateParseStamp($stamp)
    {
        return date_parse(date("Y-m-d H:i:s", $stamp));
    }

    /**
     * Converts date array to timestamp
     * 
     * @param array $arr Date
     * @return int Timestamp
     */
    public static function parseDateArray(array $arr)
    {
        return mktime(
            isset($arr['hour']) ? (int) $arr['hour'] : 0,
            isset($arr['minute']) ? (int) $arr['minute'] : 0,
            isset($arr['second']) ? (int) $arr['second'] : 0,
            isset($arr['month']) ? (int) $arr['month'] : 0,
            isset($arr['day']) ? (int) $arr['day'] : 0,
            isset($arr['year']) ? (int) $arr['year'] : 0
        );
    }

    /**
     * Converts seconds to H:m:s format
     * 
     * @param int $secs Seconds
     * @return string Time in H:m:s format
     */
    public static function secsToHms($secs)
    {
        if ($secs < 0) {
            return '00:00:00';
        }

        $m = (int) ($secs / 60);
        $s = $secs % 60;
        $h = (int) ($m / 60);
        $m = $m % 60;

        $h = str_pad($h, 2, "0", STR_PAD_LEFT);
        $m = str_pad($m, 2, "0", STR_PAD_LEFT);
        $s = str_pad($s, 2, "0", STR_PAD_LEFT);

        return $h . ':' . $m . ':' . $s;
    }

}
