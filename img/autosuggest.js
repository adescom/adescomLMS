/*******************************************************
 AutoSuggest - a javascript automatic text input completion component
 Copyright (C) 2005 Joe Kepley, The Sling & Rock Design Group, Inc.
 
 WWW: http://www.gadgetopia.com/autosuggest/
 
 Licensed under GNU Lesser General Public License (LGPL).
 Modified by kondi for LMS project (mailto:lms@kondi.net).
 *******************************************************/

function AdescomAutoSuggest(form, elem, uri, autosubmit, idelem) {

    var me = this;

    this.elem = elem;
    this.form = form;
    this.uri = uri;
    this.autosubmit = autosubmit;
    this.idelem = idelem;

    this.eligible = [];

    this.inputText = null;

    this.highlighted = -1;

    this.div = document.getElementById("autosuggest");

    var ENT = 3;
    var RET = 13;
    var TAB = 9;
    var ESC = 27;
    var KEYUP = 38;
    var KEYDN = 40;

    elem.setAttribute("autocomplete", "off");

    if (!elem.id) {
        var id = "autosuggest" + idCounter;
        idCounter++;

        elem.id = id;
    }

    elem.onkeydown = function (ev) {
        var key = me.getKeyCode(ev);

        switch (key) {
            case ENT:
            case RET:
                me.useSuggestion();
                break;

            case TAB:
                me.useSuggestion();
                break;

            case ESC:
                me.hideDiv();
                break;

            case KEYUP:
                if (me.highlighted > 0) {
                    me.highlighted--;
                }
                me.changeHighlight(key);
                break;

            case KEYDN:
                if (me.highlighted < (me.eligible.length - 1)) {
                    me.highlighted++;
                }
                me.changeHighlight(key);
                break;
        }
    };

    elem.onkeyup = function (ev) {
        var key = me.getKeyCode(ev);
        switch (key) {
            case ENT:
            case RET:
            case TAB:
            case ESC:
            case KEYUP:
            case KEYDN:
                return;
            default:

                if (this.value !== me.inputText && this.value.length > 0) {
                    me.HTTPpreload();
                } else {
                    me.hideDiv();
                }
        }
    };

    this.HTTPloaded = function () {
        if ((xmlhttp) && (xmlhttp.readyState === 4)) {
            me.inputText = this.value;
            me.getEligible();
            if (me.eligible.length > 0) {
                me.createDiv();
                me.positionDiv();
                me.showDiv();
            } else {
                me.hideDiv();
            }
        }
    };

    this.useSuggestion = function () {
        if (this.highlighted > -1) {
            this.elem.value = this.eligible[this.highlighted];
            var gotothisuri = this.actions[this.highlighted];
            if (this.idelem) {
                this.idelem.value = this.ids[this.highlighted];
            }
            this.hideDiv();
            setTimeout("document.getElementById('" + this.elem.id + "').focus()", 0);
            this.form.onsubmit = function () {
                return false;
            };
            setTimeout("document.getElementById('" + this.form.id + "').onsubmit = function () { return true; }", 10);

            if (this.autosubmit == 1) {
                location.href = gotothisuri;
            }
        }
    };

    this.showDiv = function () {
        this.div.style.display = 'block';
    };

    this.hideDiv = function () {
        this.div.style.display = 'none';
        this.highlighted = -1;
    };

    this.changeHighlight = function () {
        var lis = this.div.getElementsByTagName('LI');
        for (var i = 0, len = lis.length; i < len; i++) {
            var li = lis[i];

            if (this.highlighted === i) {
                li.className = "selected";
            } else {
                li.className = "";
            }
        }
    };

    this.positionDiv = function () {
        var el = this.elem;
        var x = 0;
        var y = el.offsetHeight;

        while (el.offsetParent && el.tagName.toUpperCase() !== 'BODY') {
            x += el.offsetLeft;
            y += el.offsetTop;
            el = el.offsetParent;
        }

        x += el.offsetLeft;
        y += el.offsetTop;

        this.div.style.left = x + 'px';
        this.div.style.top = y + 'px';
    };

    this.createDiv = function () {
        var ul = document.createElement('ul');

        for (var i = 0, len = this.eligible.length; i < len; i++) {
            var word = this.eligible[i];
            var desc = (this.descriptions[i]) ? this.descriptions[i] : '';
            var dest = (this.actions[i]) ? this.actions[i] : '';

            var ds = document.createElement('span');
            var li = document.createElement('li');
            var a = document.createElement('a');
            if ((dest) && (!this.autosubmit) && !this.idelem) {
                a.href = dest;
                a.innerHTML = word;
                li.onclick = function () {
                    me.useSuggestion();
                };
                li.appendChild(a);
            } else {
                li.innerHTML = word;
                li.onclick = function () {
                    me.useSuggestion();
                };
            }
            ds.innerHTML = desc;
            li.appendChild(ds);

            if (me.highlighted === i) {
                li.className = "selected";
            }

            ul.appendChild(li);
        }

        this.div.replaceChild(ul, this.div.childNodes[0]);

        ul.onmouseover = function (ev) {
            var target = me.getEventSource(ev);
            while (target.parentNode && target.tagName.toUpperCase() !== 'LI') {
                target = target.parentNode;
            }

            var lis = me.div.getElementsByTagName('LI');

            for (var i = 0, len = lis.length; i < len; i++) {
                var li = lis[i];
                if (li == target) {
                    me.highlighted = i;
                    break;
                }
            }
            me.changeHighlight();
        };

        this.div.className = "suggestion_list";
        this.div.style.position = 'absolute';
    };

    this.setXMLHTTP = function () {
        var x = null;
        try {
            x = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                x = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (ee) {
                x = null;
            }
        }
        if (!x && typeof XMLHttpRequest !== "undefined") {
            x = new XMLHttpRequest();
        }
        return x;
    };

    this.HTTPpreload = function () {
        xmlhttp = me.setXMLHTTP();
        xmlhttp.onreadystatechange = this.HTTPloaded;
        xmlhttp.open("GET", this.uri + encodeURI(this.elem.value), true);
        xmlhttp.send(null);
    };

    this.getEligible = function () {
        this.eligible = Array();
        this.descriptions = Array();
        this.actions = Array();
        this.ids = Array();

        try {
            eval(xmlhttp.responseText);
        } catch (x) {
            this.eligible = Array();
        }

        if (this.suggestions) {
            for (var i = 0, len = this.suggestions.length; i < len; i++) {
                var suggestion = this.suggestions[i];

                if (suggestion.toLowerCase().indexOf(this.inputText.toLowerCase()) === "0") {
                    this.eligible[this.eligible.length] = suggestion;
                }
            }
        }
    };

    this.getKeyCode = function (ev) {
        if (ev) {
            return ev.keyCode;
        }
        if (window.event) {
            return window.event.keyCode;
        }
    };

    this.getEventSource = function (ev) {
        if (ev) {
            return ev.target;
        }
        if (window.event) {
            return window.event.srcElement;
        }
    };

    this.cancelEvent = function (ev) {
        if (ev) {
            ev.preventDefault();
            ev.stopPropagation();
        }
        if (window.event) {
            window.event.returnValue = false;
        }
    };
}
