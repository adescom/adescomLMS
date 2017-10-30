<table class="lmsbox">
    <thead>
        <tr class="hand">
            <th onclick="showOrHide('voipaccountedit-services-panel');"><img src="img/voip.gif"> {trans('Services options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountedit-services-panel" style="display: none;">
        <tr>
            <td>{include file="voipaccount/editbox/services/clip.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/editbox/services/clir.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/editbox/services/dnd.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/editbox/services/hotline.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/editbox/services/conference.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/editbox/services/wakeup.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/editbox/services/forwarding.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/editbox/services/fax2mail.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/editbox/services/transfers.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/editbox/services/ocb.tpl"}</td>
        </tr>
    </tbody>
</table>