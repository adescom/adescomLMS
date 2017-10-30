{if $hide_voipaccount_login}
{block name="voipaccounteditbox-login"}{/block}
{else}
{block name="voipaccounteditbox-login"}
<tr>
    <td>
        <img src="img/voip.gif" alt="{trans("Login:")}">
    </td>
    <td class="bold">
        {trans("Login:")}
    </td>
    <td>
        <input name="voipaccountedit[login]" type="text" value="{$voipaccountinfo.login}" maxlength="32" size="30" readonly="readonly" disabled="disabled" {tip text="Enter voip account login" trigger="login" bold=1}>
        ({$voipaccountinfo.id|string_format:"%04d"})
    </td>
</tr>
{/block}
{/if}
{if $hide_voipaccount_status}
{block name="voipaccounteditbox-status"}{/block}
{/if}
{if $hide_voipaccount_location}
{block name="voipaccounteditbox-location"}{/block}
{/if}

{block name="voipaccounteditbox-password"}
<tr>
    <td>
        <img src="img/passwd.gif" alt="{t}Password:{/t}">
    </td>
    <td>
        {t}Password:{/t}
    </td>
    <td>
        {if !ConfigHelper::checkConfig('privileges.hide_voip_passwords')}
        <input type="text" id="voipaccountdata_password" name="voipaccountedit[passwd]" value="{$voipaccountinfo.passwd}" size="40" {tip text="Enter authorization password" trigger="passwd"}>
        {else}
        <input type="text" id="voipaccountdata_password" name="voipaccountedit[passwd]" value="{if $voipaccountinfo.passwd == ''}{else}{'*'|str_repeat:8}{/if}" onclick="passwdReset(this)" size="40" {tip text="Enter authorization password" trigger="passwd"}>
        {/if}
        <a href="#" accessey="s" onclick="xajax_generate_license();">
            <img src="img/pass.gif" alt="{t}Generate password{/t}">
        </a>
    </td>
</tr>
{/block}

{block name="voipaccounteditbox-customer"}
<input type="hidden" id="voipaccountdata_ownerid" name="voipaccountedit[ownerid]" value="{$voipaccountinfo.ownerid}">
{/block}

{block name="voipaccounteditbox-phone"}
<tr>
    <td>
        <img src="img/phone.gif" alt="{trans("Phone number:")}">
    </td>
    <td class="bold">
        {trans("Phone number:")}
    </td>
    <td>
        <input type="text" value="{$voipaccountinfo.phone}" readonly="readonly" disabled="disabled" {tip text="Enter phone number" trigger="phone"}>
        <input type="hidden" name="voipaccountedit[phone][0]" value="{$voipaccountinfo.phone}">
    </td>
</tr>
{/block}

{block name="voipaccounteditbox-extra" append}
<tr>
    <td colspan="3">
        {include file="voipaccount/editbox/voip.tpl"}
    </td>
</tr>
<tr>
    <td colspan="3">
        {include file="voipaccount/editbox/tariff.tpl"}
    </td>
</tr>
<tr>
    <td colspan="3">
        {include file="voipaccount/editbox/block_level.tpl"}
    </td>
</tr>
<tr>
    <td colspan="3">
        {include file="voipaccount/editbox/services.tpl"}
    </td>
</tr>
{/block}