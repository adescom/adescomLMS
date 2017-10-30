<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountadd-voip-panel');"><img src="img/voip.gif"> {trans('VoIP options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountadd-voip-panel" style="display: none;">
        <tr>
            <td></td>
            <td>
                <label for="voipaccountdata_ctmid">{t}CTM:{/t}</label>
            </td>
            <td>
                <select size="1" name="voipaccountdata[ctmid]" id="voipaccountdata_ctmid" {tip text="Select Adescom CTM node" trigger="ctmid"} style="max-width:250px;">
                    {foreach from=$ctms item=ctm}
                    <option value="{$ctm.id}"{if $voipaccountdata.ctmid == $ctm.id} selected{/if}>{$ctm.name}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <label for="voipaccountdata_registration_type">{t}Registration type:{/t}</label>
            </td>
            <td>
                <select size="1" name="voipaccountdata[registration_type]" id="voipaccountdata_registration_type" {tip text="Select phone registration type" trigger="registration_type"} style="max-width:250px;">
                    <option value="country+area+local" {if $voipaccountdata.registration_type == 'country+area+local'} selected{/if}>country+area+local</option>
                    <option value="area+local" {if $voipaccountdata.registration_type == 'area+local'} selected{/if}>area+local</option>
                    <option value="local" {if $voipaccountdata.registration_type == 'local'} selected{/if}>local</option>
                </select>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <label for="voipaccountdata_phoneid">{t}Phone profile:{/t}</label>
            </td>
            <td>
                <select size="1" name="voipaccountdata[phoneid]" id="voipaccountdata_phoneid" {tip text="Select phone profile" trigger="phoneid"} style="max-width:250px;" onchange="xajax_select_phone(this.value);">
                    <option value="0"{if $voipaccountdata.phoneid == 0} selected='selected'{/if}></option>
                    {foreach from=$phones item=phone}
                    <option value="{$phone.id}"{if $voipaccountdata.phoneid == $phone.id} selected='selected'{/if}>{$phone.name}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <label for="voipaccountdata_line">{t}Phone line:{/t}</label>
            </td>
            <td id="voipaccountdata_line_parent">
                {if $selectedPhone}
                <select size="1" name="voipaccountdata[line]" id="voipaccountdata_line" {tip text="Select phone line" trigger="line"} style="max-width:250px;">
                    {foreach from=$selectedPhone.lines item=line}
                    <option value="{$line}" {if $voipaccountdata.line == $line}selected{/if}>{$line}</option>
                    {/foreach}
                </select>
                {else}
                <label for="voipaccountdata_line">{t}Select phone profile first...{/t}</label>
                {/if}
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <label for="voipaccountdata_displayname">{t}Display name:{/t}</label>
            </td>
            <td>
                <input type="text" name="voipaccountdata[displayname]" id="voipaccountdata_displayname" value="{$voipaccountdata.displayname}" {tip text="Enter friendly display name" trigger="displayname"}>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <label for="voipaccountdata_email">{t}E-mail:{/t}</label>
            </td>
            <td>
                <input type="text" name="voipaccountdata[email]" id="voipaccountdata_email" value="{$voipaccountdata.email}" {tip text="Enter e-mail address" trigger="email"}>
                <a href="#" accesskey="s" onclick="xajax_customer_email(document.getElementById('voipaccountadd_ownerid').value);"><img src="img/mail.gif" alt="{t}get email from client settings{/t}"></a>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <label for="voipaccountdata_context">{t}Context:{/t}</label>
            </td>
            <td>
                <select size="1" name="voipaccountdata[context]" id="voipaccountdata_context" {tip text="Select phone context" trigger="context"} style="max-width:250px;">
                    {foreach from=$contexts item=context}
                    <option value="{$context.name}"{if $voipaccountdata.context == $context.name} selected='selected'{/if}>{$context.name}</option>
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
                       name="voipaccountdata[emergencycontext_type]"
                       value='by_group'>
                <label for="emergencycontext_by_city">{t}by city{/t}</label>
                <input type="radio" id="emergencycontext_by_city"
                       name="voipaccountdata[emergencycontext_type]"
                       value='by_city'>
            </td>
        </tr>
        <tr id="select_group_panel">
            <td>
            </td>
            <td>
                <label for="voipaccountdata_emergencycontext">{t}Select context{/t}:</label>
            </td>
            <td>
                <select size="1" name="voipaccountdata[emergencycontext]" id="voipaccountdata_emergencycontext"
                    {tip text="Emergency context" trigger="emergencycontext"} style="max-width:250px;">
                    {foreach from=$contexts_emergency item=context}
                    <option value="{$context.name}"{if $voipaccountdata.emergencycontext == $context.name} selected{/if}>{$context.name}</option>
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
                <select size="1" name="voipaccountdata[emergencycontext_state_id]" id="select_state"
                    {tip text="Emergency context state" trigger="emergencycontext_state_id"} style="max-width:250px;">
                    {foreach from=$contexts_emergency_states->getItems() item=state}
                    <option value="{$state->getId()}"{if $voipaccountdata.emergencycontext_state_id == $state->getId()} selected{/if}>{$state->getName()}</option>
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
                <select size="1" name="voipaccountdata[emergencycontext_county_id]" id="select_county" 
                    {tip text="Emergency context county" trigger="emergencycontext_county_id"} style="max-width:250px;">
                    {if $contexts_emergency_counties}
                    {foreach from=$contexts_emergency_counties->getItems() item=county}
                    <option value="{$county->getId()}"{if $voipaccountdata.emergencycontext_county_id == $county->getId()} selected{/if}>{$county->getName()}</option>
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
                <select size="1" name="voipaccountdata[emergencycontext_from_commune]" id="select_commune"
                    {tip text="Emergency context state" trigger="emergencycontext_state_id"} style="max-width:250px;">
                    {if $contexts_emergency_communes}
                    {foreach from=$contexts_emergency_communes->getItems() item=commune}
                    <option value="{$commune->getEmergencyContext()}"{if $voipaccountdata.geoLocationCommuneID == $commune->getId()} selected{/if}>{$commune->getName()}</option>
                    {/foreach}
                    {/if}
                </select>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <label for="voipaccountdata_host">{t}IP address:{/t}</label>
            </td>
            <td>
                <input type="text" name="voipaccountdata[host]" id="voipaccountdata_host" id="voipaccountdata_host" value="{$voipaccountdata.host}" {tip text="Enter host IP address ('dynamic' for address from DHCP server)" trigger="host"}>
                <img src="img/ip.gif" alt="{t}Host IP address from DHCP server{/t}" title="{t}Host IP address from DHCP server{/t}" style="cursor: pointer" ONCLICK="document.getElementById('voipaccountdata_host').value = 'dynamiczny'">
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <label for="voipaccountdata_hostname">{t}Hostname:{/t}</label>
            </td>
            <td>
                <input type="text" name="voipaccountdata[hostname]" id="voipaccountdata_hostname" value="{$voipaccountdata.hostname}" {tip text="Enter phone device host name" trigger="hostname"}>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <label for="voipaccountdata_mac_address">{t}MAC address:{/t}</label>
            </td>
            <td>
                <input type="text" name="voipaccountdata[mac_address]" id="voipaccountdata_mac_address" value="{$voipaccountdata.mac_address}" {tip text="Enter MAC address of phone device" trigger="mac_address"}>
            </td>
        </tr>	
        <tr>
            <td></td>
            <td>
                <label for="voipaccountdata_serial_number">{t}Serial number:{/t}</label>
            </td>
            <td>
                <input type="text" name="voipaccountdata[serial_number]" id="voipaccountdata_serial_number" value="{$voipaccountdata.serial_number}" {tip text="Enter serial number of phone device" trigger="serial_number"}>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <label for="voipaccountdata_voicemail">{t}Enable voicemail:{/t}</label>
            </td>
            <td>
                <input type="checkbox" value="1" name="voipaccountdata[voicemail]" id="voipaccountdata_voicemail" {if $voipaccountdata.voicemail}CHECKED{/if} {tip text="Select to enable voicemail" trigger="voicemail"} onclick="toggleVoiceMailConfiguration(this.checked)">
            </td>
        </tr>
        <tr id="voicemail_password_row" class="voicemail_configuration" {if ! $voipaccountdata.voicemail}style="display: none"{/if}>
            <td></td>
            <td>
                <label for="voipaccountdata_voicemailpassword">{t}Voicemail password:{/t}</label>
            </td>
            <td>
                <input type="text" name="voipaccountdata[voicemailpassword]" id="voipaccountdata_voicemailpassword" value="{$voipaccountdata.voicemailpassword}" {tip text="Enter voicemail password" trigger="voicemailpassword"}>
            </td>
        </tr>
        <tr id="voicemail_attach_row" class="voicemail_configuration" {if ! $voipaccountdata.voicemail}style="display: none"{/if}>
            <td></td>
            <td>
                <label for="voipaccountdata_voicemailattach">{t}Send voicemail messages via e-mail:{/t}</label>
            </td>
            <td>
                <input type="checkbox" name="voipaccountdata[voicemailattach]" id="voipaccountdata_voicemailattach" {if $voipaccountdata.voicemailattach}CHECKED{/if} {tip text="Select to enabled sending of voice messages via e-mail" trigger="voicemailattach"}>
            </td>
        </tr>
    </tbody>
</table>

<script>{include file="voipaccount/emergency_context.js"}</script>
    
<script>
    {if $voipaccountdata.geoLocationCommuneID}
    ec.initialize(true);
    {else}
    ec.initialize(false);
    {/if}
</script>
    