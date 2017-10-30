<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountedit-services-conference-panel');"><img src="img/voip.gif"> {trans('Conference options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountedit-services-conference-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountedit_cw">{t}Call waiting{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountedit[cw]" id="voipaccountedit_cw" {if $voipaccountinfo.cw}CHECKED{/if} {tip text="Select to enable call waiting" trigger="cw"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountedit_cw_allowed">{t}Call waiting allowed{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountedit[cw_allowed]" id="voipaccountedit_cw_allowed" {if $voipaccountinfo.cw_allowed}CHECKED{/if} {tip text="Select to allow user to modify call waiting settings" trigger="cw_allowed"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountedit_nway">{t}3-way calls{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountedit[nway]" id="voipaccountedit_nway" {if $voipaccountinfo.nway}CHECKED{/if} {tip text="Select to enable 3-way calls" trigger="nway"}></td>
        </tr>
    </tbody>
</table>