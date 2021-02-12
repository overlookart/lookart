!function() {
    "use strict";
    var i = !1;
    function n() {
        try {
            return window.self === window.top
        } catch (e) {
            return !1
        }
    }
    window.__firefox__ || (window.__firefox__ = {}),
    n() ? (window.__firefox__.setMainFrameNoImageEnable = t, window.__firefox__.sendNoImageEnableToFrames = m) : window.addEventListener("message", function(e) {
        "string" == typeof e.data && -1 != e.data.indexOf("setNoImageEnable") && t(!0)
    });
    var r = "__firefox__NoImageMode",
        s = null;
    function t(e) {
        if (i != e)
            if (i = e) {
                m(),
                function() {
                    var e = '*{background-image:none !important;}img,input[type="image"]{visibility:hidden !important;}',
                        t = document.getElementById(r);
                    if (t)
                        t.innerHTML = e;
                    else {
                        var n = document.createElement("style");
                        n.type = "text/css",
                        n.id = r,
                        n.appendChild(document.createTextNode(e)),
                        document.documentElement.appendChild(n)
                    }
                }();
                for (var t = document.getElementsByTagName("img"); 0 < t.length;)
                    t[0].src = "",
                    t[0].remove();
                for (var n = document.getElementsByTagName("input"), d = new Array, o = 0; o < n.length; o++)
                    "image" === n[o].getAttribute("type") && (n[o].src = "", d.push(n[o]));
                d.forEach(function(e) {
                    e.parentNode && e.parentNode.removeChild(e)
                }),
                d = [],
                (s = new MutationObserver(function(e) {
                    e.forEach(function(e) {
                        for (var t = 0; t < e.addedNodes.length; ++t)
                            e.addedNodes[t] instanceof HTMLImageElement && (e.addedNodes[t].src = "", e.addedNodes[t].remove()),
                            e.addedNodes[t] instanceof HTMLInputElement && "image" == e.addedNodes[t].getAttribute("type") && (e.addedNodes[t].src = "", e.addedNodes[t].remove())
                    })
                })).observe(document, {
                    childList: !0,
                    subtree: !0
                })
            } else {
                var a = document.getElementById(r);
                a && a.remove(),
                s.disconnect(),
                s = null
            }
    }
    function m() {
        if (i && n())
            for (var e = window.frames, t = 0; t < e.length; t++)
                e[t].postMessage('{"setNoImageEnable":1}', "*")
    }
}();
