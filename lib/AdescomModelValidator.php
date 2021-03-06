<?php

/**
 * AdescomModelValidator
 *
 * @author ADESCOM <info@adescom.pl>
 */
abstract class AdescomModelValidator
{
    protected $errors;

    public function __construct()
    {
        $this->errors = array();
    }
    
    abstract public function validate(AdescomModel $model);
    
    public function getErrors()
    {
        return $this->errors;
    }
}
