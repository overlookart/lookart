!function() {
    "use strict";
    var l,
        a,
        t = !1,
        c = 5,
        o = 400,
        r = 60,
        d = null,
        f = 0,
        s = [];
    function u(e) {
        t && console.log("FindInPage: " + e)
    }
    function n(e) {
        var t = e.parentNode;
        if (t) {
            for (; e.firstChild;)
                t.insertBefore(e.firstChild, e);
            e.remove(),
            t.normalize()
        }
    }
    function g() {
        if (0 < s.length) {
            for (var e = 0; e < s.length; e++)
                n(s[e]);
            s = []
        }
        d = null
    }
    function m(e) {
        if (u("Searching: " + e), g(), e.trim()) {
            var t = document.createRange(),
                n = function(e) {
                    for (var t, n, o, r, i, l, d, a, c = e.toLocaleLowerCase(), f = e.toLocaleUpperCase(), s = [], u = document.createRange(), g = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT, null, !1), m = e.length; t = g.nextNode();) {
                        var h = t.textContent;
                        e:
                        for (var v = 0; v < h.length - m + 1; ++v) {
                            for (var _ = 0; _ < m; ++_) {
                                var w = h[v + _];
                                if (c[_] !== w && f[_] !== w)
                                    continue e
                            }
                            var p = t.parentNode;
                            u.setStart(t, v),
                            u.setEnd(t, v + m);
                            var b = u.getBoundingClientRect();
                            "hidden" !== getComputedStyle(p).visibility && (n = b, void 0, o = document.documentElement.scrollLeft || document.body.scrollLeft, r = document.documentElement.scrollTop || document.body.scrollTop, i = n.left + o, l = n.right + o, d = n.top + r, a = n.bottom + r, 0 < n.width && 0 < n.height && 0 <= l && 0 <= a && i <= document.documentElement.scrollWidth && d <= document.documentElement.scrollHeight) && (s.push({
                                node: t,
                                index: v
                            }), v += m - 1)
                        }
                    }
                    return s
                }(e),
                o = document.createElement("span");
            o.setAttribute("style", "background-color: #ffde49 !important");
            for (var r = n.length - 1; 0 <= r; --r) {
                var i = n[r],
                    l = o.cloneNode();
                t.setStart(i.node, i.index),
                t.setEnd(i.node, i.index + e.length),
                t.surroundContents(l),
                s.unshift(l)
            }
            u(n.length + " highlighted rects created!"),
            webkit.messageHandlers.findInPageHandler.postMessage({
                totalResults: n.length
            })
        } else
            webkit.messageHandlers.findInPageHandler.postMessage({
                totalResults: 0
            })
    }
    function h() {
        if (d && d.setAttribute("style", "background-color: #ffde49 !important"), s.length) {
            (d = s[f]).setAttribute("style", "background-color: #f19750 !important");
            var e = d.getBoundingClientRect(),
                t = r + e.top + scrollY - window.innerHeight / 2,
                n = e.left + scrollX - window.innerWidth / 2;
            (function(n, o, r) {
                var i = 0,
                    l = scrollX,
                    d = scrollY;
                clearInterval(a),
                a = setInterval(function() {
                    var e = v(i, l, n - l, r),
                        t = v(i, d, o - d, r);
                    window.scrollTo(e, t),
                    r <= (i += c) && clearInterval(a)
                }, c)
            })(n = i(n, 0, document.body.scrollWidth), t = i(t, 0, document.body.scrollHeight), o),
            u("Scrolled to: " + n + ", " + t)
        }
    }
    function v(e, t, n, o) {
        return n * (Math.pow(e / o - 1, 3) + 1) + t
    }
    function i(e, t, n) {
        return Math.max(t, Math.min(e, n))
    }
    function _(e) {
        if (l == e) {
            var t = s.length;
            f = (f + t) % t
        } else {
            var n = null;
            if (d && (n = d.getBoundingClientRect()), m(e), f = 0, n)
                for (var o = 0; o < s.length; o++) {
                    var r = s[o].getBoundingClientRect();
                    if (r.top == n.top && r.left >= n.left || r.top > n.top) {
                        f = o;
                        break
                    }
                }
            l = e
        }
        var i = s.length ? f + 1 : 0;
        webkit.messageHandlers.findInPageHandler.postMessage({
            currentResult: i
        }),
        h()
    }
    window.__firefox__ || (window.__firefox__ = {}),
    window.__firefox__.find = function(e) {
        _(e)
    },
    window.__firefox__.findNext = function(e) {
        f++,
        _(e)
    },
    window.__firefox__.findPrevious = function(e) {
        f--,
        _(e)
    },
    window.__firefox__.findDone = function() {
        g(),
        l = null
    }
}();
