!function() {
    "use strict";
    window.__firefox__ || (window.__firefox__ = {}),
    window.__firefox__.favicon = {};
    var r = ["link[rel='apple-touch-icon-precomposed'][sizes='171x171']", "link[rel='apple-touch-icon'][sizes='120x120']", "link[rel='apple-touch-icon-precomposed'][sizes='114x114']", "link[rel='apple-touch-icon'][sizes='114x114']", "link[rel='apple-touch-icon-precomposed']", "link[rel='apple-touch-icon']", "link[rel~='icon']"];
    function i(e) {
        for (var n = 0; n < r.length; n++) {
            var o = r[n],
                i = document.head.querySelector(o);
            if (i && i.href)
                return e || n != r.length - 1 || -1 == i.href.indexOf(".ico") ? i.href : null
        }
        return null
    }
    function e() {
        var e = i(!1),
            n = window.location.href,
            o = null == e ? n + ":#:" : n + ":#:" + e;
        webkit.messageHandlers.faviconMessageHandler.postMessage(o)
    }
    window.__firefox__.favicon.getFavicon = e,
    window.__firefox__.favicon.getSearchEngine = function() {
        return i(!0)
    },
    document.addEventListener("DOMContentLoaded", function() {
        e()
    })
}();
