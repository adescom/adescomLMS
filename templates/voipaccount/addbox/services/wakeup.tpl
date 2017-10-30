<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountadd-services-wakeup-panel');"><img src="img/voip.gif"> {trans('Wake-up options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountadd-services-wakeup-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountdata_alarm">{t}Wake-up calls{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[alarm]" id="voipaccountdata_alarm" {if $voipaccountdata.alarm}CHECKED{/if} {tip text="Select to allow wake up calls" trigger="alarm"}></td>
        </tr>
    </tbody>
</table>