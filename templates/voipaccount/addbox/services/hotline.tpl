<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountadd-services-hotline-panel');"><img src="img/voip.gif"> {trans('Hotline options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountadd-services-hotline-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountdata_hotline">{t}Hotline extension{/t}</label></td>
            <td><input type="text" name="voipaccountdata[hotline]" id="voipaccountdata_hotline" value="{$voipaccountdata.hotline}" {tip text="Enter hotline number" trigger="hotline"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_hotline_allowed">{t}Hotline allowed{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[hotline_allowed]" id="voipaccountdata_hotline_allowed" {if $voipaccountdata.hotline_allowed}CHECKED{/if} {tip text="Select to allow user to modify hotline settings" trigger="hotline_allowed"}></td>
        </tr>
    </tbody>
</table>