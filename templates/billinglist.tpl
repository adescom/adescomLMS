{extends file="layout.html"}
{block name=title}::: LMS :{$layout.pagetitle|striphtml} :::{/block}
{block name="extra-css-styles" append}
<link href="plugins/LMSAdescomPlugin/img/styles.css" rel="stylesheet" type="text/css">
{/block}
{block name=module_content}
{include file="calendar_js.html"}
<h1>{$layout.pagetitle}</h1>

<form method="post" action="?m={$layout.module}{if $client_id}&client_id={$client_id}{/if}" name="filter">
<input type="hidden" name="page" value="{$filter.page}">
<fieldset class="adescom-fieldset{if !empty($voipaccounts)} form_2_columns{/if}">
    <legend>{t}Filter{/t}</legend>
    <fieldset class="adescom-fieldset form_column">
        <legend>{t}Options{/t}</legend>
        <ul class="block">
            <li>
                <label for="voip_billing_filter_incoming">{t}Incoming{/t}</label>
                <input type='hidden' value='off' name='incoming'>
                <input type="checkbox"
                    id="voip_billing_filter_incoming"
                    name="incoming"
                    {if $filter.incoming}checked{/if}
                    {tip text="Select to include incoming calls" trigger="incoming"}>
            </li>
            <li>
                <label for="voip_billing_filter_outgoing">{t}Outgoing{/t}</label>
                <input type='hidden' value='off' name='outgoing'>
                <input type="checkbox"
                    id="voip_billing_filter_outgoing"
                    name="outgoing"
                    {if $filter.outgoing}checked{/if}
                    {tip text="Select to include outgoing calls" trigger="outgoing"}>
            </li>
            <li>
                <label for="voip_billing_filter_remote_mask">{t}Remote number{/t}</label>
                <input type="text"
                    id="voip_billing_filter_remote_mask"
                    name="remoteMask"
                    value="{$filter.remoteMask}"
                    {tip text="Enter remote number or its part" trigger="remoteMask"}>
            </li>
            <li>
                <label for="voip_billing_filter_fromDate">{t}Date/time from{/t}</label>
                <input type="text"
                    id="voip_billing_filter_fromDate"
                    name="fromDate"
                    size="18"
                    value="{$filter.fromDate}"
                    onclick="javascript:cal1.popup();"
                    {tip text="Enter or select lower bound of billing data (click to open calendar)" trigger="fromDate"}>
            </li>
            <li>
                <label for="voip_billing_filter_toDate">{t}Date/time to{/t}</label>
                <input type="text"
                    id="voip_billing_filter_toDate"
                    name="toDate"
                    size="18"
                    value="{$filter.toDate}"
                    onclick="javascript:cal2.popup();"
                    {tip text="Enter or select upper bound of billing data (click to open calendar)" trigger="toDate"}>
            </li>
            <li>
                <label for="voip_billing_filter_includeZeroDuration">{t}Include zero billsec{/t}</label>
                <input type='hidden' value='off' name='includeZeroDuration'>
                <input type="checkbox"
                    id="voip_billing_filter_includeZeroDuration"
                    name="includeZeroDuration"
                    {if $filter.includeZeroDuration}checked{/if}
                    {tip text="Select to include calls with zero duration" trigger="includeZeroDuration"}>
            </li>
        </ul>
    </fieldset>
    {if $voipaccounts}
    <fieldset class="adescom-fieldset form_column">
        <legend>{t}Local number{/t}</legend>
        <ul class="block">
            <li>
                <select multiple size="16"
                    id="voip_billing_filter_clientExtraClids"
                    name="clientExtraClids[]"
                    {tip text="Select local number" trigger="clientExtraClids"}>
                {foreach from=$voipaccounts item=customer_voips key=customer_id}
                    <optgroup label="{$clients_names[$customer_id].customername}">
                        {foreach from=$customer_voips item=voip}
                        <option value="{$voip.id}"
                            {if is_array($filter.clientExtraClids) && in_array($voip.id, $filter.clientExtraClids)}selected{/if}>
                            {$voip.phone}
                        </option>
                        {/foreach}
                    </optgroup>
                {/foreach}
                </select>
            </li>
        </ul>
    </fieldset>
    {/if}
    <fieldset class="adescom-fieldset form_buttons">
        <button type="submit">
            <img src="img/search.gif">
            {t}Search{/t}
        </button>
    </fieldset>
</fieldset>
</form>

<table class="lmsbox">
    {assign var='number_of_table_columns' value='8'}
    <thead>
        <tr>
            <th>{t}Start date{/t}</th>
            <th>{t}Source{/t}</th>
            <th>{t}Destination{/t}</th>
            <th>{t}Trunk in{/t}</th>
            <th>{t}Trunk out{/t}</th>
            <th>{t}Duration{/t}</th>
            <th>{t}Price{/t}</th>
            <th>{t}Direction{/t}</th>
        </tr>
        {if $listdata.pages > 1}
        <tr>
            <td colspan="{$number_of_table_columns}">
                {include file="pagination.tpl"}
            </td>
        </tr>
        {/if}
    </thead>
    <tbody>
        {cycle values="light,lucid" print=false}
        {foreach from=$records item=$record}
        {assign var='tg_in' value=$record.tg_in}
        {assign var='tg_out' value=$record.tg_out}
        <tr class="highlight {cycle}">
            <td>{$record.start_date|date_format:"%Y-%m-%d %H:%M:%S"}</td>
            <td>{$record.source}</td>
            <td>{$record.destination}</td>
            <td>
                {if $tg_in && $tg_in != -1}
                {if $trunknames.$tg_in}
                {$trunknames.$tg_in}&nbsp;({$tg_in})
                {else}
                {$tg_in}
                {/if}
                {else}
                {t}None{/t}
                {/if}
            </td>
            <td>
                {if $tg_out && $tg_out != -1}
                {if $trunknames.$tg_out}
                {$trunknames.$tg_out}&nbsp;({$tg_out})
                {else}
                {$tg_out}
                {/if}
                {else}
                {t}None{/t}
                {/if}
            </td>
            <td>{$record.duration|secs2hms}</td>
            <td>{$record.price|money_format}</td>
            <td>
                {if $record.fraction}{$record.fraction}{/if}
                {if $record.prefix_name}{$record.prefix_name}{/if}
            </td>
        </tr>
        {foreachelse}
        <tr>
            <td colspan="{$number_of_table_columns}">{t}Nothing found{/t}</td>
        </tr>
        {/foreach}
    </tbody>
    {if  $listdata.pages > 1}
    <tr>
        <td colspan="{$number_of_table_columns}">
            {include file="pagination.tpl"}
        </td>
    </tr>
    {/if}
    <tr>
        <td>{t a=$listdata.total|default:"0"}Total count: $a{/t}</td>
        <td>{t a=$listdata.totalPrice|default:"0"|money_format}Total price: $a{/t}</td>
        <td>{t a=$listdata.totalDuration|secs2hms}Total duration: $a{/t}</td>
        <td colspan="{$number_of_table_columns - 3}"></td>
    </tr>	
</table>
<script type="text/javascript">
    var cal1 = new calendar(document.filter.elements['fromDate']);
    cal1.time_comp = true;
    var cal2 = new calendar(document.filter.elements['toDate']);
    cal2.time_comp = true;
</script>
{/block}