<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountadd-services-conference-panel');"><img src="img/voip.gif"> {trans('Conference options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountadd-services-conference-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountdata_cw">{t}Call waiting{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[cw]" id="voipaccountdata_cw" {if $voipaccountdata.cw}CHECKED{/if} {tip text="Select to enable call waiting" trigger="cw"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_cw_allowed">{t}Call waiting allowed{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[cw_allowed]" id="voipaccountdata_cw_allowed" {if $voipaccountdata.cw_allowed}CHECKED{/if} {tip text="Select to allow user to modify call waiting settings" trigger="cw_allowed"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_nway">{t}3-way calls{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[nway]" id="voipaccountdata_nway" {if $voipaccountdata.nway}CHECKED{/if} {tip text="Select to enable 3-way calls" trigger="nway"}></td>
        </tr>
    </tbody>
</table>