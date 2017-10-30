<table class="lmsbox">
    <colgroup>
        <col style="width: 1%;"/>
        <col style="width: 1%;"/>
        <col style="width: 98%;"/>
    </colgroup>
    <thead>
        <tr class="hand">
            <th colspan="3" onclick="showOrHide('voipaccountedit-services-clip-panel');"><img src="img/voip.gif"> {trans('CLIP options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountedit-services-clip-panel" style="display: none;">
        <tr>
            <td></td>
            <td><label for="voipaccountedit_clip">{t}CLIP{/t}</label></td>
            <td><input type="checkbox" value="1" name="voipaccountedit[clip]" id="voipaccountedit_clip" {if $voipaccountinfo.clip}CHECKED{/if} {tip text="Select to enable CLIP" trigger="clip"}></td>
        </tr>
    </tbody>
</table>