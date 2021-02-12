!function() {
    var t = {
        title: "head title",
        description: "head meta[name='description'], body p"
    };
    function o(e, t) {
        var n = e.querySelector(t);
        if (n)
            return n.getAttribute("content") || n.innerText
    }
    function e() {
        var e = function(e, t) {
            var n = {};
            for (var i in t)
                n[i] = o(e, t[i]) || "";
            return n
        }(document, t);
        webkit.messageHandlers.spotlightMessageHandler.postMessage(e)
    }
    window.__firefox__ || (window.__firefox__ = {}),
    window.addEventListener("load", e),
    window.__firefox__.spotlightStopLoading = e
}();
