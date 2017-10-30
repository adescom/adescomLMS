<input type="hidden" id="voipaccountedit_countrycode" name="voipaccountedit[countrycode]" id="voipaccountedit_countrycode" value="{$voipaccountinfo.countrycode}">
<input type="hidden" id="voipaccountedit_areacode" name="voipaccountedit[areacode]" id="voipaccountedit_areacode" value="{$voipaccountinfo.areacode}">
<input type="hidden" id="voipaccountedit_shortclid" name="voipaccountedit[shortclid]" id="voipaccountedit_shortclid" value="{$voipaccountinfo.shortclid}">
<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountedit-voip-panel');"><img src="img/voip.gif"> {trans('VoIP options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountedit-voip-panel" style="display: none;">
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_ctmid">{t}CTM:{/t}</label>
            </td>
            <td>
                <select size="1" name="voipaccountedit[ctmid]" id="voipaccountedit_ctmid" {tip text="Adescom CTM node" trigger="ctmid"} style="max-width:250px;">
                    {foreach from=$ctms item=ctm}
                    <option value="{$ctm.id}"{if $voipaccountinfo.ctmid == $ctm.id} selected="selected"{/if}>{$ctm.name}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_registration_type">{t}Registration type:{/t}</label>
            </td>
            <td>
                <select size="1" name="voipaccountedit[registration_type]" id="voipaccountedit_registration_type" {tip text="Phone registration type" trigger="registration_type"} style="max-width:250px;">
                    <option value="country+area+local" {if $voipaccountinfo.registration_type == 'country+area+local'}selected="selected"{/if}>country+area+local</option>
                    <option value="area+local" {if $voipaccountinfo.registration_type == 'area+local'}selected="selected"{/if}>area+local</option>
                    <option value="local" {if $voipaccountinfo.registration_type == 'local'}selected="selected"{/if}>local</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_phoneid">{t}Phone profile:{/t}</label>
            </td>
            <td>
                <select size="1" name="voipaccountedit[phoneid]" id="voipaccountedit_phoneid" {tip text="Phone profile" trigger="phoneid"} style="max-width:250px;" onchange="xajax_select_phone(this.value);">
                    {foreach from=$phones item=phone}
                    <option value="{$phone.id}"{if $voipaccountinfo.phoneid == $phone.id} selected="selected"{/if}>{$phone.name}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_line">{t}Phone line:{/t}</label>
            </td>
            <td id="voipaccountdata_line_parent">
                {if $selectedPhone}
                <select size="1" name="voipaccountedit[line]" id="voipaccountedit_line" {tip text="Phone line" trigger="line"} style="max-width:250px;">
                    {foreach from=$selectedPhone.lines item=line}
                    <option value="{$line}" {if $voipaccountinfo.line == $line}selected="selected"{/if}>{$line}</option>
                    {/foreach}
                </select>
                {else}
                <label for="">{t}Select phone profile first...{/t}</label>
                {/if}
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_displayname">{t}Display name:{/t}</label>
            </td>
            <td>
                <input type="text" name="voipaccountedit[displayname]" id="voipaccountedit_displayname" value="{$voipaccountinfo.displayname}" {tip text="Enter friendly display name" trigger="displayname"}>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_email">{t}E-mail:{/t}</label>
            </td>
            <td>
                <input type="text" name="voipaccountedit[email]" id="voipaccountedit_email" value="{$voipaccountinfo.email}" {tip text="Enter e-mail address" trigger="email"}>
                <a href="#" accesskey="s" onclick="xajax_customer_email(document.getElementById('voipaccountdata_ownerid').value);"><img src="img/mail.gif" alt="{t}get email from client settings{/t}"></a>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_context">{t}Context:{/t}</label>
            </td>
            <td>
                <select size="1" name="voipaccountedit[context]" id="voipaccountedit_context" {tip text="Main phone context" trigger="context"} style="max-width:250px;">
                    {foreach from=$contexts item=context}
                    <option value="{$context.name}"{if $voipaccountinfo.context == $context.name} selected{/if}>{$context.name}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                {t}Emergency context:{/t}
            </td>
            <td>
                <label for="emergencycontext_by_group">{t}by group{/t}</label>
                <input type="radio" id="emergencycontext_by_group"
                       name="voipaccountedit[emergencycontext_type]"
                       value='by_group'>
                <label for="emergencycontext_by_city">{t}by city{/t}</label>
                <input type="radio" id="emergencycontext_by_city"
                       name="voipaccountedit[emergencycontext_type]"
                       value='by_city'>
            </td>
        </tr>
        <tr id="select_group_panel">
            <td>
            </td>
            <td>
                <label for="voipaccountedit_emergencycontext">{t}Select context{/t}:</label>
            </td>
            <td>
                <select size="1" name="voipaccountedit[emergencycontext]" id="voipaccountedit_emergencycontext"
                    {tip text="Emergency context" trigger="emergencycontext"} style="max-width:250px;">
                    {foreach from=$contexts_emergency item=context}
                    <option value="{$context.name}"{if $voipaccountinfo.emergencycontext == $context.name} selected{/if}>{$context.name}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr id="select_state_panel">
            <td>
            </td>
            <td>
                <label for="select_state">{t}Select state{/t}:</label>
            </td>
            <td>
                <select size="1" name="voipaccountedit[emergencycontext_state_id]" id="select_state"
                    {tip text="Emergency context state" trigger="emergencycontext_state_id"} style="max-width:250px;">
                    {foreach from=$contexts_emergency_states->getItems() item=state}
                    <option value="{$state->getId()}"{if $voipaccountinfo.emergencycontext_state_id == $state->getId()} selected="selected"{/if}>{$state->getName()}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr id="select_county_panel">
            <td>
            </td>
            <td>
                <label for="select_county">{t}Select county{/t}:</label>
            </td>
            <td>
                <select size="1" name="voipaccountedit[emergencycontext_county_id]" id="select_county" 
                    {tip text="Emergency context county" trigger="emergencycontext_county_id"} style="max-width:250px;">
                    {if $contexts_emergency_counties}
                    {foreach from=$contexts_emergency_counties->getItems() item=county}
                    <option value="{$county->getId()}"{if $contexts_emergency_commune->getCountyId() == $county->getId()} selected="selected"{/if}>{$county->getName()}</option>
                    {/foreach}
                    {/if}
                </select>
            </td>
        </tr>
        <tr id="select_commune_panel">
            <td>
            </td>
            <td>
                <label for="select_commune">{t}Select commune{/t}:</label>
            </td>
            <td>
                <select size="1" name="voipaccountedit[emergencycontext_from_commune]" id="select_commune"
                    {tip text="Emergency context state" trigger="emergencycontext_state_id"} style="max-width:250px;">
                    {if $contexts_emergency_communes}
                    {foreach from=$contexts_emergency_communes->getItems() item=commune}
                    <option value="{$commune->getEmergencyContext()}"{if $contexts_emergency_commune->getId() == $commune->getId()} selected="selected"{/if}>{$commune->getName()}</option>
                    {/foreach}
                    {/if}
                </select>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_host">{t}IP address:{/t}</label>
            </td>
            <td>
                <input type="text" name="voipaccountedit[host]" id="voipaccountedit_host" id="voipaccountedit_host" value="{$voipaccountinfo.host}" {tip text="Enter host IP address ('dynamic' for address from DHCP server)" trigger="host"}>
                <img src="img/ip.gif" alt="{t}Host IP address from DHCP server{/t}" TITLE="{t}Host IP address from DHCP server{/t}" style="cursor: pointer" ONCLICK="document.getElementById('voipaccountedit_host').value = 'dynamiczny'">
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_hostname">{t}Host name:{/t}</label>
            </td>
            <td>
                <input type="text" name="voipaccountedit[hostname]" id="voipaccountedit_hostname" value="{$voipaccountinfo.hostname}" {tip text="Enter phone device ost name" trigger="hostname"}>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_mac_address">{t}MAC address:{/t}</label>
            </td>
            <td>
                <input type="text" name="voipaccountedit[mac_address]" id="voipaccountedit_mac_address" value="{$voipaccountinfo.mac_address}" {tip text="Enter MAC address of phone device" trigger="mac_address"}>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_serial_number">{t}Serial number:{/t}</label>
            </td>
            <td>
                <input type="text" name="voipaccountedit[serial_number]" id="voipaccountedit_serial_number" value="{$voipaccountinfo.serial_number}" {tip text="Enter serial number of phone device" trigger="serial_number"}>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_voicemail">{t}Enable voicemail:{/t}</label>
            </td>
            <td>
                <input type="checkbox" value="1" name="voipaccountedit[voicemail]" id="voipaccountedit_voicemail" {if $voipaccountinfo.voicemail}CHECKED{/if} {tip text="Select to enable voicemail" trigger="voicemail"} ONCLICK="toggleVoiceMailConfiguration(this.checked)">
            </td>
        </tr>
        <tr id="voicemail_password_row" class="voicemail_configuration" {if !$voipaccountinfo.voicemail}style="display: none"{/if}>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_voicemailpassword">{t}Voicemail password:{/t}</label>
            </td>
            <td>
                <input type="text" name="voipaccountedit[voicemailpassword]" id="voipaccountedit_voicemailpassword" value="{$voipaccountinfo.voicemailpassword}" {tip text="Enter voicemail password" trigger="voicemailpassword"}>
            </td>
        </tr>
        <tr id="voicemail_attach_row" class="voicemail_configuration" {if !$voipaccountinfo.voicemail}style="display: none"{/if}>
            <td>
            </td>
            <td>
                <label for="voipaccountedit_voicemailattach">{t}Send voicemail messages via e-mail:{/t}</label>
            </td>
            <td>
                <input type="checkbox" name="voipaccountedit[voicemailattach]" id="voipaccountedit_voicemailattach" {if $voipaccountinfo.voicemailattach}CHECKED{/if} {tip text="Select to enabled sending of voice messages via e-mail" trigger="voicemailattach"}>
            </td>
        </tr>				
    </tbody>
</table>

<script>{include file="voipaccount/emergency_context.js"}</script>
    
<script>
    {if $voipaccountinfo.geoLocationCommuneID}
    ec.initialize(true);
    {else}
    ec.initialize(false);
    {/if}
</script>
    