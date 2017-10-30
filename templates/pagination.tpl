{trans("Page:")}
{if $listdata.page > 1}
    <a href="?m={$layout.module}&page={math equation="x - 1" x=$listdata.page}">{'&laquo;'|str_repeat:3}</a>
{/if}
{section name=pagination loop=$listdata.pages step=1 start=1}
    {if $listdata.page == $smarty.section.pagination.index}
        [{$smarty.section.pagination.index}]
    {else}
        <a href="?m={$layout.module}&page={$smarty.section.pagination.index}">{$smarty.section.pagination.index}</a>
    {/if}
{/section}
{if $listdata.page < $listdata.pages}
    <a href="?m={$layout.module}&page={math equation="x + 1" x=$listdata.page}">{'&raquo;'|str_repeat:3}</a>
{/if}