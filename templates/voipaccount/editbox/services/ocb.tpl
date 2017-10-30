<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountedit-services-ocb-panel');"><img src="img/voip.gif"> {trans('OCB options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountedit-services-ocb-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountedit_ocb_allowed">{t}OCB allowed{/t}</label></td>
            <td><input type="checkbox" name="voipaccountedit[ocb_allowed]" id="voipaccountedit_ocb_allowed" {if $voipaccountinfo.ocb_allowed}CHECKED{/if} {tip text="Select to allow user to modify OCB settings" trigger="ocb_allowed"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountedit_ocb">{t}OCB level{/t}</label></td>
            <td><input type="text" name="voipaccountedit[ocb]" id="voipaccountedit_ocb" value="{$voipaccountinfo.ocb}" {tip text="Select OCB level" trigger="ocb"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountedit_ocb_password">{t}OCB password{/t}</label></td>
            <td><input type="text" name="voipaccountedit[ocb_password]" id="voipaccountedit_ocb_password" value="{$voipaccountinfo.ocb_password}" {tip text="Enter OCB password" trigger="ocb_password"}></td>
        </tr>				
    </tbody>
</table>