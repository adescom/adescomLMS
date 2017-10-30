<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountedit-tariff-panel');"><img src="img/voip.gif"> {trans('Tariff options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountedit-tariff-panel" style="display: none;">
        <tr>
            <td>
            </td>
            <td>
                <label for="">{t}Tariff:{/t}</label>
            </td>
            <td>
                <select size="1" name="voipaccountedit[tariffid]" id="voipaccountedit_tariffid" {tip text="CLid tariff" trigger="tariffid"} style="max-width:250px;">
                    {foreach from=$voip_tariffs->getItems() item=tariff}
                    {if !$tariff->getDeleted()}
                    <option value="{$tariff->getId()}" {if $voipaccountinfo.tariffid == $tariff->getId()}selected{/if}>{$tariff->getName()}</option>
                    {/if}
                    {/foreach}
                </select>
            </td>
        </tr>
        {if $allow_activation}
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_active">{t}Activate now:{/t}</label>
            </td>
            <td>
                <input type="checkbox" value="1" name="voipaccountedit[active]" id="voipaccountedit_active" {if $voipaccountinfo.active}CHECKED{/if} {tip text="Select to activate VOIP account automatically" trigger="active"} ONCLICK="invalidateActivationDatePanel(this.checked)">
            </td>
        </tr>
        <tr id="autoactivation_date_panel" {if $voipaccountinfo.active}style="display: none"{/if}>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_autoactivation_date">{t}Autoactivation date:{/t}</label>
            </td>
            <td>
                <input type="text" value="{$voipaccountinfo.autoactivation_date}" name="voipaccountedit[autoactivation_date]" id="voipaccountedit_autoactivation_date" {tip text="Enter activation date" trigger="autoactivation_date"}>
            </td>
        </tr>
        {/if}
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_was_prepaid">{t}Is prepaid:{/t}</label>
            </td>
            <td>
                <input type="checkbox" value="1" name="voipaccountedit[is_prepaid]" id="voipaccountedit_is_prepaid" {if $voipaccountinfo.is_prepaid}CHECKED{/if} {tip text="Select to configure VOIP account as prepaid" trigger="is_prepaid"} ONCLICK="invalidatePrepaidPostpaidPanels(this.checked)">
                <input type="hidden" value="{if $voipaccountinfo.is_prepaid}1{else}0{/if}" name="voipaccountedit[was_prepaid]" id="voipaccountedit_was_prepaid" >
            </td>
        </tr>
        <tr id="prepaid_configuration" {if ! $voipaccountinfo.is_prepaid}style="display: none"{/if}>
            <td></td>
            <td><label for="voipaccountedit_prepaid_state">{t}State [USD]{/t}</label></td>
            <td>
                <input type="text" name="voipaccountedit[prepaid_state]" id="voipaccountedit_prepaid_state" value="{$voipaccountinfo.prepaid_state}" readonly {tip text="Enter prepaid account state" trigger="prepaid_state"}>
                {if $was_prepaid}
                <A href="#" accessey="s" ONCLICK="chargePrepaid()"><label for="">{t}Charge prepaid{/t}</label> »</A>
                {/if}
            </td>
        </tr>
        <tr id="postpaid_configuration" {if $voipaccountinfo.is_prepaid}style="display: none"{/if}>
            <td></td>
            <td><label for="voipaccountedit_absolute_cost_limit">{t}Absolute cost limit [USD]{/t}</label></td>
            <td><input type="text" name="voipaccountedit[absolute_cost_limit]" id="voipaccountedit_absolute_cost_limit" value="{$voipaccountinfo.absolute_cost_limit}" {tip text="Enter absolute monthly cost limit" trigger="absolute_cost_limit"}></td>
        </tr>				
    </tbody>
</table>