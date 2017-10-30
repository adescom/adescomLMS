<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountedit-services-dnd-panel');"><img src="img/voip.gif"> {trans('DND options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountedit-services-dnd-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountedit_dnd">{t}DND{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountedit[dnd]" id="voipaccountedit_dnd" {if $voipaccountinfo.dnd}CHECKED{/if} {tip text="Select to enable DND" trigger="dnd"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountedit_dnd_allowed">{t}DND allowed{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountedit[dnd_allowed]" id="voipaccountedit_dnd_allowed" {if $voipaccountinfo.dnd_allowed}CHECKED{/if} {tip text="Select to allow user to modify DND settings" trigger="dnd_allowed"}></td>
        </tr>
    </tbody>
</table>