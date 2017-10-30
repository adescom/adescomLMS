{extends file="layout.html"}
{block name=title}::: LMS :{$layout.pagetitle|striphtml} :::{/block}
{block name=module_content}

<h1>{$layout.pagetitle}</h1>

<p>{t}software version{/t}: {$version}</p>

{/block}