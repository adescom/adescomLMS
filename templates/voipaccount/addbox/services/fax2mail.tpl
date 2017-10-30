<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountadd-services-fax2mail-panel');"><img src="img/voip.gif"> {trans('Fax2Mail options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountadd-services-fax2mail-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountdata_f2m">{t}Allow Fax2Mail forwarding{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[f2m]" id="voipaccountdata_f2m" {if $voipaccountdata.f2m}CHECKED{/if} {tip text="Select to enable Fax2Mail forwarding" trigger="f2m"}></td>
        </tr>				
        <tr>
            <td></td>
            <td><label for="voipaccountdata_uf2m">{t}Unconditional forward{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[uf2m]" id="voipaccountdata_uf2m" {if $voipaccountdata.uf2m}CHECKED{/if} {tip text="Select to enable unconditional Fax2Mail forward" trigger="uf2m"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_nrf2m">{t}Forward when unreachable{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[nrf2m]" id="voipaccountdata_nrf2m" {if $voipaccountdata.nrf2m}CHECKED{/if} {tip text="Select to enable Fax2Mail forward when unreacheable" trigger="nrf2m"}></td>
        </tr>
    </tbody>
</table>