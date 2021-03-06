{block name="voipaccountlist-list-columns"}
<col style="width: 90%;">
<col style="width: 1%;" span="11">
{assign var='number_of_table_columns' value='12'}
{/block}

{block name="voipaccountlist-list-header"}
<tr {tip text="Click on column name to change sorting order"}>
    <th nowrap>
        <img src="img/voip.gif" alt=""> 
        <a href="?m=voipaccountlist&o=login{if $listdata.direction == "asc" && $listdata.order == "login"},desc{/if}">{trans("Login:")}</a> 
        {if $listdata.order == "login"}
        <img src="img/{if $listdata.direction == "desc"}asc{else}desc{/if}_order.gif" alt="">
        {/if}
        / {trans("Location:")}
        <br>
        <img src="img/customer.gif" alt=""> 
        <a href="?m=voipaccountlist&o=owner{if $listdata.direction == "asc" && $listdata.order == "owner"},desc{/if}">{trans("Customer:")}</a> 
        {if $listdata.order == "owner"}
        <img src="img/{if $listdata.direction == "desc"}asc{else}desc{/if}_order.gif" alt="">
        {/if}
    </th>
    <th style="color: transparent;">
        {trans("Activity")}:
    </th>
    <th nowrap>
        <a href="?m=voipaccountlist&o=id{if $listdata.direction == "asc" && $listdata.order == "id"},desc{/if}">{trans("ID:")}</a> 
        {if $listdata.order == "id"}
        <img src="img/{if $listdata.direction == "desc"}asc{else}desc{/if}_order.gif" alt="">
        {/if}
    </th>
    <th nowrap>
        <a href="?m=voipaccountlist&o=phone{if $listdata.direction == "asc" && $listdata.order == "phone"},desc{/if}">{trans("Phone number:")}</a> 
        {if $listdata.order == "phone"}
        <img src="img/{if $listdata.direction == "desc"}asc{else}desc{/if}_order.gif" alt="">
        {/if}
    </th>
    <th nowrap>
        <a href="?m=voipaccountlist&o=passwd{if $listdata.direction == "asc" && $listdata.order == "passwd"},desc{/if}">{trans("Password:")}</a> 
        {if $listdata.order == "passwd"}
        <img src="img/{if $listdata.direction == "desc"}asc{else}desc{/if}_order.gif" alt="">
        {/if}
    </th>
    <th nowrap>{t}Tariff{/t}:</th>
    <th nowrap>{t}Account state{/t}:</th>
    <th nowrap>{t}Limit{/t}:</th>
    <th nowrap>{t}Account state type{/t}:</th>
    <th nowrap>{t}IP address{/t}:</th>
    <th nowrap>{t}CTM{/t}:</th>
    <th align="right">
        <nobr>{t a=$listdata.total}Total: $a{/t}</nobr>
    </th>
</tr>
{/block}

{block name="voipaccountlist-list-row"}
<tr class="highlight {cycle} voip_account" id="voip_account_{$voipaccountlist[voipaccountlist].id}">
    <td nowrap>
        <img src="img/voip.gif" alt="">
        <a href="?m=voipaccountinfo&id={$voipaccountlist[voipaccountlist].id}" class="bold">
        {$voipaccountlist[voipaccountlist].login}
        </a>
        {if $voipaccountlist[voipaccountlist].location} / {$voipaccountlist[voipaccountlist].location}{if $voipaccountlist[voipaccountlist].borough_name} ({$voipaccountlist[voipaccountlist].state_name} / {$voipaccountlist[voipaccountlist].district_name} / {$_BOROUGHTYPES[$voipaccountlist[voipaccountlist].borough_type]} {$voipaccountlist[voipaccountlist].borough_name}){/if}{/if}
        <br>
        <img src="img/customer.gif" alt="">&nbsp;
        <a href="?m=customerinfo&id={$voipaccountlist[voipaccountlist].ownerid}" {tip a=$voipaccountlist[voipaccountlist].ownerid dynpopup='?m=customerinfoshort&id=$a'}>
            {$voipaccountlist[voipaccountlist].owner|truncate:40:"...":true|replace:" ":"&nbsp;"} ({$voipaccountlist[voipaccountlist].ownerid|string_format:"%04d"})
        </a>
    </td>
    <td style="font-size: 2.5em; text-align: right;">
        {if $voipaccountlist[voipaccountlist].status == 1}
        <span style="color: green;">&#x25cf;</span>
        {else}
        <span style="color: red;">&#x25cf;</span>
        {/if}
    </td>
    <td valign="top" nowrap>
        ({$voipaccountlist[voipaccountlist].id|string_format:"%04d"})
    </td>
    <td valign="top" nowrap>
        <B>{$voipaccountlist[voipaccountlist].phone}</B>
    </td>
    <td valign="top" nowrap>
        {if !ConfigHelper::checkConfig('privileges.hide_voip_passwords')}{$voipaccountlist[voipaccountlist].passwd}{else}{'*'|str_repeat:8}{/if}
        {if $voipaccountlist[voipaccountlist].passwd_missmatch}
        <span class="alert">{trans('CTM and LMS passwords do not match!')}</span>
        {/if}
    </td>
    <td {if $voipaccountlist[voipaccountlist].tariff && $voipaccountlist[voipaccountlist].tariff->getDeleted()}style="color: red;"{/if}>
        {if $voipaccountlist[voipaccountlist].tariff}{$voipaccountlist[voipaccountlist].tariff->getName()}{/if}
    </td>
    <td valign="top" nowrap id="voip_account_{$voipaccountlist[voipaccountlist].id}_account_state">
        <img src="img/wait.gif" class="loading">
    </td>
    <td valign="top" nowrap>
        {if $voipaccountlist[voipaccountlist].absolute_limit !== null}
        {$voipaccountlist[voipaccountlist].absolute_limit|money_format}
        {else}
        {t}No data{/t}
        {/if}
    </td>
    <td valign="top" nowrap id="voip_account_{$voipaccountlist[voipaccountlist].id}_account_state_type">
        <img src="img/wait.gif" class="loading">
    </td>
    <td valign="top" nowrap>
        {if $voipaccountlist[voipaccountlist].ip_address !== null && $voipaccountlist[voipaccountlist].port !== null}
        {$voipaccountlist[voipaccountlist].ip_address}:{$voipaccountlist[voipaccountlist].port}
        {else}
        {t}No data{/t}
        {/if}
    </td>
    <td>
        {if $voipaccountlist[voipaccountlist].ctm_node_name}
            <span style="color: green;">{$voipaccountlist[voipaccountlist].ctm_node_name}</span>
        {else}
            <span style="color: red;">{t}No data{/t}</span>
        {/if}
    </td>
    <td align="right">
        <nobr>
            <a href="?m=voipaccountset&id={$voipaccountlist[voipaccountlist].id}">
                <img src="img/{if ! $voipaccountlist[voipaccountlist].access}no{/if}access.gif" alt="[ {if ! $voipaccountlist[voipaccountlist].access}{trans("Connect")}{else}{trans("Disconnect")}{/if} ]" title="[ {if ! $voipaccountlist[voipaccountlist].access}{trans("Connect")}{else}{trans("Disconnect")}{/if} ]">
            </a>
            <a onClick="return confirmLink(this, '{t a=$voipaccountlist[voipaccountlist].login}Are you sure, you want to remove voip account \'$a\' from database?{/t}')" href="?m=voipaccountdel&id={$voipaccountlist[voipaccountlist].id}">
                <img src="img/delete.gif" alt="[ {trans("Delete")} ]" title="[ {trans("Delete")} ]">
            </a>
            <a href="?m=voipaccountedit&id={$voipaccountlist[voipaccountlist].id}">
                <img src="img/edit.gif" alt="[ {trans("Edit")} ]" title="[ {trans("Edit")} ]">
            </a>
            <a href="?m=voipaccountinfo&id={$voipaccountlist[voipaccountlist].id}">
                <img src="img/info.gif" alt="[ {trans("Info")} ]" title="[ {trans("Info")} ]">
            </a>
            <a href="?m=billinglist&client_id={$voipaccountlist[voipaccountlist].ownerid}&voip_account_id={$voipaccountlist[voipaccountlist].id}">
                <img src="img/payment.gif" alt="[ {t}Billing{/t} ]" title="[ {t}Billing{/t} ]">
            </a>
            <a href="?m=voipaccountprint&id={$voipaccountlist[voipaccountlist].id}" target="_blank">
                <img src="img/print.gif" alt="[ {t}Info{/t} ]" title="[ {t}Print{/t} ]">
            </a>
        </nobr>
    </td>
</tr>
{if $voipaccountlist[voipaccountlist.index_next].ownerid == $voipaccountlist[voipaccountlist].ownerid && $listdata.order == "owner"}{cycle print=false}{/if}

{/block}


{block name="extra-css-styles" append}
<link href="plugins/LMSAdescomPlugin/img/styles.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="plugins/LMSAdescomPlugin/img/scripts.js"></script>
{/block}

{block name="module_content" append}

{$xajax}

{literal}
<script language="javascript">

    addLoadEvent(loadVoipAccountsStates);

</script>
{/literal}

{/block}