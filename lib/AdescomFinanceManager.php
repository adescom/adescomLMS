<?php

/**
 * AdescomFinanceManager
 *
 * @author ADESCOM <info@adescom.pl>
 */
class AdescomFinanceManager extends LMSFinanceManager implements LMSFinanceManagerInterface
{
    
    private $userpanel = false;

    const ADESCOM_ASSIGNMENT_NAME = 'ADESCOM_AUTO_VOIP_CALL';
    const ADESCOM_TARIFF_ID = -3;

    /**
     * Returns customer assignments
     * 
     * Replaces Adescom assignment flag with human readable name. Replaces value
     * and discount value aswell.
     * 
     * @param int $id Customer id
     * @param boolean $show_expired Show expired
     * @return array Assignments
     */
    public function GetCustomerAssignments($id, $show_expired = false)
    {
        $assignments = parent::GetCustomerAssignments($id, $show_expired);

        if (!empty($assignments)) {
            $count = count($assignments);
            for ($idx = 0;$idx < $count;$idx++) {
                if ($assignments[$idx]['name'] === self::ADESCOM_ASSIGNMENT_NAME) {
                    if ($this->userpanel) {
                        $assignments[$idx]['name'] = trans('Telephone calls (autocalculated)');
                    } else {
                        $assignments[$idx]['real_name'] = trans('Telephone calls (autocalculated)');
                    }
                    $assignments[$idx]['value'] = 0;
                    $assignments[$idx]['discounted_value'] = 0;
                    $assignments[$idx]['real_value'] = 0;
                    $assignments[$idx]['real_disc_value'] = 0;
                }
            }
        }

        return $assignments;
    }

    /**
     * Adds assignment
     * 
     * If assignment is Adescom VoIP assignment does some stuff.
     * 
     * @param array $data Assignment data
     * @return array Assignments id
     */
    public function AddAssignment($data)
    {
        if ($data['origtariffid'] == self::ADESCOM_TARIFF_ID) {
            $liability = array();
            $liability['settlement'] = $data['subscribe_settlement'];
            $liability['history'][] = array('date' => date('Y-m-d H:i:s'), 'price' => $data['subscribe_value']);
            $liability['fraction'] = 'SUBSCRIBE';

            $liability_manager = new AdescomLiabilityManager();
            $liability_manager->setClientLiability($data['customerid'], 'CLIENT_SUBSCRIBE', $liability);
        }
        return parent::AddAssignment($data);
    }

    public function setUserpanel()
    {
        $this->userpanel = true;
    }
    
}
