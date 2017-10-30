<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountadd-services-dnd-panel');"><img src="img/voip.gif"> {trans('DND options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountadd-services-dnd-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountdata_dnd">{t}DND{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[dnd]" id="voipaccountdata_dnd" {if $voipaccountdata.dnd}CHECKED{/if} {tip text="Select to enable DND" trigger="dnd"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_dnd_allowed">{t}DND allowed{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[dnd_allowed]" id="voipaccountdata_dnd_allowed" {if $voipaccountdata.dnd_allowed}CHECKED{/if} {tip text="Select to allow user to modify DND settings" trigger="dnd_allowed"}></td>
        </tr>
    </tbody>
</table>