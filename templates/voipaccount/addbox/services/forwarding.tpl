<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountadd-services-forwarding-panel');"><img src="img/voip.gif"> {trans('Forwarding options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountadd-services-forwarding-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountdata_forwarding">{t}Allow forwarding{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[forwarding]" id="voipaccountdata_forwarding" {if $voipaccountdata.forwarding}CHECKED{/if} {tip text="Select to enable forwarding" trigger="forwarding"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_cfu">{t}CFU{/t}</label></td>
            <td><input type="text" name="voipaccountdata[cfu]" id="voipaccountdata_cfu" value="{$voipaccountdata.cfu}" {tip text="Enter phone number for unconditional forward" trigger="cfu"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_cfb">{t}CFB{/t}</label></td>
            <td><input type="text" name="voipaccountdata[cfb]" id="voipaccountdata_cfb" value="{$voipaccountdata.cfb}" {tip text="Enter phone number for forward when busy" trigger="cfb"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_cfnr">{t}CFNR{/t}</label></td>
            <td><input type="text" name="voipaccountdata[cfnr]" id="voipaccountdata_cfnr" value="{$voipaccountdata.cfnr}" {tip text="Enter phone number for forward when no response" trigger="cfnr"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_cfur">{t}CFUR{/t}</label></td>
            <td><input type="text" name="voipaccountdata[cfur]" id="voipaccountdata_cfur" value="{$voipaccountdata.cfur}" {tip text="Enter phone number for forward when unreachable" trigger="cfur"}></td>
        </tr>
    </tbody>
</table>