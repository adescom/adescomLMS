<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountedit-services-transfers-panel');"><img src="img/voip.gif"> {trans('Transfers options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountedit-services-transfers-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountedit_blind_xfer">{t}Allow blind transfers{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountedit[blind_xfer]" id="voipaccountedit_blind_xfer" {if $voipaccountinfo.blind_xfer}CHECKED{/if} {tip text="Select to allow blind transfers" trigger="blind_xfer"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountedit_at_xfer">{t}Allow attended transfers{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountedit[at_xfer]" id="voipaccountedit_at_xfer" {if $voipaccountinfo.at_xfer}CHECKED{/if} {tip text="Select to allow attended transfers" trigger="at_xfer"}></td>
        </tr>
    </tbody>
</table>