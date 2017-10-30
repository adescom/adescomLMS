<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountadd-block-level-panel');"><img src="img/voip.gif"> {trans('Block level options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountadd-block-level-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountdata_blocklevels">{t}Levels{/t}</label></td>
            <td>
                <select MULTIPLE="multiple" name="voipaccountdata[blocklevels][]" id="voipaccountdata_blocklevels" {tip text="Select block levels. Hold ctrl to select multiple items" trigger="autoactivation_date"} style="width:250px;">
                    {foreach from=$blocklevels item=level}
                    <option value="{$level.level}" {if is_array($voipaccountdata.blocklevels) && in_array($level.level, $voipaccountdata.blocklevels)}selected{/if}>{$level.friendlyName}</option>
                    {/foreach}
                </select>
            </td>
        </tr>													
    </tbody>
</table>