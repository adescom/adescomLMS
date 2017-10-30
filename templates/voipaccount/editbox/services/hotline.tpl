<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountedit-services-hotline-panel');"><img src="img/voip.gif"> {trans('Hotline options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountedit-services-hotline-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountedit_hotline">{t}Hotline extension{/t}</label></td>
            <td><input type="text" name="voipaccountedit[hotline]" id="voipaccountedit_hotline" value="{$voipaccountinfo.hotline}" {tip text="Select to enable hotline" trigger="hotline"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountedit_hotline_allowed">{t}Hotline allowed{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountedit[hotline_allowed]" id="voipaccountedit_hotline_allowed" {if $voipaccountinfo.hotline_allowed}CHECKED{/if} {tip text="Select to allow user to modify hotline settings" trigger="hotline_allowed"}></td>
        </tr>
    </tbody>
</table>