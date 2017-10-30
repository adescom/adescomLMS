{extends file="layout.html"}
{block name=title}::: LMS :{$layout.pagetitle|striphtml} :::{/block}
{block name="extra-css-styles" append}
<link href="plugins/LMSAdescomPlugin/img/styles.css" rel="stylesheet" type="text/css">
{/block}
{block name=module_content}
<h1>{$layout.pagetitle}</h1>

<form action="?m=voipaccountpaneluserlist" method="POST">
    <fieldset class="adescom-fieldset">
        <legend>{t}Filter{/t}</legend>
        <select name="customer_id" >
            {foreach from=$customers item=customer}
            <option value="{$customer.id}"{if $customer.id == $customer_id} selected="selected"{/if}>
                {$customer.customer_name}
            </option>
            {/foreach}
        </select>
        <fieldset class="adescom-fieldset form_buttons">
            <button type="submit">
                <img src="img/search.gif"/>
                {t}Search{/t}
            </button>
        </fieldset>
    </fieldset>
</form>

<table class="lmsbox">
    <colgroup>
        {assign var='number_of_table_columns' value='3'}
        <col style="width: 70%;">
        <col style="width: 10%;" span="{$number_of_table_columns - 1}">
    </colgroup>
    <thead>
        <tr>
            <th>
                <a href="?m={$layout.module}&o=paneluser{if $order_direction == "asc" && $order_by == "paneluser"},desc{/if}">
                    <img src="img/customer.gif"> {trans('Panel user name')}:
                </a>
            </th>
            <th>
                {trans('Webservice access')}
            </th>
            <th class="text-right">
                <img src="img/settings.gif"> {trans('Actions')}:
            </th>
        </tr>
    </thead>
    <tbody>
        {if $panel_users && $panel_users->getCount() != 0}
        {cycle values="light,lucid" print=false}
        {foreach from=$panel_users->getItems() item=panel_user}
        <tr class="highlight {cycle}">
            <td>
                {$panel_user->getName()}
            </td>
            <td>
                {if $panel_user->getEnableWebservices()}
                {trans('Yes')}
                {else}
                {trans('No')}
                {/if}
            </td>
            <td class="text-right">
                <a href="?m=voipaccountpaneluseredit&id={$panel_user->getId()}&customer_id={$customer_id}" title="[ {trans('Edit panel user')} ]"><img src="img/edit.gif"></a>
            </td>
        </tr>
        {/foreach}
        {else}
        <tr>
            <td class="empty-table" colspan="{$number_of_table_columns}">
                {trans('Cannot find any panel user!')}
            </td>
        </tr>
        {/if}
    </tbody>
    <tfoot>
        <tr>
            <td>
                {if $customer_id}
                    <a href="?m=voipaccountpaneluseradd&customer_id={$customer_id}">{t}Add panel user for selected customer{/t}</a>
                {/if}
                </td>
            <td class="bold text-right" colspan="{$number_of_table_columns - 1}">
                {trans('Total')}: 
                {if $panel_users}{$panel_users->getCount()}{/if}
            </td>
        </tr>
    </tfoot>
</table>
{/block}