{if $hide_voipaccount_login}
{block name="voipaccountaddbox-login"}{/block}
{/if}
{if $hide_voipaccount_status}
{block name="voipaccountaddbox-status"}{/block}
{/if}
{if $hide_voipaccount_location}
{block name="voipaccountaddbox-location"}{/block}
{/if}

{block name="voipaccountaddbox-password"}
<tr>
    <td class='bold'>
        <img src="img/passwd.gif" alt="{t}Password:{/t}">
        {t}Password:{/t}
    </td>
    <td>
        <input type="text" id="voipaccountdata_password" name="voipaccountdata[passwd]" value="{$voipaccountdata.passwd}" size="40" {tip text="Enter authorization password" trigger="passwd"}>
        <a href="#" accesskey="s" onclick="xajax_generate_license();"><img src="img/pass.gif" alt="{t}Generate password{/t}"></a>
    </td>
</tr>
{/block}


{block name="voipaccountaddbox-phone"}
<tr id="select_pool_panel" {if $voipaccountdata.ported}style="display: none"{/if}>
    <td class='bold'>
        {t}From pool:{/t}
    </td>
    <td>
        <select size="1" name="voipaccountdata[poolid]" id="voipaccountdata_poolid" {tip text="Select phone numbers pool" trigger="poolid"} style="max-width:250px;">
            {foreach from=$pools item=pool}
            {if $pool.name}
            <option value="{$pool.id}" {if $voipaccountdata.poolid == $pool.id}selected = 'selected'{/if}>{$pool.name}:&nbsp;({$pool.countrycode}-{$pool.areacode})&nbsp;{$pool.fromnumber}-{$pool.tonumber}</option>
            {else}
            <option value="{$pool.id}" {if $voipaccountdata.poolid == $pool.id}selected = 'selected'{/if}>({$pool.countrycode}-{$pool.areacode})&nbsp;{$pool.fromnumber}-{$pool.tonumber}</option>
            {/if}
            {/foreach}
        </select>
        &nbsp;
        <a href="#" accesskey="s" onclick="searchPool()">{t}Search{/t} »</a>
    </td>
</tr>
<tr>
    <td class='bold'>
        <img src="img/phone.gif" alt="{t}Phone number:{/t}">
        {t}Phone number:{/t}
    </td>
    <td>
        <input type="text" id="voipaccountdata_countrycode" name="voipaccountdata[countrycode]" value="{$voipaccountdata.countrycode}" MAXLENGth="6" size="4" {tip text="Enter country code" trigger="phone"}>
        <input type="text" id="voipaccountdata_areacode" name="voipaccountdata[areacode]" value="{$voipaccountdata.areacode}" MAXLENGth="6" size="4" {tip text="Enter area code" trigger="phone"}>
        <input type="text" id="voipaccountdata_shortclid" name="voipaccountdata[shortclid]" value="{$voipaccountdata.shortclid}" {tip text="Enter phone number" trigger="phone"}>
        <input type="hidden" name="voipaccountdata[phone][0]" value="000000000">
        &nbsp;
        <a href="#" ACCESSKEY="s" ONCLICK="getPoolFirstFree()" id="first_free_anchor" {if $voipaccountdata.ported}style="display: none"{/if}>{t}First free{/t} »</a>
    </td>
</tr>
<tr>
    <td class='bold'>
        {t}Ported number:{/t}
    </td>
    <td>
        <input type="checkbox" value="1" name="voipaccountdata[ported]" {if $voipaccountdata.ported}CHECKED{/if} {tip text="Select to indicate if number is ported" trigger="ported_number"} ONCLICK="invalidateActivateNowPanel(this.checked); invalidateSelectPoolPanel(this.checked);">
    </td>
</tr>
{/block}


{block name="voipaccountaddbox-customer"}
<tr>
    <td class="bold nobr">
        <img src="img/customer.gif" alt="{trans("Customer:")}">
        {trans("Customer:")}
    </td>
    <td>
            <input 
                class="blend" 
                type="text" 
                id="voipaccountadd_customerinput" 
                name="voipaccountadd_qscustomer" 
                value="" 
                size="15" 
                {tip text="Enter customer ID, first/lastname, email or address and press Enter"}
            >
            <input 
                type="text" 
                name="voipaccountdata[ownerid]" 
                id="voipaccountadd_ownerid" 
                value="{if $voipaccountdata.ownerid}{$voipaccountdata.ownerid}{/if}" 
                size="5"
                {tip text="Enter customer ID" trigger="customerid"}
            >
            <script type="text/javascript">
                new AdescomAutoSuggest(
                    document.getElementById('quicksearch'),
                    document.getElementById('voipaccountadd_customerinput'),
                    '?m=quicksearch&ajax=1&mode=customer&what=',
                    0,
                    document.voipaccountadd.elements['voipaccountdata[ownerid]']
                );
            </script>
            <a href="javascript: void(0);" onClick="return customerchoosewin(document.forms['voipaccountadd'].elements['voipaccountdata[ownerid]']);" {tip text="Click to search customer"}>{trans("Search")}&nbsp;&raquo;&raquo;&raquo;</A>
    </td>
</tr>
{/block}

{block name="voipaccountaddbox-extra" append}
<tr>
    <td colspan="2">
        {include file="voipaccount/addbox/voip.tpl"}
    </td>
</tr>
<tr>
    <td colspan="2">
        {include file="voipaccount/addbox/tariff.tpl"}
    </td>
</tr>
<tr>
    <td colspan="2">
        {include file="voipaccount/addbox/block_level.tpl"}
    </td>
</tr>
<tr>
    <td colspan="2">
        {include file="voipaccount/addbox/services.tpl"}
    </td>
</tr>
{/block}

{$xajax}