<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountadd-services-clir-panel');"><img src="img/voip.gif"> {trans('CLIR options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountadd-services-clir-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountdata_clir">{t}CLIR{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[clir]" id="voipaccountdata_clir" {if $voipaccountdata.clir}CHECKED{/if} {tip text="Select to enable CLIR" trigger="clir"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_clir_allowed">{t}CLIR allowed{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[clir_allowed]" id="voipaccountdata_clir_allowed" {if $voipaccountdata.clir_allowed}CHECKED{/if} {tip text="Select to allow user to modify CLIR settings" trigger="clir_allowed"}></td>
        </tr>				
        <tr>
            <td></td>
            <td><label for="voipaccountdata_acrej">{t}ACREJ{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[acrej]" id="voipaccountdata_acrej" {if $voipaccountdata.acrej}CHECKED{/if} {tip text="Select to enable ACREJ" trigger="acrej"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_acrej_allowed">{t}ACREJ allowed{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[acrej_allowed]" id="voipaccountdata_acrej_allowed" {if $voipaccountdata.acrej_allowed}CHECKED{/if} {tip text="Select to allow user to modify ACREJ settings" trigger="acrej_allowed"}></td>
        </tr>
        <tr>
            <td></td>
            <td><label for="voipaccountdata_clirovr">{t}CLIR Override{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountdata[clirovr]" id="voipaccountdata_clirovr" {if $voipaccountdata.clirovr}CHECKED{/if} {tip text="Select to enable CLIR override" trigger="clirovr"}></td>
        </tr>
    </tbody>
</table>