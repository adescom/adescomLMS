<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountadd-tariff-panel');"><img src="img/voip.gif"> {trans('Tariff options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountadd-tariff-panel" style="display: none;">
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountdata_tariffid">{t}Tariff:{/t}</label>
            </td>
            <td>
                <select size="1" name="voipaccountdata[tariffid]" id="voipaccountdata_tariffid" {tip text="Select CLid tariff" trigger="tariffid"} style="max-width:250px;">
                    {foreach from=$voip_tariffs->getItems() item=tariff}
                    {if !$tariff->getDeleted()}
                    <option value="{$tariff->getId()}"{if $voipaccountdata.tariffid == $tariff->getId()} selected='selected'{/if}>{$tariff->getName()}</option>
                    {/if}
                    {/foreach}
                </select>
            </td>
        </tr>			
        <tr {if $voipaccountdata.ported}style="display: none"{/if} class="activate_now_panel">
            <td>
            </td>
            <td>
                <label for="voipaccountdata_active">{t}Activate now:{/t}</label>
            </td>
            <td>
                <input type="checkbox" value="1" name="voipaccountdata[active]" id="voipaccountdata_active" {if $voipaccountdata.active}CHECKED{/if} {tip text="Select to activate VOIP account automatically" trigger="active"} ONCLICK="invalidateActivationDatePanel(this.checked)">
            </td>
        </tr>
        <tr id="autoactivation_date_panel" {if $voipaccountdata.ported}style="display: none"{/if} {if $voipaccountdata.active}style="display: none"{/if} class="activate_now_panel">
            <td>
            </td>
            <td>
                <label for="voipaccountdata_autoactivation_date">{t}Autoactivation date:{/t}</label>
            </td>
            <td>
                <input type="text" value="{$voipaccountdata.autoactivation_date}" name="voipaccountdata[autoactivation_date]" id="voipaccountdata_autoactivation_date" {tip text="Enter activation date" trigger="autoactivation_date"}>
            </td>
        </tr>						
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountdata_is_prepaid">{t}Is prepaid:{/t}</label>
            </td>
            <td>
                <input type="checkbox" value="1" name="voipaccountdata[is_prepaid]" id="voipaccountdata_is_prepaid" {if $voipaccountdata.is_prepaid}CHECKED{/if} {tip text="Select to configure VOIP account as prepaid" trigger="is_prepaid"} ONCLICK="invalidatePrepaidPostpaidPanels(this.checked)">
            </td>
        </tr>
        <tr id="prepaid_configuration" {if !$voipaccountdata.is_prepaid}style="display: none"{/if}>
            <td></td>
            <td><label for="voipaccountdata_prepaid_state">{t}State [USD]{/t}</label></td>
            <td><input type="text" name="voipaccountdata[prepaid_state]" id="voipaccountdata_prepaid_state" value="{$voipaccountdata.prepaid_state}" {tip text="Enter prepaid account state" trigger="prepaid_state"}></td>
        </tr>				
        <tr id="postpaid_configuration" {if $voipaccountdata.is_prepaid}style="display: none"{/if}>
            <td></td>
            <td><label for="voipaccountdata_absolute_cost_limit">{t}Absolute cost limit [USD]{/t}</label></td>
            <td><input type="text" name="voipaccountdata[absolute_cost_limit]" id="voipaccountdata_absolute_cost_limit" value="{$voipaccountdata.absolute_cost_limit}" {tip text="Enter absolute monthly cost limit" trigger="absolute_cost_limit"}></td>
        </tr>
    </tbody>
</table>