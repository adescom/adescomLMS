<table class="lmsbox">
    <thead>
        <tr class="hand">
            <th onclick="showOrHide('voipaccountadd-services-panel');"><img src="img/voip.gif"> {trans('Services options')}:</th>
        </tr>
    </thead>
    <tbody id="voipaccountadd-services-panel" style="display: none;">
        <tr>
            <td>{include file="voipaccount/addbox/services/clip.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/addbox/services/clir.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/addbox/services/dnd.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/addbox/services/hotline.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/addbox/services/conference.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/addbox/services/wakeup.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/addbox/services/forwarding.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/addbox/services/fax2mail.tpl"}</td>
        </tr>	
        <tr>
            <td>{include file="voipaccount/addbox/services/transfers.tpl"}</td>
        </tr>
        <tr>
            <td>{include file="voipaccount/addbox/services/ocb.tpl"}</td>
        </tr>
    </tbody>
</table>