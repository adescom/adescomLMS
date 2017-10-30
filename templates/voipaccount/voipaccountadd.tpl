{block name=extra_content}

{literal}
<script language="javascript">

    function toggleVoiceMailConfiguration(value)
    {
        var voice_mail_configuration_elems = document.getElementsByClassName('voicemail_configuration');
        for (var i = 0; i < voice_mail_configuration_elems.length; i++) {
            if (value) {
                voice_mail_configuration_elems[i].style.display = '';
            } else {
                voice_mail_configuration_elems[i].style.display = 'none';
            }
        }
    }

    function getSelectedPool()
    {
        var element = document.getElementById('voipaccountdata_poolid');

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

    function searchPool()
    {
        var value = getSelectedPool();

        var element = document.createElement("input");

        element.id = "pool_search";
        element.name = "pool_search";
        element.type = "hidden";
        element.value = value;

        document.voipaccountadd.appendChild(element);

        document.voipaccountadd.submit();
    }

    function invalidatePrepaidPostpaidPanels(value)
    {
        var prepaid_panel = document.getElementById('prepaid_configuration');
        var postpaid_panel = document.getElementById('postpaid_configuration');

        if (value) {
            prepaid_panel.style.display = '';
            postpaid_panel.style.display = 'none';
        } else {
            prepaid_panel.style.display = 'none';
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

    function invalidateActivateNowPanel(value)
    {
        var panels = document.getElementsByClassName('activate_now_panel');
        for (var i = 0; i < panels.length; i++) {
            if (value) {
                panels[i].style.display = 'none';
            } else {
                panels[i].style.display = '';
            }
        }
    }

    function invalidateSelectPoolPanel(value)
    {
        var panel = document.getElementById('select_pool_panel');
        var anchor = document.getElementById('first_free_anchor');

        if (value) {
            panel.style.display = 'none';
            anchor.style.display = 'none';
        } else {
            panel.style.display = '';
            anchor.style.display = '';
        }
    }
    

    
</script>
{/literal}

{/block}

{block name="extra-css-styles" append}
<link href="plugins/LMSAdescomPlugin/img/styles.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="plugins/LMSAdescomPlugin/img/autosuggest.js"></script>
<script type="text/javascript" src="plugins/LMSAdescomPlugin/img/scripts.js"></script>
{/block}

{block name="voipaccountaddbox-extra" append}

{$xajax}

{literal}
<script language="javascript">

    var phone_profile = document.getElementById('voipaccountdata_phoneid');
    
    addLoadEvent(xajax_select_phone.bind(undefined, phone_profile.value));

    addLoadEvent(loadVoipAccountsStates);
    
</script>
{/literal}

{/block}