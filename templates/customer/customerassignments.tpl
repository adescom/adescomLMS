{block name="customerassignments-list-row"}
<TR class="highlight {cycle name=assign}
        {if ($a.dateto < $today && $a.dateto) || ($a.liabilityid && $a.at < $today && $a.at > 365)} blend{elseif ($a.datefrom > $today && $a.datefrom && $a.period) && !($a.suspended)} alertblend{elseif ($a.suspended)}suspended{/if}">
        {if !$a.tariffid && !$a.liabilityid}
        <TD colspan="7" class="bold" OnClick="return self.location.href='?m=customerassignmentedit&amp;id={$a.id}'">
                {trans("Suspending of all liabilities")}
        </TD>
        {else}
        <TD OnClick="return self.location.href='?m=customerassignmentedit&amp;id={$a.id}'">
                {if $a.tariffid}
                        <A href="?m=tariffinfo&amp;id={$a.tariffid}"><span class="bold">{trans($a.name)}</span></A>
                {else}
                    {if $a.real_name}
                        {$a.real_name}
                    {else}
                        {trans($a.name)}
                    {/if}
                {/if}
                {if $a.nodes}({foreach from=$a.nodes item=item key=key}{$item.name}{if $key+1<sizeof($a.nodes)}, {/if}{/foreach}){/if}
        </TD>
        <TD class="text-right nobr" OnClick="return self.location.href='?m=customerassignmentedit&amp;id={$a.id}'">
                {if ConfigHelper::checkConfig('privileges.superuser') || !ConfigHelper::checkConfig('privileges.hide_finances')}{$a.value|money_format}{/if}
        </TD>
        <TD class="nobr" OnClick="return self.location.href='?m=customerassignmentedit&amp;id={$a.id}'">
                {if ConfigHelper::checkConfig('privileges.superuser') || !ConfigHelper::checkConfig('privileges.hide_finances')}{if $a.pdiscount != 0}{$a.pdiscount}%{else}{if $a.vdiscount != 0}{$a.vdiscount|money_format}{else}-{/if}{/if}{/if}
        </TD>
        <TD class="nobr" OnClick="return self.location.href='?m=customerassignmentedit&amp;id={$a.id}'">{$a.payday}</TD>
        <TD class="text-right nobr" OnClick="return self.location.href='?m=customerassignmentedit&amp;id={$a.id}'">
                {if $a.downceil}{$a.downceil} kbit/s{else}-{/if}
        </TD>
        <TD class="text-right nobr" OnClick="return self.location.href='?m=customerassignmentedit&amp;id={$a.id}'">
                {if $a.upceil}{$a.upceil} kbit/s{else}-{/if}
        </TD>
        <TD class="text-right nobr">
                <img src="img/options.gif" alt="" {tip a=$a.id dynpopup='?m=customerassignmentinfo&amp;id=$a'}>
        </TD>
        {/if}
        <TD class="nobr" OnClick="return self.location.href='?m=customerassignmentedit&amp;id={$a.id}'">
                {if $a.datefrom}{trans("from")} {$a.datefrom|date_format:"%Y/%m/%d"}{/if}
                {if $a.dateto}{trans("to")} {$a.dateto|date_format:"%Y/%m/%d"}{/if}
        </TD>
        <TD class="text-right nobr">
                {if ($a.tariffid || $a.liabilityid) && (($a.dateto > $today || !$a.dateto) || ($a.liabilityid && $a.at > $today))}
                <A href="?m=customerassignmentedit&amp;action=suspend&amp;id={$a.id}&amp;suspend={if $a.suspended}0{else}1{/if}" {tip text="Enable/disable accounting of selected liability"}><IMG SRC="img/wait.gif" alt="[ {if $a.suspended}{trans("Restore")}{else}{trans("Suspend")}{/if} ]"></A>
                {/if}
                <A onClick="return confirmLink(this, '{trans("Are you sure, you want to delete this liability?")}')" href="?m=customerassignmentdel&amp;id={$a.id}" {tip text="Delete customer's liability"}><IMG SRC="img/delete.gif" alt="[ {trans("Delete")} ]"></A>
                <A href="?m=customerassignmentedit&amp;id={$a.id}"><IMG SRC="img/edit.gif" ALT="[ {trans("Edit")} ]" title="[ {trans("Edit")} ]"></A>
        </TD>
</TR>
{/block}