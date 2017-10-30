<?php

use Adescom\SOAP\Platform\TariffsArray as PlatformTariffs;
use Adescom\SOAP\Frontend\Tariff as FrontendTariff;
use Adescom\SOAP\Frontend\TariffsArray as FrontendTariffs;

/**
 * AdescomTariffManager
 *
 * @author ADESCOM <info@adescom.pl>
 */
class AdescomTariffManager extends Manager
{

    /**
     * Returns tariffs
     * 
     * @param AdescomSoapClient $connection Connection
     * @return array Tariffs
     */
    public function getTariffs()
    {
        $tariffs = null;
        if (isset($this->webservices['frontend'])) {
            $tariffs = $this->webservices['frontend']->getTariffs();
        } else {
            $tariffs = $this->convertToFrontendTariffs($this->webservices['platform']->getTariffs());
        }
        return $tariffs;
    }

    private function convertToFrontendTariffs(PlatformTariffs $tariffs)
    {
        $tariffs_converted = new FrontendTariffs();
        $tariffs_converted->setCount($tariffs->getCount());
        if ($tariffs->getCount() !== 0) {
            $items = array();
            foreach ($tariffs->getTariffs() as $tariff) {
                $tariff_converted = new FrontendTariff();
                $tariff_converted->setId($tariff->getTariffId());
                $tariff_converted->setName($tariff->getName());
                $tariff_converted->setRatesWithTaxes($tariff->getRatesWithTaxes());
                $tariff_converted->setDeleted($tariff->getDeleted());
                $tariff_converted->setDeleteTime($tariff->getDeleteTime());
                $items[] = $tariff_converted;
            }
            $tariffs_converted->setItems($items);
        }
        return $tariffs_converted;
    }

}
