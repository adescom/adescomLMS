{block name=extra_content}
{$xajax}
{literal}
<script language="javascript">
    
    function toggleVoiceMailConfiguration(value)
    {
        var voice_mail_configuration_elems = document.getElementsByClassName('voicemail_configuration');
        for (i = 0; i < voice_mail_configuration_elems.length; i++) {
            if (value) {
                voice_mail_configuration_elems[i].style.display = '';
            } else {
                voice_mail_configuration_elems[i].style.display = 'none';
            }
        }
    }
    
    function passwdReset(elem)
    {
        if (!elem.reset) {
            elem.value = '';
            elem.reset = true;
        }   
    }
    
    function getSelectedPool()
    {
        var element = document.getElementById('voipaccountedit_poolid');
        if (element === null) {
            return null;
        }

        return element.options[element.selectedIndex].value;
    }

    function getPoolFirstFree()
    {
        var value = getSelectedPool();
        if (value) {
            xajax_pool_first_free(value);
        }
    }

    function chargePrepaid()
    {
        var element = document.createElement("input");
        element.id = "charge_prepaid";
        element.name = "charge_prepaid";
        element.type = "hidden";
        element.value = 1;
        document.editvoipaccount.appendChild(element);
        document.editvoipaccount.submit();
    }

    function invalidatePrepaidPostpaidPanels(value)
    {
        var prepaid_panel = document.getElementById('prepaid_configuration');
        var postpaid_panel = document.getElementById('postpaid_configuration');
        var was_prepaid = {/literal}{if $was_prepaid}1{else}0{/if}{literal};
        if (value) {
            if (was_prepaid) {
            prepaid_panel.style.display = '';
            }
            postpaid_panel.style.display = 'none';
        } else {
            if (was_prepaid) {
                prepaid_panel.style.display = 'none';
            }
            postpaid_panel.style.display = '';
        }
    }

    function invalidateActivationDatePanel(value)
    {
        var panel = document.getElementById('autoactivation_date_panel');
        if (value) {
            panel.style.display = 'none';
        } else {
            panel.style.display = '';
        }
    }
</script>
{/literal}
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