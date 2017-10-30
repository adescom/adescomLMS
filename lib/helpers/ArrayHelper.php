<?php

/**
 * ArrayHelper
 *
 
 */
class ArrayHelper
{
    /**
     * Returns array value for specified key or default value
     * 
     * @param string $name Array key
     * @param mixed $array Array
     * @param mixed $default Default value
     * @return mixed
     */
    public static function arrayGetValue($name, $array, $default = null)
    {
        if (!is_array($array) || !array_key_exists($name, $array)) {
            return $default;
        }

        return $array[$name];
    }

    /**
     * Returns boolean representation of value in array at specified key
     * 
     * @param string $name Array key
     * @param mixed $array Array
     * @param mixed $default Default value
     * @return boolean
     */
    public static function arrayGetBool($name, $array, $default = false)
    {
        return (boolean) self::arrayGetValue($name, $array, $default);
    }

    /**
     * Returns string representation of value in array at specified key
     * 
     * @param string $name Array key
     * @param mixed $array Array
     * @param mixed $default Default value
     * @return string
     */
    public static function arrayGetString($name, $array, $default = '')
    {
        return (string) self::arrayGetValue($name, $array, $default);
    }

    /**
     * Returns associative array where keys are computed by given function
     * 
     * @param array $array Array
     * @param callable $func Function
     * @return array
     */
    public static function arrayToAssocFunc(array $array, $func)
    {
        $assoc = array();

        foreach ($array as $element) {
            $value = call_user_func_array(array($element, $func), array());
            $assoc[$value] = $element;
        }

        return $assoc;
    }

    /**
     * Returns associative array
     * 
     * @param array $array Array
     * @param string|int $key Key
     * @return array
     */
    public static function arrayToAssoc(array $array, $key)
    {
        $assoc = array();

        foreach ($array as $element) {
            $assoc[$element[$key]] = $element;
        }

        return $assoc;
    }

}
