{block name="customervoipaccountsbox-list-columns"}
<COLGROUP>
        <COL style="width: 90%;">
        <COL style="width: 1%;" span="11">
        {assign var='number_of_table_columns' value='12'}
</COLGROUP>
{/block}

{block name="customervoipaccountsbox-list-header"}
<TR>
        <TD class="bold nobr">{trans("Login:")}</TD>
        <TD class="nobr">{trans("ID:")}</TD>
        <TD class="nobr" colspan="2">{trans("Password:")}</TD>
        <TD class="nobr">{t}IP address:{/t}</TD>
        <TD class="nobr">{trans("Phone number:")}</TD>
        <TD class="nobr">{trans("Tariff:")}</TD>
        <TD class="nobr">{trans("Account state type")}:</TD>
        <TD class="nobr">{trans("Account state")}:</TD>
        <TD class="nobr">{trans("Absolute limit")}:</TD>
        <TD class="nobr">{trans("CTM")}:</TD>
        <TD>&nbsp;</TD>
</TR>
{/block}

{block name="customervoipaccountsbox-list-row"}
<TR class="highlight {cycle name=voips} voip_account" id="voip_account_{$voipaccount.id}">
        <TD class="bold nobr" onclick="return self.location.href='?m=voipaccountinfo&amp;id={$voipaccount.id}'">
                {$voipaccount.login}
        </TD>
        <TD class="nobr" onclick="return self.location.href='?m=voipaccountinfo&amp;id={$voipaccount.id}'">
                ({$voipaccount.id|string_format:"%04d"})
        </TD>
        <TD class="nobr" colspan="2" onclick="return self.location.href='?m=voipaccountinfo&amp;id={$voipaccount.id}'">
                {if !ConfigHelper::checkConfig('privileges.hide_voip_passwords')}{$voipaccount.passwd}{else}{'*'|str_repeat:8}{/if}
                {if $voipaccount.passwd_missmatch}
                <span class="alert">{trans('CTM and LMS passwords do not match!')}</span>
                {/if}
        </TD>
        <TD onClick="return self.location.href='?m=voipaccountinfo&id={$voipaccountlist[voipaccountlist].id}';" valign="top" nowrap>
                {if $voipaccount.status.ip_address !== null && $voipaccount.status.port !== null}
                        {$voipaccount.status.ip_address}:{$voipaccount.status.port}
                {else}
                        {t}No data{/t}
                {/if}
        </TD>
        <TD class="nobr" onclick="return self.location.href='?m=voipaccountinfo&amp;id={$voipaccount.id}'">
                {if $voipaccount.status.status == 1}
                        <span style="color: green;">&#x25cf;</span>
                {else}
                        <span style="color: red;">&#x25cf;</span>
                {/if}
                {$voipaccount.phone}
        </TD>
        <TD class="nobr" onclick="return self.location.href='?m=voipaccountinfo&amp;id={$voipaccount.id}'" {if $voipaccount.tariff && $voipaccount.tariff->getDeleted()}style="color: red;"{/if}>
            {if $voipaccount.tariff}
                {$voipaccount.tariff->getName()}
            {/if}
        </TD>
        <TD NOWRAP onclick="return self.location.href='?m=voipaccountinfo&id={$voipaccount.id}'" id="voip_account_{$voipaccount.id}_account_state_type">
                <img src="img/wait.gif" class="loading">
        </TD>
        <TD NOWRAP onclick="return self.location.href='?m=voipaccountinfo&id={$voipaccount.id}'" id="voip_account_{$voipaccount.id}_account_state">
                <img src="img/wait.gif" class="loading">
        </TD>
        <TD NOWRAP onclick="return self.location.href='?m=voipaccountinfo&id={$voipaccount.id}'">
            {if $voipaccount.absolute_limit !== null}
                {$voipaccount.absolute_limit|money_format}
            {else}
                {t}No data{/t}
            {/if}
        </TD>
        <TD class="nobr" onclick="return self.location.href='?m=voipaccountinfo&amp;id={$voipaccount.id}'">
                {if $voipaccount.status.ctm_node_name}
                        <span style="color: green;">{$voipaccount.status.ctm_node_name}</span>
                {else}
                        <span style="color: red;">{t}No data{/t}</span>
                {/if}
        </TD>
        <TD class="text-right nobr">
                <a href="?m=voipaccountset&id={$voipaccount.id}"><img src="img/{if ! $voipaccount.access}no{/if}access.gif" alt="[ {if ! $voipaccount.access}{trans("Connect")}{else}{trans("Disconnect")}{/if} ]" title="[ {if ! $voipaccount.access}{trans("Connect")}{else}{trans("Disconnect")}{/if} ]"></A>
                <A onClick="return confirmLink(this, '{trans("Are you sure, you want to remove customer voip account?")}')" href="?m=voipaccountdel&amp;id={$voipaccount.id}"><IMG src="img/delete.gif" alt="[ {trans("Delete")} ]" title="[ {trans("Delete")} ]"></A>
                <A href="?m=voipaccountedit&amp;id={$voipaccount.id}"><IMG src="img/edit.gif" alt="[ {trans("Edit")} ]" title="[ {trans("Edit")} ]"></A>
                <A href="?m=voipaccountinfo&amp;id={$voipaccount.id}"><IMG src="img/info.gif" alt="[ {trans("Info")} ]" title="[ {trans("Info")} ]"></A>
                <A HREF="?m=billinglist&client_id={$customerinfo.id}&voip_account_id={$voipaccount.id}"><IMG SRC="img/payment.gif" ALT="[ {t}Billing{/t} ]" TITLE="[ {t}Billing{/t} ]"></A>
                <a href="?m=voipaccountprint&id={$voipaccount.id}" target="_blank"><img src="img/print.gif" alt="[ {t}Info{/t} ]" title="[ {t}Print{/t} ]"></A>
                {if $voipaccount.is_prepaid}
                <A HREF="?m=voipaccountrechargeprepaid&id={$voipaccount.id}"><IMG SRC="img/value.gif" ALT="[ {t}Recharge prepaid{/t} ]" TITLE="[ {t}Recharge prepaid{/t} ]"></A>
                {/if}
        </TD>
</TR>
{/block}