{extends file="layout.html"}
{block name=title}::: LMS :{$layout.pagetitle|striphtml} :::{/block}
{block name="extra-css-styles" append}
<link href="plugins/LMSAdescomPlugin/img/styles.css" rel="stylesheet" type="text/css">
{/block}
{block name=module_content}
<h1>{$layout.pagetitle}</h1>

<form action="?m=voipaccountpaneluseredit&id={$panel_user->getId()}&customer_id={$customer_id}" method="POST">
    <fieldset class="adescom-fieldset form_2_columns">
        <legend>{t}Panel user settings{/t}</legend>
        
        <fieldset class="adescom-fieldset form_column">
            <legend>{t}Base configuration{/t}</legend>
            
            <ul class="block">
                <li>
                    <label for="panel_user_name"> {t}Name{/t}</label>
                    <input id="panel_user_name" type="text" name="name" 
                           {tip trigger="name" text="Enter panel user name (login)"}
                           value="{$panel_user->getName()}">
                </li>
                <li>
                    <label for="panel_user_password"> {t}Password{/t}</label>
                    <input id="panel_user_password" type="password" name="password"
                           {tip trigger="password" text="Enter panel user password"}
                           value="{$panel_user->getPassword()}">
                </li>
                <li>
                    <label for="panel_user_password_repeat"> {t}Password (repeat){/t}</label>
                    <input id="panel_user_password_repeat" type="password" name="password_repeat"
                           {tip trigger="password_repeat" text="Repeat panel user password"}
                           value="{$panel_user->getPassword()}">
                </li>
                <li>
                    <label for="panel_user_enable_webservices"> {t}Enable webservices{/t}</label>
                    <input type='hidden' value='off' name="enable_webservices">
                    <input id="panel_user_enable_webservices" type="checkbox" name="enable_webservices"
                           {tip trigger="enable_webservices" text="Select to grant webservices access for this panel user"}
                           {if $panel_user->getEnableWebservices()}selected="selected"{/if}>
                </li>
                <li>
                    <label for="panel_user_enable_sms_webservices"> {t}Enable SMS webservices{/t}</label>
                    <input type='hidden' value='off' name="enable_sms_webservices">
                    <input id="panel_user_enable_sms_webservices" type="checkbox" name="enable_sms_webservices"
                           {tip trigger="enable_webservices" text="Select to grant SMS webservices access for this panel user"}
                           {if $panel_user->getEnableSmsWebservices()}selected="selected"{/if}>
                </li>
                {if $clids}
                <li>
                    <label for="panel_user_clids"> {t}Phone clids{/t}</label>
                    <select name="clids[]" multiple="multiple" {tip trigger="clids" text="Select to grant clid access for this panel user"}>
                        {foreach from=$clids item=clid}
                        <option value="{$clid.phone}" {if $panel_user->getClids() && in_array($clid.phone, $panel_user->getClids()->getItems())}selected="selected"{/if}>
                            {$clid.phone}
                        </option>
                        {/foreach}
                    </select>
                </li>
                {/if}
                {if $trunks}
                <li>
                    <label for="panel_user_trunks"> {t}Trunks{/t}</label>
                    <select name="trunks[]" multiple="multiple" {tip trigger="trunks" text="Select to grant trunk access for this panel user"}>
                        {foreach from=$trunks item=trunk}
                        <option value="{$trunk.id}" {if $panel_user->getTrunks() && in_array($trunk.id, $panel_user->getTrunks()->getItems())}selected="selected"{/if}>
                            {$trunk.id}
                        </option>
                        {/foreach}
                    </select>
                </li>
                {/if}
            </ul>
            
        </fieldset>
            
        <fieldset class="adescom-fieldset form_column">
            <legend>{t}Credentials configuration{/t}</legend>
            
            <ul>
                <li>
                    <label>
                        <input type="checkbox" name="credentials[Superuser]"
                               {if $credentials_selected && in_array("Superuser", $credentials_selected)}checked="checked"{/if}>
                        {t}Superuser{/t}
                    </label>
                    <ul>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Billing]"
                                       {if $credentials_selected && in_array("Billing", $credentials_selected)}checked="checked"{/if}>
                                {t}Billing{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Callcenter]"
                                       {if $credentials_selected && in_array("Callcenter", $credentials_selected)}checked="checked"{/if}>
                                {t}Callcenter{/t}
                            </label>
                            <ul>
                                <li>
                                    <label>
                                        <input type="checkbox" name="credentials[IVR]"
                                               {if $credentials_selected && in_array("IVR", $credentials_selected)}checked="checked"{/if}>
                                        {t}IVR{/t}
                                    </label>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Centrex]"
                                       {if $credentials_selected && in_array("Centrex", $credentials_selected)}checked="checked"{/if}>
                                {t}Centrex{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Conferences]"
                                       {if $credentials_selected && in_array("Conferences", $credentials_selected)}checked="checked"{/if}>
                                {t}Conferences{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[FAX]"
                                       {if $credentials_selected && in_array("FAX", $credentials_selected)}checked="checked"{/if}>
                                {t}Fax{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Finance]"
                                       {if $credentials_selected && in_array("Finance", $credentials_selected)}checked="checked"{/if}>
                                {t}Finance{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Graylist]"
                                       {if $credentials_selected && in_array("Graylist", $credentials_selected)}checked="checked"{/if}>
                                {t}Graylist{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Huntgroups]"
                                       {if $credentials_selected && in_array("Huntgroups", $credentials_selected)}checked="checked"{/if}>
                                {t}Huntgroups{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Manage panel users]"
                                       {if $credentials_selected && in_array("Manage panel users", $credentials_selected)}checked="checked"{/if}>
                                {t}Manage panel users{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Mass dial]"
                                       {if $credentials_selected && in_array("Mass dial", $credentials_selected)}checked="checked"{/if}>
                                {t}Mass dial{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Moh]"
                                       {if $credentials_selected && in_array("Moh", $credentials_selected)}checked="checked"{/if}>
                                {t}Moh{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[My numbers]"
                                       {if $credentials_selected && in_array("My numbers", $credentials_selected)}checked="checked"{/if}>
                                {t}My numbers{/t}
                            </label>
                            <ul>
                                <li>
                                    <label>
                                        <input type="checkbox" name="credentials[Edit clid password]"
                                               {if $credentials_selected && in_array("Edit clid password", $credentials_selected)}checked="checked"{/if}>
                                        {t}Edit clid password{/t}
                                    </label>
                                </li>
                                <li>
                                    <label>
                                        <input type="checkbox" name="credentials[Show clid password]"
                                               {if $credentials_selected && in_array("Show clid password", $credentials_selected)}checked="checked"{/if}>
                                        {t}Show clid password{/t}
                                    </label>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Organizational groups]"
                                       {if $credentials_selected && in_array("Organizational groups", $credentials_selected)}checked="checked"{/if}>
                                {t}Organizational groups{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Phonebook]"
                                       {if $credentials_selected && in_array("Phonebook", $credentials_selected)}checked="checked"{/if}>
                                {t}Phonebook{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Pickup groups]"
                                       {if $credentials_selected && in_array("Pickup groups", $credentials_selected)}checked="checked"{/if}>
                                {t}Pickup groups{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Recordings]"
                                       {if $credentials_selected && in_array("Recordings", $credentials_selected)}checked="checked"{/if}>
                                {t}Recordings{/t}
                            </label>
                            <ul>
                                <li>
                                    <label>
                                        <input type="checkbox" name="credentials[Allowed show all]"
                                               {if $credentials_selected && in_array("Allowed show all", $credentials_selected)}checked="checked"{/if}>
                                        {t}Allowed show all{/t}
                                    </label>
                                </li>
                                <li>
                                    <label>
                                        <input type="checkbox" name="credentials[Delete recordings]"
                                               {if $credentials_selected && in_array("Delete recordings", $credentials_selected)}checked="checked"{/if}>
                                        {t}Delete recordings{/t}
                                    </label>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Sounds]"
                                       {if $credentials_selected && in_array("Sounds", $credentials_selected)}checked="checked"{/if}>
                                {t}Sounds{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Voicemail]"
                                       {if ($credentials_selected && in_array('Voicemail', $credentials_selected))}checked="checked"{/if}>
                                {t}Voicemail{/t}
                            </label>
                        </li>
                    </ul>
                </li>
            </ul>
            
        </fieldset>
        
        <fieldset class="adescom-fieldset form_buttons">
            <button type="submit">
                <img src="img/save.gif"/>
                {t}Save{/t}
            </button>
        </fieldset>
    </fieldset>
</form>
{/block}