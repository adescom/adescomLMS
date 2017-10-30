<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountadd-services-ocb-panel');"><img src="img/voip.gif"> {trans('OCB options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountadd-services-ocb-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountdata_ocb_allowed">{t}OCB allowed{/t}</label></td>
            <td><input type="checkbox" name="voipaccountdata[ocb_allowed]" id="voipaccountdata_ocb_allowed" {if $voipaccountdata.ocb_allowed}CHECKED{/if} {tip text="Select to allow user to modify OCB settings" trigger="ocb_allowed"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_ocb">{t}OCB level{/t}</label></td>
            <td><input type="text" name="voipaccountdata[ocb]" id="voipaccountdata_ocb" value="{$voipaccountdata.ocb}" {tip text="Enter OCB level" trigger="ocb"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_ocb_password">{t}OCB password{/t}</label></td>
            <td><input type="text" name="voipaccountdata[ocb_password]" id="voipaccountdata_ocb_password" value="{$voipaccountdata.ocb_password}" {tip text="Enter OCB password" trigger="ocb_password"}></td>
        </tr>				
    </tbody>
</table>