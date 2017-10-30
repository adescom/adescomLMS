{extends file="layout.html"}
{block name=title}::: LMS : {$layout.pagetitle|striphtml} :::{/block}
{block name=module_content}
<h1>{$layout.pagetitle}</h1>
<table class="lmsbox">
    <colgroup>
        {assign var='number_of_table_columns' value='4'}
        <col style="width: 70%;">
        <col style="width: 10%;" span="{$number_of_table_columns - 1}">
    </colgroup>
    <thead>
        <tr {tip text="Click on column name to change sorting order"}>
            <th>
                <a href="?m={$layout.module}&o=customerid{if $order_direction == "asc" && $order_by == "customerid"},desc{/if}">
                    <img src="img/customer.gif"> {trans('Customer')}:
                </a>
            </th>
            <th class="text-right">
                <a href="?m={$layout.module}&o=tariffs_count{if $order_direction == "asc" && $order_by == "tariffs_count"},desc{/if}">
                    <img src="img/money.gif"> {trans('Has any voip tariff assigned')}:
                </a>
            </th>
            <th class="text-right">
                <a href="?m={$layout.module}&o=liabilities_count{if $order_direction == "asc" && $order_by == "liabilities_count"},desc{/if}">
                    <img src="img/money.gif"> {trans('Has any liability assigned')}:
                </a>
            </th>
            <th class="text-right">
                <img src="img/settings.gif"> {trans('Actions')}:
            </th>
        </tr>
        {if $listdata.total != 0}
        <tr>
            <td class="pagination bold" colspan="{$number_of_table_columns}">
                {include file="pagination.tpl"}
            </td>
        </tr>
        {/if}
    </thead>
    <tbody>
        {cycle values="light,lucid" print=false}
        {foreach from=$voipassignments item=voipassignment}
        <tr class="highlight {cycle}">
            <td>
                <a href="?m=customerinfo&id={$voipassignment.customerid}">{$voipassignment.customername}</a>
            </td>
            <td class="text-right"{if $voipassignment.tariffs_count > 0} style='color: green;'{else} style='color: red; font-weight: bold;'{/if}>
                {if $voipassignment.tariffs_count > 0}
                    {trans('Yes')}
                {else}
                    {trans('No')}
                {/if}
            </td>
            <td class="text-right"{if $voipassignment.liabilities_count > 0} style='color: green;'{else} style='color: red; font-weight: bold;'{/if}>
                {if $voipassignment.liabilities_count > 0}
                    {trans('Yes')}
                {else}
                    {trans('No')}
                {/if}
            </td>
            <td class="text-right">
                <a href="?m=customerassignmentadd&id={$voipassignment.customerid}" title="[ {trans('New Liability')} ]"><img src="img/money.gif"></a>
            </td>
        </tr>
        {foreachelse}
        <tr>
            <td class="empty-table" colspan="{$number_of_table_columns}">
                {trans('Cannot find any customer assigned to VoIP tariff nor liability!')}
            </td>
        </tr>
        {/foreach}
    </tbody>
    <tfoot>
        {if $listdata.total != 0}
        <tr>
            <td class="pagination bold" colspan="{$number_of_table_columns}">
                {include file="pagination.tpl"}
            </td>
        </tr>
        {/if}
        <tr>
            <td class="bold text-right" colspan="{$number_of_table_columns}">
                {trans('Total')}: 
                {if $listdata.total}{$listdata.total}{else}0{/if}
            </td>
        </tr>
    </tfoot>
</table>
{/block}