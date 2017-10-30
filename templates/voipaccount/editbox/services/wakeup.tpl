<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountedit-services-wakeup-panel');"><img src="img/voip.gif"> {trans('Wake-up options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountedit-services-wakeup-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountedit_alarm">{t}Wake-up calls{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountedit[alarm]" id="voipaccountedit_alarm" {if $voipaccountinfo.alarm}CHECKED{/if} {tip text="Select to allow wake up calls" trigger="alarm"}></td>
        </tr>
    </tbody>
</table>