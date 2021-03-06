<?php

/**
 * Defaults
 *
 * @author ADESCOM <info@adescom.pl>
 */
abstract class AdescomModelDefaults
{
    /**
     * Sets model default value
     * 
     * @param AdescomModel $model AdescomModel
     * @param boolean $force Force flag
     */
    abstract public function setDefaults(AdescomModel $model, $force = false);
}
