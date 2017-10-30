function addLoadEvent(func) {
    var oldonload = window.onload;
    if (typeof window.onload !== 'function') {
        window.onload = func;
    } else {
        window.onload = function () {
            if (oldonload) {
                oldonload();
            }
            func();
        }
    }
}

addLoadEvent(function () {
    if (document.getElementsByClassName === undefined) {
        document.getElementsByClassName = function (className) {
            var hasClassName = new RegExp("(?:^|\\s)" + className + "(?:$|\\s)");
            var allElements = document.getElementsByTagName("*");
            var results = [];
            var element;
            for (var i = 0; (element = allElements[i]) !== null; i++) {
                var elementClass = element.className;
                if (elementClass && elementClass.indexOf(className) !== -1 && hasClassName.test(elementClass))
                    results.push(element);
            }
            return results;
        };
    }
});

function loadVoipAccountsStates() {
    if (xajax_load_voip_accounts_states === undefined) {
        console.log('xajax_load_voip_accounts_states not defined!');
        return;
    }
    var voip_accounts_rows = document.getElementsByClassName('voip_account');
    if (voip_accounts_rows.length !== 0) {
        var voip_accounts_id = new Array();
        var prefix = 'voip_account_';
        var prefix_length = prefix.length;
        var voip_accounts_count = voip_accounts_rows.length;
        for (var i = 0 ; i < voip_accounts_count ; i++) {
            var row_id = voip_accounts_rows[i].id;
            var id = parseInt(row_id.substr(prefix_length));
            voip_accounts_id.push(id);
        }
        var per_package = 10;
        for (var p = 0 ; p < voip_accounts_count ; p = p + per_package) {
            setTimeout(xajax_load_voip_accounts_states.bind(undefined, voip_accounts_id.slice(p, p + per_package)) , p * 100);
        }
    }
}