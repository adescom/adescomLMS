<?php

/**
 * CustomerAssignmentAddHandler
 *
 * @author 
 */
class CustomerAssignmentAddHandler
{

    /**
     * Adds some validation before customer assignment is submitted
     * 
     * @param array $hook_data Hook data
     * @return array Hook data
     */
    public function customerAssignmentAddValidationBeforeSubmit(array $hook_data)
    {
        $hook_data['a']['origtariffid'] = $hook_data['a']['tariffid'];

        if ($hook_data['a']['tariffid'] == AdescomFinanceManager::ADESCOM_TARIFF_ID) {
            unset($hook_data['error']['name']);
            unset($hook_data['error']['value']);

            $hook_data['a']['name'] = AdescomFinanceManager::ADESCOM_ASSIGNMENT_NAME;
            $hook_data['a']['origtariffid'] = AdescomFinanceManager::ADESCOM_TARIFF_ID;
            $hook_data['a']['tariffid'] = AdescomFinanceManager::ADESCOM_TARIFF_ID;
            $hook_data['a']['value'] = '0.01';

            unset($hook_data['a']['settlement']);
        }
        
        
        return $hook_data;
    }
    
    /**
     * Adds some data to customer assignment add form template
     * 
     * @param array $hook_data Hook data
     * @return array Hook data
     */
    public function customerAssignmentAddBeforeDisplay(array $hook_data)
    {
        $hook_data['smarty']->assign('is_edit', false);
        return $hook_data;
    }

}
