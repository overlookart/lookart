!function() {
    "use strict";
    window.__firefox__ || (window.__firefox__ = {}),
    window.__firefox__.searchQueryForField = function() {
        var n = document.activeElement;
        if ("input" !== n.tagName.toLowerCase())
            return null;
        var e = n.form;
        if (!e || "get" != e.method.toLowerCase())
            return null;
        var t = e.getElementsByTagName("input"),
            o = (t = Array.prototype.slice.call(t, 0)).map(function(e) {
                return e.name == n.name ? [e.name, "{searchTerms}"].join("=") : [e.name, e.value].map(encodeURIComponent).join("=")
            }),
            a = e.getElementsByTagName("select"),
            r = (a = Array.prototype.slice.call(a, 0)).map(function(e) {
                return [e.name, e.options[e.selectedIndex].value].map(encodeURIComponent).join("=")
            });
        if (o = o.concat(r), !e.action)
            return null;
        var i = e.acceptCharset;
        return i && 0 != i.length || (i = document.characterSet), [e.action, o.join("&")].join("?") + "|:|:|" + i
    }
}();
