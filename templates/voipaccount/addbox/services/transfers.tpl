<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountadd-services-transfers-panel');"><img src="img/voip.gif"> {trans('Transfers options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountadd-services-transfers-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountdata_blind_xfer">{t}Allow blind transfers{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[blind_xfer]" id="voipaccountdata_blind_xfer" {if $voipaccountdata.blind_xfer}CHECKED{/if} {tip text="Select to allow blind transfers" trigger="blind_xfer"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_at_xfer">{t}Allow attended transfers{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[at_xfer]" id="voipaccountdata_at_xfer" {if $voipaccountdata.at_xfer}CHECKED{/if} {tip text="Select to allow attended transfers" trigger="at_xfer"}></td>
        </tr>
    </tbody>
</table>