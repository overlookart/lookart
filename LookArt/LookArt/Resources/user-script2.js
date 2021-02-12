!function() {
    "use strict";
    window.__firefox__ || (window.__firefox__ = {});
    var t = location.host,
        n = location.pathname;
    function r() {
        try {
            return window.self === window.top
        } catch (e) {
            return !1
        }
    }
    window.ApplePaySession || (window.ApplePaySession = function() {}, window.ApplePaySession.canMakePayments = function() {
        return !1
    }, window.ApplePaySession.canMakePaymentsWithActiveCard = function() {
        return !1
    }),
    Element.prototype.requestFullscreen = function() {
        if (this instanceof HTMLVideoElement)
            return this.webkitEnterFullScreen();
        var e = this.getElementsByTagName("video");
        return 0 < e.length ? e[0].webkitEnterFullScreen() : void 0
    };
    var a = "m.baidu.com" == t || "www.baidu.com" == t,
        d = "tieba.baidu.com" != t && !a,
        l = null,
        s = null,
        c = !1,
        u = null,
        m = null,
        f = !1,
        e = "0";
    try {
        e = window.prompt("_NoAddListener_")
    } catch (e) {}
    function g() {
        webkit.messageHandlers.contextMenuMessageHandler.postMessage({
            action: "baiduCloseBanner"
        })
    }
    function h() {
        return document.documentElement.scrollTop || document.body.scrollTop
    }
    function v() {
        return document.documentElement.scrollLeft || document.body.scrollLeft
    }
    function p(e, t, n) {
        return e.split(t).join(n)
    }
    function w(e) {
        if (!e)
            return !1;
        for (var t = e.toLowerCase(), n = 0; n < j.length; n++) {
            var o = j[n];
            if (-1 != t.indexOf(o))
                return !0
        }
        return !1
    }
    function _(e) {
        return !(!j || 0 == j.length) && (!!e.getAttribute("data-reactid") || !!w(e.tagName + "" + e.id + e.className))
    }
    function y(e, t, n) {
        var o = e.getBoundingClientRect();
        if (!(o.height < n || o.width < t)) {
            var i = getComputedStyle(e);
            if ("visible" === i.visibility && "none" !== i.display) {
                if (!(i.zIndex > z)) {
                    var a = !0;
                    if (o.width >= document.documentElement.clientWidth && o.height >= document.documentElement.clientHeight) {
                        var r = e.getAttribute("onclick");
                        r && -1 != r.indexOf("display") && -1 != r.indexOf("none") && (a = !1)
                    }
                    if (a)
                        return
                }
                var d = !0;
                if (Fe(e))
                    if (d = !_(e)) {
                        var l = e.getElementsByTagName("*");
                        if (l.length > F && (d = !1), d)
                            for (var s = 0; s < l.length; s++) {
                                if (_(l[s])) {
                                    d = !1;
                                    break
                                }
                            }
                    }
                d && Je(e)
            }
        }
    }
    function i(e, i) {
        e.selectorText.split(",").forEach(function(e) {
            for (var t = document.querySelectorAll(e), n = 0; n < t.length; n++) {
                var o = t[n];
                i ? y(o, V, V) : y(o, document.documentElement.clientWidth, document.documentElement.clientHeight)
            }
        })
    }
    "1" == e && (window.__firefox__._addEventListener || (window.__firefox__._addEventListener = Element.prototype.addEventListener, Element.prototype.addEventListener = function() {
        if (1 < arguments.length) {
            var e = arguments[0],
                t = arguments[1];
            if (("click" === e || "touchend" === e && t !== Ae) && (this.takeHaveClickEvent = !0), "touchmove" === e && t !== Ie && (this.alookHaveMoveEvent = !0), a && "click" === e && null != m && t !== g) {
                var n = !1;
                if (-1 != this.className.indexOf(m) && (n = !0), !n) {
                    var o = this.getAttribute("style");
                    o && -1 != o.indexOf(m) && (n = !0)
                }
                if (n) {
                    var i = this;
                    setTimeout(function() {
                        f ? i.click() : i.addEventListener("click", g)
                    }, 0)
                }
            }
        }
        return window.__firefox__._addEventListener.apply(this, arguments)
    })),
    Element.prototype.takeImgSrc = function() {
        var e = this.src;
        if (e && 0 == e.indexOf("http"))
            return e;
        var t = this.takeBgImgSrc();
        if (t)
            return t;
        if (!(this instanceof HTMLImageElement))
            return null;
        if ((e = this.getAttribute("data-src")) && 0 == e.indexOf("http"))
            return e;
        for (var n = this.attributes, o = 0; o < n.length; o++)
            if ((e = n[o].nodeValue) && 0 == e.indexOf("http"))
                return e;
        return this.src
    },
    Element.prototype.takeBgImgSrc = function() {
        var e = this.style.backgroundImage;
        return e && 0 < e.indexOf("http") ? e.slice(4, -1).replace(/"/g, "") : null
    };
    var o = {
            main: 1,
            a: 1,
            abbr: 1,
            acronym: 1,
            address: 1,
            applet: 1,
            area: 1,
            article: 1,
            aside: 1,
            audio: 1,
            b: 1,
            base: 1,
            basefont: 1,
            bdi: 1,
            bdo: 1,
            big: 1,
            blockquote: 1,
            body: 1,
            br: 1,
            button: 1,
            canvas: 1,
            caption: 1,
            center: 1,
            cite: 1,
            code: 1,
            col: 1,
            colgroup: 1,
            command: 1,
            datalist: 1,
            dd: 1,
            del: 1,
            details: 1,
            dir: 1,
            div: 1,
            dfn: 1,
            dialog: 1,
            dl: 1,
            dt: 1,
            em: 1,
            embed: 1,
            fieldset: 1,
            figcaption: 1,
            figure: 1,
            font: 1,
            footer: 1,
            form: 1,
            frame: 1,
            frameset: 1,
            h1: 1,
            h2: 1,
            h3: 1,
            h4: 1,
            h5: 1,
            h6: 1,
            head: 1,
            header: 1,
            hr: 1,
            html: 1,
            i: 1,
            iframe: 1,
            img: 1,
            input: 1,
            ins: 1,
            isindex: 1,
            kbd: 1,
            keygen: 1,
            label: 1,
            legend: 1,
            li: 1,
            link: 1,
            map: 1,
            mark: 1,
            menu: 1,
            menuitem: 1,
            meta: 1,
            meter: 1,
            nav: 1,
            noframes: 1,
            noscript: 1,
            object: 1,
            ol: 1,
            optgroup: 1,
            option: 1,
            output: 1,
            p: 1,
            param: 1,
            pre: 1,
            progress: 1,
            q: 1,
            rp: 1,
            rt: 1,
            ruby: 1,
            s: 1,
            samp: 1,
            script: 1,
            section: 1,
            select: 1,
            small: 1,
            source: 1,
            span: 1,
            strike: 1,
            strong: 1,
            style: 1,
            sub: 1,
            summary: 1,
            sup: 1,
            table: 1,
            tbody: 1,
            td: 1,
            textarea: 1,
            tfoot: 1,
            th: 1,
            thead: 1,
            time: 1,
            title: 1,
            tr: 1,
            track: 1,
            tt: 1,
            u: 1,
            ul: 1,
            var: 1,
            video: 1,
            wbr: 1,
            xmp: 1,
            svg: 1
        },
        E = "AlookElementHide",
        x = null,
        b = 10,
        k = "#|#",
        N = null,
        M = window.setTimeout,
        H = 0,
        T = 0,
        C = 0,
        L = null,
        S = !1,
        I = null,
        O = null,
        A = null,
        B = null,
        P = null,
        R = !1,
        D = !1,
        V = 70,
        z = 0,
        F = 20,
        j = null,
        X = null,
        q = -1,
        Y = !1,
        W = !0,
        U = 100,
        J = 0,
        Z = null,
        K = 0,
        G = !0,
        Q = 1,
        $ = null,
        ee = HTMLVideoElement.prototype.play;
    HTMLVideoElement.prototype.play = function() {
        return ye(this), ee.apply(this, arguments)
    };
    var te = HTMLVideoElement.prototype.load;
    HTMLVideoElement.prototype.load = function() {
        return ye(this), te.apply(this, arguments)
    };
    var ne = HTMLAudioElement.prototype.play;
    HTMLAudioElement.prototype.play = function() {
        return ye(this), ne.apply(this, arguments)
    };
    var oe = HTMLAudioElement.prototype.load;
    HTMLAudioElement.prototype.load = function() {
        return ye(this), oe.apply(this, arguments)
    };
    var ie = 260,
        ae = 180;
    -1 != t.indexOf(".google.") && (ie = 200);
    var re = -1 != t.indexOf("youtube.com");
    function de(e) {
        var t = e.target;
        t && (t.takeMarkLoaded = !0)
    }
    function le(e, t) {
        for (var n = new Array, o = 0; o < e.length; o++)
            n.push(e[o]);
        for (o = 0; o < t.length; o++)
            n.push(t[o]);
        return n
    }
    function se(e) {
        if (e && e.getElementsByTagName)
            for (var t = le(t = e.getElementsByTagName("img"), e.getElementsByTagName("input")), n = 0; n < t.length; n++)
                t[n].addEventListener("load", de)
    }
    function ce(e) {
        e.referrer = location.href;
        var t = document.querySelector("meta[name='referrer']");
        t && t.content && ("no-referrer" != t.content && "never" != t.content || (e.referrer = "")),
        e.title = document.title,
        e.ua = navigator.userAgent
    }
    function ue() {
        if (r())
            for (var e = window.frames, t = 0; t < e.length; t++)
                e[t].postMessage('{"sendVideoPlayRate":' + Q + "}", "*")
    }
    function me() {
        if (r())
            for (var e = window.frames, t = 0; t < e.length; t++)
                e[t].postMessage('{"sendClipboardEnable":' + G + "}", "*")
    }
    function fe() {
        if (r())
            for (var e = window.frames, t = 0; t < e.length; t++)
                e[t].postMessage('{"sendFontSize":"' + Z + '"}', "*")
    }
    function ge() {
        ue(),
        me(),
        fe()
    }
    function pe() {
        Z && document.documentElement && (document.documentElement.style.webkitTextSizeAdjust = Z, document.body && (document.body.style.webkitTextSizeAdjust = Z))
    }
    function he() {
        var e = document.body ? document.body : document.documentElement;
        if (e && "none" == getComputedStyle(e).webkitUserSelect) {
            e.style.webkitUserSelect = "auto";
            var t = document.createElement("style");
            t.innerText = "*{-webkit-user-select:auto !important;}",
            document.head.appendChild(t)
        }
    }
    function ve(e) {
        var t = e.target;
        t && "takeHighlightCoverX" !== t.id && (t.parentNode && "takeHighlightCoverX" === t.parentNode.id || (r() && (ze(t) && t.addEventListener("load", de), se(t)), He(), _e(e.relatedNode), we()))
    }
    function we() {
        if (a && null != s && 0 != s.length) {
            var e = document.querySelector(s);
            if (null == e || e.hasClick || (e.hasClick = !0, setTimeout(function() {
                c ? (e.click(), webkit.messageHandlers.contextMenuMessageHandler.postMessage({
                    action: "autoClickShowMore"
                }), setTimeout(function() {
                    u && u.parentNode && u.parentNode.removeChild(u),
                    window.__firefox__.checkHaveNextPage()
                }, 0)) : e.addEventListener("click", function() {
                    webkit.messageHandlers.contextMenuMessageHandler.postMessage({
                        action: "baiduShowMore"
                    })
                })
            }, 200)), c && null != l && 0 < l.length) {
                var t = document.querySelector(l);
                null == t || t.hasClick || (t.hasClick = !0, u && !u.parentNode && document.documentElement.appendChild(u), setTimeout(function() {
                    t.click(),
                    setTimeout(function() {
                        we()
                    }, 300)
                }, 200)),
                null == t && u && u.parentNode && u.parentNode.removeChild(u)
            }
        }
    }
    function _e(e) {
        if (e && e.getElementsByTagName)
            for (var t = le(e.getElementsByTagName("audio"), e.getElementsByTagName("video")), n = 0; n < t.length; n++)
                ye(t[n])
    }
    function ye(e) {
        e && (0 < e.duration && e.duration != 1 / 0 || -1 != e.currentSrc.indexOf("pan.baidu.com") ? e.playbackRate = Q : e.playbackRate = 1, e.isVideoPlayListened || (e.addEventListener("play", xe, !1), e.addEventListener("load", Ee, !1), e.addEventListener("playing", Ee, !1), e.addEventListener("durationchange", Ee, !1), e.isVideoPlayListened = !0))
    }
    function Ee(e) {
        ye(e.target)
    }
    function xe(e) {
        $ = e.target,
        ye(e.target),
        window.__firefox__.sendVideoNode(e.target)
    }
    function be(e) {
        e && e.parentNode && e.parentNode.removeChild(e)
    }
    function ke() {
        if (-1 != location.host.indexOf("4chan.org") || -1 != location.host.indexOf("4channel.org"))
            for (var e = document.querySelectorAll("a[target='_blank']"), t = 0; t < e.length; t++)
                e[t].removeAttribute("target");
        if (D) {
            if (-1 != location.host.indexOf("91porn.com") || -1 != document.title.indexOf("91自拍论坛")) {
                var n = document.getElementsByTagName("iframe");
                for (t = 0; t < n.length; t++)
                    be(n[t])
            }
            if (-1 != document.title.indexOf("第一会所") && be(document.getElementById("ad_text")), 0 < document.getElementsByClassName("maomi-content").length) {
                var o = document.getElementById(E);
                if (!o)
                    return;
                o.innerText = "#photo-content-title-text-main,.default_dialog,#photo-header-title-content-text-dallor,.section-banner,.footer-fix,.top-ad-container,.close_discor,.photo--content-title-bottomx--foot," + o.innerText
            }
        }
    }
    if (r() ? window.__firefox__.sendConfigToFrames = ge : window.addEventListener("message", function(e) {
        if ("string" == typeof e.data && -1 != e.data.indexOf("sendImageToClient")) {
            var t = 1 == JSON.parse(e.data).sendImageToClient,
                n = Pe(t ? ie : 20, !0, !t),
                o = {};
            o.frameImages = n,
            ce(o),
            webkit.messageHandlers.contextMenuMessageHandler.postMessage(o)
        } else if ("string" == typeof e.data && -1 != e.data.indexOf("sendVideoPlayRate")) {
            var i = JSON.parse(e.data).sendVideoPlayRate;
            i && 0 < i && i < 3 && (Q = i, ye($), _e(document))
        } else if ("string" == typeof e.data && -1 != e.data.indexOf("sendClipboardEnable")) {
            var a = JSON.parse(e.data).sendClipboardEnable;
            null != a && (G = a)
        } else if ("string" == typeof e.data && -1 != e.data.indexOf("sendFontSize")) {
            var r = JSON.parse(e.data).sendFontSize;
            r && (Z = r, pe())
        }
    }), document.addEventListener("DOMContentLoaded", function() {
        r() ? (Ue(q), webkit.messageHandlers.contextMenuMessageHandler.postMessage({
            action: "DOMContentLoaded"
        }), se(document), ge(), setTimeout(ke, 0)) : webkit.messageHandlers.contextMenuMessageHandler.postMessage({
            action: "iFrameDOMContentLoaded"
        }),
        pe(),
        he(),
        He(),
        _e(document),
        we(),
        document.addEventListener("DOMNodeInserted", ve)
    }), window.print = function() {
        webkit.messageHandlers.contextMenuMessageHandler.postMessage({
            action: "print"
        })
    }, document && document.execCommand) {
        var Ne = document.execCommand;
        document.execCommand = function(e, t, n) {
            if ("copy" == e.toLowerCase()) {
                if (!G)
                    return !1;
                var o = getSelection().toString();
                if (o && 0 < o.length) {
                    var i = {
                        action: "copy",
                        section: o
                    };
                    webkit.messageHandlers.contextMenuMessageHandler.postMessage(i)
                }
            }
            return Ne.apply(document, arguments)
        }
    }
    function Me() {
        if (He(), he(), "/" != n) {
            var e = Pe(ie, !1, !1);
            8 < e.length && webkit.messageHandlers.contextMenuMessageHandler.postMessage({
                bigImageCount: e.length
            })
        }
        window.setTimeout(function() {
            D = !1
        }, 500)
    }
    function He() {
        var e = location.host;
        if (D) {
            var t = !0;
            if (X && 0 < X.length)
                for (var n = 0; n < X.length; n++)
                    if (-1 != e.indexOf(X[n])) {
                        t = !1;
                        break
                    }
            t && function() {
                for (var e = document.querySelectorAll("[style*=fixed],[style*=z-index]"), t = 0; t < e.length; t++)
                    (n = e[t]).style && (0 == n.style.position.indexOf("fixed") ? y(n, V, V) : n.style.zIndex > z && y(n, document.documentElement.clientWidth, document.documentElement.clientHeight));
                var n;
                var o = function() {
                    for (var e = new Array, t = new Array, n = document.styleSheets, o = 0, i = n.length; o < i; o++) {
                        var a = n[o];
                        if (a.cssRules)
                            for (var r = 0, d = a.cssRules.length; r < d; r++) {
                                var l = a.cssRules[r];
                                if (l.style && l.selectorText) {
                                    0 == l.style.position.indexOf("fixed") && (w(l.selectorText) || e.push(l));
                                    var s = l.style["z-index"];
                                    (s = s && parseInt(s)) && z < s && t.push(l)
                                }
                            }
                    }
                    return {
                        fixed: e,
                        zIndex: t
                    }
                }();
                o.fixed.forEach(function(e) {
                    i(e, !0)
                }),
                o.zIndex.forEach(function(e) {
                    i(e, !1)
                })
            }()
        }
        P && P.forEach(function(e) {
            var t = Ye(e);
            t && "takeHighlightCoverX" !== t.id && Je(t)
        })
    }
    function Te() {
        N && (clearTimeout(N), N = null, L && (document.body.removeChild(L), L = null))
    }
    function Ce() {
        Te(),
        A && (document.body.removeChild(A), A = null),
        B && (clearInterval(B), B = null)
    }
    function Le(e) {
        if ("HTML" == e.tagName)
            return "/HTML[1]";
        if (e === document.body)
            return "/HTML[1]/BODY[1]";
        for (var t = 0, n = e.parentNode.childNodes, o = 0; o < n.length; o++) {
            var i = n[o];
            if (i === e)
                return Le(e.parentNode) + "/" + e.tagName + "[" + (t + 1) + "]";
            1 === i.nodeType && i.tagName === e.tagName && t++
        }
    }
    function Se(e, t) {
        var n = document.createElement("div");
        n.style.pointerEvents = "none",
        n.style.top = "0px",
        n.style.left = "0px",
        n.style.position = "absolute",
        window.__firefox__.isNightMode ? n.style.opacity = "0.6" : n.style.opacity = "0.3";
        var o = n.getAttribute("style");
        n.setAttribute("style", o + "z-index:2147483647 !important"),
        n.id = "takeHighlightCoverX",
        document.body.appendChild(n);
        for (var i = new Array, a = e.getClientRects(), r = 0; r != a.length; r++)
            i.push(a[r]);
        if (t) {
            var d = e.children;
            for (r = 0; r < d.length; r++)
                for (var l = d[r].getClientRects(), s = 0; s != l.length; s++)
                    i.push(l[s])
        }
        for (r = 0; r != i.length; r++) {
            var c = i[r],
                u = document.createElement("div"),
                m = h(),
                f = v(),
                g = c.top + m - 2.5,
                p = c.left + f - 2.5;
            u.style.top = g + "px",
            u.style.left = p + "px",
            u.style.width = c.width + 5 + "px",
            u.style.height = c.height + 5 + "px",
            u.style.position = "absolute",
            u.style.backgroundColor = "#0076ff",
            u.style.borderRadius = "2px",
            u.style.padding = "2.5px",
            u.style.pointerEvents = "none",
            n.appendChild(u)
        }
        return n
    }
    function Ie(e) {
        if (W = !1, N) {
            var t = e.touches[0].screenX,
                n = e.touches[0].screenY;
            (Math.abs(H - t) > b || Math.abs(T - n) > b) && Ce()
        }
    }
    function Oe(e) {
        R ? (removeEventListener("touchend", Ae), removeEventListener("touchcancel", Oe), e.preventDefault()) : Ae(e)
    }
    function Ae(e) {
        if (R)
            return removeEventListener("touchend", Ae), removeEventListener("touchcancel", Oe), void e.preventDefault();
        Ce(),
        removeEventListener("touchcancel", Oe),
        removeEventListener("touchend", Ae),
        removeEventListener("touchmove", Ie),
        Y && W && (W = !1, window.__firefox__.scrollDidEnd && setTimeout(function() {
            !function(e) {
                e < window.innerHeight / 2 ? Ge() : Ke()
            }(J)
        }, 0)),
        S && (S = !1, e.preventDefault())
    }
    function Be(e) {
        if (!e || !e.tagName)
            return !1;
        var t = e.tagName;
        return "FORM" == t || "INPUT" == t || "VIDEO" == t || (0 < e.getElementsByTagName("form").length || 0 < e.getElementsByTagName("input").length)
    }
    function Pe(e, t, n) {
        var o = le(document.getElementsByTagName("img"), document.getElementsByTagName("input"));
        t && (o = le(o, document.querySelectorAll("[style*='background-image']")));
        for (var d = new Array, i = new Array, l = new Array, a = 0; a < o.length; a++) {
            var r = o[a];
            if (ze(r)) {
                var s = r.takeImgSrc();
                Ve(r, e, n, s) ? (l.push(r), d.push(s)) : r.takeMarkLoaded || i.push(r)
            }
        }
        0 < l.length && i.forEach(function(e) {
            var t = document.createElement("a"),
                n = e.takeImgSrc();
            t.href = n;
            for (var o = t.host, i = 0; i < l.length; i++) {
                var a = l[i];
                if (a.parentNode === e.parentNode || a.parentNode && e.parentNode && a.parentNode.parentNode === e.parentNode.parentNode) {
                    var r = a.takeImgSrc();
                    if (t.href = r, t.host == o) {
                        d.push(n);
                        break
                    }
                }
            }
        });
        var c = new Array;
        for (a = 0; a < d.length; a++) {
            var u = d[a];
            0 != u.length && -1 == u.indexOf("/ad/") && -1 == u.indexOf("/ads/") && -1 == u.indexOf("_ads") && -1 == u.indexOf("ads_") && -1 == u.indexOf("-ad-") && -1 == c.indexOf(u) && c.push(u)
        }
        return c
    }
    function Re(e) {
        var t = Pe(e ? ie : 20, !0, !e),
            n = {};
        if (n.bigImages = t, ce(n), r()) {
            var o = window.frames;
            if (0 < o.length) {
                n.waitForFrame = !0;
                for (var i = 0; i < o.length; i++)
                    o[i].postMessage('{"sendImageToClient":' + (e ? 1 : 0) + "}", "*")
            }
        }
        return n
    }
    function De(e, t, n) {
        return !(!e || !t) && (n < e && n < t || (1.3 * n < e && n / 2 < t || 1.3 * n < t && n / 2 < e))
    }
    function Ve(e, t, n, o) {
        if (o && "gif" == o.split("?")[0].split(".").pop().toLowerCase() && (t = ae < t ? ae : t), n && De(e.naturalWidth, e.naturalHeight, t))
            return !0;
        if (De(e.clientWidth, e.clientHeight, t))
            return !0;
        var i = e.getBoundingClientRect();
        return !!De(i.width, i.height, t)
    }
    function ze(e) {
        return !!e && (!(!e.takeBgImgSrc || !e.takeBgImgSrc()) || (e instanceof HTMLImageElement || e instanceof HTMLInputElement) && (!(e instanceof HTMLInputElement && "image" !== e.getAttribute("type")) && !(!e.takeImgSrc || !e.takeImgSrc())))
    }
    function Fe(e) {
        return -1 != t.indexOf("forbes.com") || !!e.tagName && o[e.tagName.toLowerCase()]
    }
    function je(e) {
        for (var t = e; t && t.parentNode && "html" != t.parentNode.tagName.toLowerCase();) {
            if (!Fe(t.parentNode))
                return !1;
            t = t.parentNode
        }
        return !0
    }
    function Xe() {
        var e = "";
        if (Fe(O)) {
            if (e = Le(O), O.previousElementSibling && Fe(O.previousElementSibling) && (e += k, e += Le(O.previousElementSibling) + "/following-sibling::*[1]"), O.nextElementSibling && Fe(O.nextElementSibling) && (e += k, e += Le(O.nextElementSibling) + "/preceding-sibling::*[1]"), O.parentNode)
                for (var t = O.parentNode.children, n = 0; n < t.length; n++)
                    if (t[n] === O) {
                        e += k,
                        e += Le(O.parentNode) + "/child::*[" + (n + 1) + "]";
                        break
                    }
        } else
            e = O.previousElementSibling && Fe(O.previousElementSibling) ? Le(O.previousElementSibling) + "/following-sibling::*[1]" : !O.previousElementSibling && O.parentNode ? Le(O.parentNode) + "/child::*[1]" : Le(O);
        return Ye(e) !== O ? "" : (Ce(), A = Se(O, !0), B = setInterval(function() {
            A && document.body.appendChild(A)
        }, 30), e)
    }
    function qe(e, t) {
        return -1 !== e.indexOf(t, e.length - t.length)
    }
    function Ye(e) {
        var t = e.split(k);
        if (0 == t.length)
            return null;
        var n = document.evaluate(t[0], document.documentElement, null, XPathResult.ANY_TYPE, null).iterateNext();
        if (n && (qe(t[0], "following-sibling::*[1]") || qe(t[0], "child::*[1]")) && Fe(n))
            return null;
        for (var o = 1; o < t.length; o++) {
            if (document.evaluate(t[o], document.documentElement, null, XPathResult.ANY_TYPE, null).iterateNext() !== n)
                return null
        }
        return n
    }
    function We(e) {
        e.target && e.target.id == E && (window.setTimeout(function() {
            document.head.appendChild(x)
        }, 1), document.head.removeEventListener("DOMNodeRemoved", We))
    }
    function Ue(e) {
        if (-1 != e && document.head && !document.getElementById(E)) {
            var t = document.createElement("style");
            t.id = E;
            var n = ".";
            e && 0 < e.length && (n = e + ",."),
            n = n + E + "{display:none !important;height: 0px !important;line-height: 0px !important;}",
            t.innerText = n,
            x = t,
            document.head.appendChild(t),
            document.head.addEventListener("DOMNodeRemoved", We),
            document.head.addEventListener("DOMNodeInserted", function(e) {
                e.target && e.target.tagName && "style" == e.target.tagName.toLowerCase() && e.target.id != E && (document.head.removeEventListener("DOMNodeRemoved", We), x.parentNode == document.head && document.head.removeChild(x), document.head.addEventListener("DOMNodeRemoved", We), document.head.appendChild(x))
            })
        }
    }
    function Je(e) {
        if (e) {
            var t = e.getAttribute("style");
            -1 == (t = t || "").indexOf("display:none !important;height: 0px !important;line-height: 0px !important;") && e.setAttribute("style", t + "display:none !important;height: 0px !important;line-height: 0px !important;"),
            e.classList.contains(E) || e.classList.add(E)
        }
    }
    function Ze() {
        if (Ce(), !O)
            return "";
        for (; !je(O) && O.parentNode;)
            O = O.parentNode;
        return Xe()
    }
    function Ke() {
        var e = (768 == window.innerHeight ? 56 : 22) + K;
        window.scrollTo(v(), h() + window.innerHeight * U / 100 - e)
    }
    function Ge() {
        var e = (768 == window.innerHeight ? 56 : 22) + K;
        window.scrollTo(v(), h() - window.innerHeight * U / 100 + e)
    }
    r() && (window.__firefox__.contextStopLoading = Me),
    window.addEventListener("load", Me),
    addEventListener("touchstart", function(e) {
        if (R)
            return (t = e.target).addEventListener("touchend", Ae), void t.addEventListener("touchcancel", Oe);
        if (1 === e.touches.length) {
            J = e.touches[0].clientY,
            W = !0;
            var t,
                i = {};
            !function(e) {
                re && e && window.__firefox__.setVideoClick && 0 < e.getElementsByTagName("video").length && window.__firefox__.setVideoClick()
            }(t = e.target),
            (O = t).addEventListener("touchcancel", Oe),
            t.addEventListener("touchend", Ae),
            t.addEventListener("touchmove", Ie);
            do {
                if (t === document.body || t === document.documentElement)
                    break;
                if (d && (t.ontouchmove || t.alookHaveMoveEvent) && webkit.messageHandlers.contextMenuMessageHandler.postMessage({
                    action: "touchmove"
                }), !i.link && "a" === t.localName && (i.link = t.href, i.textContent = t.textContent, O = t, window.__firefox__.ios13)) {
                    var n = t;
                    setTimeout(function() {
                        N && (L = Se(n, !1))
                    }, 100)
                }
                if ((!i.image || i.isBackgroudImage) && t instanceof HTMLImageElement && (i.image = t.takeImgSrc(), i.isBackgroudImage = !1, i.imageElement = t, O = t), (!i.image || i.isBackgroudImage) && t instanceof HTMLInputElement && t.src) {
                    var o = t.getAttribute("type");
                    o && "image" == o && (i.isBackgroudImage = !1, i.image = t.src, i.imageElement = t, O = t)
                }
                !i.image && t.style.backgroundImage && t.takeBgImgSrc() && (Be(t) || (i.isBackgroudImage = !0, i.image = t.takeBgImgSrc(), i.imageElement = t)),
                i.onclick && !i.justClickEvent || !t.onclick && !t.takeHaveClickEvent || Be(t) || (i.onclick = "1", !t.onclick && t.takeHaveClickEvent ? i.justClickEvent = !0 : (i.justClickEvent = !1, O = O || t)),
                Y && W && (t.takeHaveClickEvent && (W = !1), !W || "form" !== t.localName && "input" !== t.localName && "video" !== t.localName && "audio" !== t.localName || (W = !1)),
                t = t.parentElement
            } while (t);
            if (Y && W && window.setTimeout(function() {
                W = !1
            }, 500), i.link || i.image && !i.isBackgroudImage || i.onclick && !i.justClickEvent) {
                var a = e.touches[0];
                W = !1,
                H = a.screenX,
                T = a.screenY,
                C = h(),
                r() || (i.x = H, i.y = T),
                N = M(function() {
                    if (S = !0, Ce(), !i.image && O) {
                        for (var e = O.getElementsByTagName("*"), t = 0; t < e.length; t++) {
                            if (ze(e[t]))
                                if ((n = e[t].takeImgSrc()) && 4 < n.length) {
                                    if (-1 != (o = n.split("/"))[o.length - 1].indexOf("default"))
                                        continue;
                                    i.image = n,
                                    i.imageElement = e[t];
                                    break
                                }
                        }
                        if (!i.image && i.link && 80 < O.clientHeight && O.parentElement && O.parentElement.clientHeight - O.clientHeight < 100)
                            for (e = O.parentElement.getElementsByTagName("*"), t = 0; t < e.length; t++) {
                                var n;
                                if (ze(e[t]))
                                    if ((n = e[t].takeImgSrc()) && 4 < n.length) {
                                        var o;
                                        if (-1 != (o = n.split("/"))[o.length - 1].indexOf("default"))
                                            continue;
                                        i.image = n,
                                        i.imageElement = e[t];
                                        break
                                    }
                            }
                    }
                    i.imageElement && Ve(i.imageElement, ie, !0, i.image) && (i.images = Pe(ie, !0, !1), i.imageElement = null),
                    i.imageElement = null,
                    !i.textContent && O && (i.textContent = O.textContent),
                    ce(i),
                    webkit.messageHandlers.contextMenuMessageHandler.postMessage(i)
                }, window.__firefox__.ios13 ? 450 : 750),
                window.__firefox__.ios13 && (i.link && setTimeout(function() {
                    N && webkit.messageHandlers.contextMenuMessageHandler.postMessage({
                        handled: !0
                    })
                }, 100), webkit.messageHandlers.contextMenuMessageHandler.postMessage({
                    touchStart: !0
                }))
            }
        } else
            Ce()
    }, !0),
    addEventListener("scroll", function() {
        R && O ? Ze() : Math.abs(h() - C) > b && Ce()
    });
    var Qe = !1;
    window.__firefox__.setElementHidingEditMode || (window.via = {}, window.via.addon = function(e) {
        e = (e = window.atob(e)).replace(/(\\u[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9])/gi, function(e) {
            return e = unescape(e.replace(/\\u/g, "%u"))
        }),
        e = btoa(encodeURIComponent(e)),
        webkit.messageHandlers.contextMenuMessageHandler.postMessage({
            action: "addon",
            code: e
        })
    }, window.via.getInstalledAddonID = function() {
        return "[]"
    }, window.alook = {}, window.alook.addon = function(e) {
        webkit.messageHandlers.contextMenuMessageHandler.postMessage({
            action: "addon",
            code: e
        })
    }, window.__firefox__.cancelLongPress = Te, window.__firefox__.processDataImage = function() {
        for (var e = document.body.childNodes, t = e.length - 1; 0 <= t; t--)
            document.body.removeChild(e[t]);
        var n = document.createElement("img");
        n.src = unescape(location.href),
        n.setAttribute("style", "-webkit-user-select:none; display:block; margin:auto; padding:env(safe-area-inset-top) env(safe-area-inset-right) env(safe-area-inset-bottom) env(safe-area-inset-left);"),
        document.body.appendChild(n)
    }, window.__firefox__.addHeadJS = function(e, t) {
        var n = document.createElement("script");
        n.onload = function() {
            window.firebug && window.firebug.version && firebug.init(),
            window.VConsole && (new VConsole).show(),
            window.eruda && window.eruda.init && (window.eruda.init(), window.eruda.add(erudaCode), window.eruda.add(erudaDom), window.eruda.show()),
            t && webkit.messageHandlers.contextMenuMessageHandler.postMessage({
                action: "jsLoadSuccess"
            })
        },
        t && (n.onerror = function() {
            webkit.messageHandlers.contextMenuMessageHandler.postMessage({
                action: "jsLoadError"
            })
        }),
        n.src = e,
        (document.head ? document.head : document.documentElement).appendChild(n)
    }, window.__firefox__.outHtml = function(e) {
        var t;
        if (0 == e)
            t = document.documentElement.outerHTML;
        else {
            for (var n = document.documentElement.cloneNode(!0), o = n.getElementsByTagName("head"), i = 0; i < o.length; i++) {
                (a = o[i]).parentNode && a.parentNode.removeChild(a)
            }
            if (2 == e) {
                for (o = n.getElementsByTagName("style"), i = 0; i < o.length; i++) {
                    (a = o[i]).parentNode && a.parentNode.removeChild(a)
                }
                for (o = n.getElementsByTagName("script"), i = 0; i < o.length; i++) {
                    var a;
                    (a = o[i]).parentNode && a.parentNode.removeChild(a)
                }
            }
            t = n.outerHTML
        }
        return t = p(t = (t = p(t, "</", "ALOOKCONTEXT")).split("<").join("\n<"), "ALOOKCONTEXT", "</"), btoa(encodeURIComponent(t))
    }, window.__firefox__.scrollDidEnd = !0, window.__firefox__.scrollToNextPage = Ke, window.__firefox__.scrollToPrePage = Ge, window.__firefox__.setTouchToScrollEnable = function(e, t) {
        Y = e,
        U = t
    }, window.__firefox__.setVideoFloatingPageScrollOffset = function(e) {
        K = e
    }, window.__firefox__.setFontSize = function(e) {
        Z = e,
        pe(),
        fe()
    }, window.__firefox__.setPlayRate = function(e) {
        e && 0 < e && e < 3 && (Q = e, ye($), _e(document), ue())
    }, window.__firefox__.setClicpboardEnable = function(e) {
        G = e,
        me()
    }, window.__firefox__.setElementHidingEditMode = function(e) {
        if (0 == (R = e))
            return Ce(), "";
        var t = Xe();
        return t && t.length, t
    }, window.__firefox__.beginElementHiding = Ze, window.__firefox__.beginElementHidingByPoint = function(e, t) {
        var n = e - window.scrollX,
            o = t - window.scrollY,
            i = document.elementFromPoint(n, o);
        return i && (O = i), Ze()
    }, window.__firefox__.setElementHidingArray = function(e, t, n, o, i, a, r, d) {
        Ue(d),
        q = d,
        P = e,
        D = t,
        V = n * screen.height / 736,
        z = o,
        F = i,
        j = a,
        X = r,
        He()
    }, window.__firefox__.hideElements = He, window.__firefox__.showElementByPath = function(e) {
        var t = Ye(e);
        return t ? (function(e) {
            if (e) {
                e.classList.contains(E) && e.classList.remove(E);
                var t = e.getAttribute("style");
                t && e.setAttribute("style", t.replace("display:none !important;height: 0px !important;line-height: 0px !important;", ""))
            }
        }(t), O = t, Xe()) : ""
    }, window.__firefox__.elementHidingSelectPrevious = function() {
        return O && O.previousSibling ? (O = O.previousSibling, Xe()) : ""
    }, window.__firefox__.elementHidingSelectNext = function() {
        return O && O.nextSibling ? (O = O.nextSibling, Xe()) : ""
    }, window.__firefox__.cancelElementHiding = Ce, window.__firefox__.hideElementByPath = function(e) {
        Ce();
        var t = Ye(e);
        return t ? (Je(t), e) : ""
    }, window.__firefox__.elementHidingSelectParent = function() {
        return O && O.parentNode ? (O = (I = O).parentNode, Xe()) : ""
    }, window.__firefox__.setBaiduBannerCloseInfo = function(e, t, n) {
        if (m = e, (f = t) && 0 < n.length) {
            var o = document.createElement("style");
            o.innerText = n + "{display:none !important;height: 0px !important;line-height: 0px !important;}",
            document.documentElement.appendChild(o)
        }
    }, window.__firefox__.setBaiduShowMoreInfo = function(e, t, n, o, i) {
        if (e, l = n, o, s = i, (c = t) && 0 < e.length) {
            null == u && ((u = document.createElement("style")).innerText = e + "{opacity:0!important;}"),
            u.parentNode || document.documentElement.appendChild(u);
            var a = document.createElement("style");
            a.innerText = o + "{opacity:0!important;}",
            document.documentElement.appendChild(a)
        }
    }, window.__firefox__.elementHidingSelectFirstChild = function() {
        if (O && O.children && 0 < O.children.length) {
            var e = !1;
            if (I)
                for (var t = 0; t < O.children.length; t++)
                    if (O.children[t] === I) {
                        O = I,
                        e = !0;
                        break
                    }
            return 0 == e && (O = O.children[0]), Xe()
        }
        return ""
    }, window.__firefox__.getAllImagesWithWebInfo = Re, window.__firefox__.galleryGetImages = function(e) {
        Qe || (e || /interactive|complete/.test(document.readyState)) && (window.scrollTo(v(), document.documentElement.scrollHeight / 2), window.setTimeout(function() {
            window.scrollTo(v(), document.documentElement.scrollHeight - window.innerHeight),
            window.setTimeout(function() {
                if (!Qe) {
                    var e = Re(!0);
                    0 == e.bigImages.length && window.scrollTo(v(), 0),
                    e.galleryNext = window.__firefox__.getNextPageAndIndexURL().next,
                    webkit.messageHandlers.contextMenuMessageHandler.postMessage(e),
                    Qe = !0
                }
            }, 50)
        }, 100))
    })
}();
