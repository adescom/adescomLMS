{extends file="layout.html"}
{block name=title}::: LMS :{$layout.pagetitle|striphtml} :::{/block}
{block name="extra-css-styles" append}
<link href="plugins/LMSAdescomPlugin/img/styles.css" rel="stylesheet" type="text/css">
{/block}
{block name=module_content}
<h1>{$layout.pagetitle}</h1>

<form action="?m=voipaccountpaneluseradd&customer_id={$customer_id}" method="POST">
    <fieldset class="adescom-fieldset form_2_columns">
        <legend>{t}Panel user settings{/t}</legend>
        
        <fieldset class="adescom-fieldset form_column">
            <legend>{t}Base configuration{/t}</legend>
            
            <ul class="block">
                <li>
                    <label for="panel_user_name"> {t}Name{/t}</label>
                    <input id="panel_user_name" type="text" name="name" 
                           {tip trigger="name" text="Enter panel user name (login)"}
                           {if $post_data && !empty($post_data.name)}value="{$post_data.name}"{/if}>
                </li>
                <li>
                    <label for="panel_user_password"> {t}Password{/t}</label>
                    <input id="panel_user_password" type="password" name="password"
                           {tip trigger="password" text="Enter panel user password"}
                           {if $post_data && !empty($post_data.password)}value="{$post_data.password}"{/if}>
                </li>
                <li>
                    <label for="panel_user_password_repeat"> {t}Password (repeat){/t}</label>
                    <input id="panel_user_password_repeat" type="password" name="password_repeat"
                           {tip trigger="password_repeat" text="Repeat panel user password"}
                           {if $post_data && !empty($post_data.password_repeat)}value="{$post_data.password_repeat}"{/if}>
                </li>
                <li>
                    <label for="panel_user_enable_webservices"> {t}Enable webservices{/t}</label>
                    <input type='hidden' value='off' name="enable_webservices">
                    <input id="panel_user_enable_webservices" type="checkbox" name="enable_webservices"
                           {tip trigger="enable_webservices" text="Select to grant webservices access for this panel user"}
                           {if $post_data && $post_data.enable_webservices}selected="selected"{/if}>
                </li>
                <li>
                    <label for="panel_user_enable_sms_webservices"> {t}Enable SMS webservices{/t}</label>
                    <input type='hidden' value='off' name="enable_sms_webservices">
                    <input id="panel_user_enable_sms_webservices" type="checkbox" name="enable_sms_webservices"
                           {tip trigger="enable_webservices" text="Select to grant SMS webservices access for this panel user"}
                           {if $post_data && $post_data.enable_sms_webservices}selected="selected"{/if}>
                </li>
                {if $clids}
                <li>
                    <label for="panel_user_clids"> {t}Phone clids{/t}</label>
                    <select name="clids[]" multiple="multiple" {tip trigger="clids" text="Select to grant clid access for this panel user"}>
                        {foreach from=$clids item=clid}
                        <option value="{$clid.phone}" {if $post_data && $post_data.clids && in_array($clid.phone, $post_data.clids)}selected="selected"{/if}>
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
                        <option value="{$trunk.id}" {if $post_data && $post_data.trunks && in_array($trunk.id, $post_data.trunks)}selected="selected"{/if}>
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
                               {if $post_data && $post_data.credentials && array_key_exists("Superuser", $post_data.credentials)}checked="checked"{/if}>
                        {t}Superuser{/t}
                    </label>
                    <ul>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Billing]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Billing", $post_data.credentials)}checked="checked"{/if}>
                                {t}Billing{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Callcenter]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Callcenter", $post_data.credentials)}checked="checked"{/if}>
                                {t}Callcenter{/t}
                            </label>
                            <ul>
                                <li>
                                    <label>
                                        <input type="checkbox" name="credentials[IVR]"
                                               {if $post_data && $post_data.credentials && array_key_exists("IVR", $post_data.credentials)}checked="checked"{/if}>
                                        {t}IVR{/t}
                                    </label>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Centrex]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Centrex", $post_data.credentials)}checked="checked"{/if}>
                                {t}Centrex{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Conferences]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Conferences", $post_data.credentials)}checked="checked"{/if}>
                                {t}Conferences{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[FAX]"
                                       {if $post_data && $post_data.credentials && array_key_exists("FAX", $post_data.credentials)}checked="checked"{/if}>
                                {t}Fax{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Finance]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Finance", $post_data.credentials)}checked="checked"{/if}>
                                {t}Finance{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Graylist]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Graylist", $post_data.credentials)}checked="checked"{/if}>
                                {t}Graylist{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Huntgroups]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Huntgroups", $post_data.credentials)}checked="checked"{/if}>
                                {t}Huntgroups{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Manage panel users]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Manage panel users", $post_data.credentials)}checked="checked"{/if}>
                                {t}Manage panel users{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Mass dial]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Mass dial", $post_data.credentials)}checked="checked"{/if}>
                                {t}Mass dial{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Moh]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Moh", $post_data.credentials)}checked="checked"{/if}>
                                {t}Moh{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[My numbers]"
                                       {if $post_data && $post_data.credentials && array_key_exists("My numbers", $post_data.credentials)}checked="checked"{/if}>
                                {t}My numbers{/t}
                            </label>
                            <ul>
                                <li>
                                    <label>
                                        <input type="checkbox" name="credentials[Edit clid password]"
                                               {if $post_data && $post_data.credentials && array_key_exists("Edit clid password", $post_data.credentials)}checked="checked"{/if}>
                                        {t}Edit clid password{/t}
                                    </label>
                                </li>
                                <li>
                                    <label>
                                        <input type="checkbox" name="credentials[Show clid password]"
                                               {if $post_data && $post_data.credentials && array_key_exists("Show clid password", $post_data.credentials)}checked="checked"{/if}>
                                        {t}Show clid password{/t}
                                    </label>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Organizational groups]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Organizational groups", $post_data.credentials)}checked="checked"{/if}>
                                {t}Organizational groups{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Phonebook]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Phonebook", $post_data.credentials)}checked="checked"{/if}>
                                {t}Phonebook{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Pickup groups]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Pickup groups", $post_data.credentials)}checked="checked"{/if}>
                                {t}Pickup groups{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Recordings]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Recordings", $post_data.credentials)}checked="checked"{/if}>
                                {t}Recordings{/t}
                            </label>
                            <ul>
                                <li>
                                    <label>
                                        <input type="checkbox" name="credentials[Allowed show all]"
                                               {if $post_data && $post_data.credentials && array_key_exists("Allowed show all", $post_data.credentials)}checked="checked"{/if}>
                                        {t}Allowed show all{/t}
                                    </label>
                                </li>
                                <li>
                                    <label>
                                        <input type="checkbox" name="credentials[Delete recordings]"
                                               {if $post_data && $post_data.credentials && array_key_exists("Delete recordings", $post_data.credentials)}checked="checked"{/if}>
                                        {t}Delete recordings{/t}
                                    </label>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Sounds]"
                                       {if $post_data && $post_data.credentials && array_key_exists("Sounds", $post_data.credentials)}checked="checked"{/if}>
                                {t}Sounds{/t}
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" name="credentials[Voicemail]"
                                       {if ($post_data && $post_data.credentials && array_key_exists('Voicemail', $post_data.credentials))}checked="checked"{/if}>
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