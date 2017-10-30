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