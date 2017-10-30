<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountedit-services-forwarding-panel');"><img src="img/voip.gif"> {trans('Forwarding options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountedit-services-forwarding-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountedit_forwarding">{t}Allow forwarding{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountedit[forwarding]" id="voipaccountedit_forwarding" {if $voipaccountinfo.forwarding}CHECKED{/if} {tip text="Select to enable forwarding" trigger="forwarding"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountedit_cfu">{t}CFU{/t}</label></td>
            <td><input type="text" name="voipaccountedit[cfu]" id="voipaccountedit_cfu" value="{$voipaccountinfo.cfu}" {tip text="Enter phone number for unconditional forward" trigger="cfu"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountedit_cfb">{t}CFB{/t}</label></td>
            <td><input type="text" name="voipaccountedit[cfb]" id="voipaccountedit_cfb" value="{$voipaccountinfo.cfb}" {tip text="Enter phone number for forward when busy" trigger="cfb"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountedit_cfnr">{t}CFNR{/t}</label></td>
            <td><input type="text" name="voipaccountedit[cfnr]" id="voipaccountedit_cfnr" value="{$voipaccountinfo.cfnr}" {tip text="Enter phone number for forward when no response" trigger="cfnr"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountedit_cfur">{t}CFUR{/t}</label></td>
            <td><input type="text" name="voipaccountedit[cfur]" id="voipaccountedit_cfur" value="{$voipaccountinfo.cfur}" {tip text="Enter phone number for forward when unreachable" trigger="cfur"}></td>
        </tr>
    </tbody>
</table>