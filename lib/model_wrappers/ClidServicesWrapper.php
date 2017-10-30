<?php

/**
 * ClidServicesWrapper
 *
 * @package 
 
 */
class ClidServicesWrapper extends AdescomModelWrapper
{

    /**
     * Constructs clid services wrapper
     */
    public function __construct()
    {
        $this->model = new ClidServices();
        $this->validator = new ClidServicesValidator();
        $this->defaults = new ClidServicesDefaults();
    }

}
