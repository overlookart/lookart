!function() {
    "use strict";
    function l() {
        try {
            return window.self === window.top
        } catch (e) {
            return !1
        }
    }
    window.__firefox__ || (window.__firefox__ = {});
    try {
        var t = window.prompt("_VideoConfig_").split("==")
    } catch (e) {
        t = ["", "", "", ""]
    }
    var n = t[0];
    function o() {
        if (!l() && "avgle.com" == n)
            return !0;
        var e = location.host;
        return !(-1 == e.indexOf("google.com") || !location.search || -1 == location.search.indexOf("tbm=isch")) || l() && ("m.iqiyi.com" == e || "www.iqiyi.com" == e)
    }
    var d = "true" == t[1] && !o(),
        e = "true" == t[2] && l(),
        a = 0 == t[3].length ? Array() : t[3].split(" "),
        r = null,
        s = 1,
        c = !1;
    function i(e, t) {
        for (var n = new Array, o = 0; o < e.length; o++)
            n.push(e[o]);
        for (o = 0; o < t.length; o++)
            n.push(t[o]);
        return n
    }
    function u(e, t) {
        var n = document.createEvent("HTMLEvents");
        n.initEvent(t, !1, !0),
        n.isTakeEvent = !0,
        (null != e.originVideo ? e.originVideo : e).dispatchEvent(n)
    }
    if (d && (window.MediaSource = void 0), d && (e || (HTMLVideoElement.prototype.play = v, HTMLVideoElement.prototype.load = h, HTMLAudioElement.prototype.play = v, HTMLAudioElement.prototype.load = h), HTMLVideoElement.prototype.webkitEnterFullScreen = function(e) {}, HTMLVideoElement.prototype.webkitEnterFullscreen = function(e) {}, HTMLVideoElement.prototype.webkitRequestFullScreen = function(e) {}, HTMLVideoElement.prototype.webkitRequestFullscreen = function(e) {}, HTMLVideoElement.prototype.webkitSetPresentationMode = function(e) {}), l()) {
        window.addEventListener("popstate", function(e) {
            c = !0,
            webkit.messageHandlers.VideoHandler.postMessage("popstate"),
            y(),
            c = !1
        });
        var f = window.history.pushState;
        window.history.pushState = function(e, t, n) {
            webkit && webkit.messageHandlers && webkit.messageHandlers.VideoHandler.postMessage("pushState"),
            f.apply(window.history, arguments),
            y()
        };
        var p = window.history.replaceState;
        window.history.replaceState = function(e, t, n) {
            webkit && webkit.messageHandlers && webkit.messageHandlers.VideoHandler.postMessage("replaceState"),
            p.apply(window.history, arguments)
        },
        window.__firefox__.videoStopLoading = m,
        window.__firefox__.setVideoClick = function() {
            s = 0;
            for (var e = window.frames, t = 0; t < e.length; t++)
                e[t].postMessage('{"videoClickPlay":1}', "*")
        },
        window.__firefox__.videoDispatchEnd = function() {
            if (r)
                u(r, "ended");
            else
                for (var e = window.frames, t = 0; t < e.length; t++)
                    e[t].postMessage('{"videoDispatchEnd":1}', "*")
        },
        window.__firefox__.floatingPlayCacheNode = function() {
            if (r)
                g();
            else
                for (var e = window.frames, t = 0; t < e.length; t++)
                    e[t].postMessage('{"floatingPlayCacheNode":1}', "*")
        },
        window.__firefox__.fullScreenPlayCacheNode = function() {
            if (r)
                w();
            else
                for (var e = window.frames, t = 0; t < e.length; t++)
                    e[t].postMessage('{"fullScreenPlayCacheNode":1}', "*")
        }
    } else
        window.addEventListener("message", function(e) {
            "string" == typeof e.data && (-1 != e.data.indexOf("videoDispatchEnd") ? r && u(r, "ended") : -1 != e.data.indexOf("videoClickPlay") ? s = 0 : -1 != e.data.indexOf("videoFloatingPlay") ? g() : -1 != e.data.indexOf("fullScreenPlayCacheNode") && w())
        });
    function g() {
        r.pause()
    }
    function w() {
        r.webkitEnterFullScreen()
    }
    function m() {
        if (0 != d) {
            y();
            var e = document.body.children;
            if (1 == e.length && ("VIDEO" == e[0].tagName || "AUDIO" == e[0].tagName)) {
                var t = e[0];
                _(t, "get");
                var n = document.body.innerHTML;
                n += '<div id="AlookVideoCover" style="max-width: 100%;position: fixed;left: 0;right: 0;top: 0;bottom: 0; max-height: 100%;width: 100%; height: 100%;">',
                document.body.innerHTML = n,
                window.setTimeout(function() {
                    document.getElementById("AlookVideoCover").onclick = function() {
                        _(t, "play")
                    }
                }, 50)
            }
        }
    }
    function y() {
        if (d) {
            s = 1,
            document.removeEventListener("DOMNodeInserted", T, !1),
            document.addEventListener("DOMNodeInserted", T, !1);
            var t = null;
            i(document.getElementsByTagName("video"), document.getElementsByTagName("audio")).forEach(function(e) {
                N(e),
                A(e, "get"),
                !t && 0 < M(e).src.length && (t = e)
            }),
            _(t, "get")
        }
    }
    function v() {
        var e = null;
        !this.originVideo && this.parentNode && (e = function(e) {
            var t = e.parentNode;
            if (t) {
                var n = e.cloneNode(!0);
                return n.onclick = function(e) {
                    e && e.target && ("VIDEO" != (e = e.target).nodeName && "AUDIO" != e.nodeName || e.play())
                }, n.takeListened = !0, n.originVideo = e, function(e) {
                    e.removeAttribute("src");
                    for (var t = e.getElementsByTagName("source"), n = 0; n < t.length; n++)
                        t[n].removeAttribute("src")
                }(n), N(n), t.replaceChild(n, e), n
            }
        }(this));
        var t = window.event;
        if (!t || "click" != t.type && "tap" != t.type && 0 != t.type.indexOf("touch") || (s = 0), -1 == window.location.hostname.indexOf("youku.com") || 1 != s) {
            var n = _(this, "play");
            if (A(r = this, n ? "get" : "play"), e && A(r, "play"), window.setTimeout(function() {
                u(this, "play")
            }, 100), n && 0 < a.length) {
                for (var o = !1, i = 0; i < a.length; i++)
                    if (-1 != n.src.indexOf(a[i])) {
                        o = !0;
                        break
                    }
                o && u(this, "ended")
            }
        }
    }
    function h() {
        var e = this instanceof HTMLAudioElement;
        r = this,
        e || "www.bilibili.com" == location.host ? (s = 0, _(this, "play")) : _(this, "get")
    }
    function b(e) {
        if (!e.isTakeEvent && d) {
            s = 0;
            var t = e.target,
                n = _(r = t, "play");
            n ? E(t, n) : A(null != t.originVideo ? t.originVideo : t, "play")
        }
    }
    function E(n, o) {
        window.setTimeout(function() {
            if (n.pause(), o && 0 < a.length) {
                for (var e = !1, t = 0; t < a.length; t++)
                    if (-1 != o.src.indexOf(a[t])) {
                        e = !0;
                        break
                    }
                e && u(n, "ended")
            }
        }, 100)
    }
    function k(e) {
        e.stopImmediatePropagation()
    }
    function _(e, t) {
        if (c || !e)
            return null;
        var n = M(e);
        if (0 == n.src.length && (n = M(e.originVideo)), 0 == n.src.length)
            return null;
        var o = function(e) {
                var t = e.getAttribute("title");
                if (!t || 0 == t.length) {
                    var n = document.querySelector(".x-video-title,.video-title-left");
                    n && (t = n.innerText)
                }
                t && 0 != t.length || (t = document.title);
                return t || ""
            }(e),
            i = location.href,
            a = document.querySelector("meta[name='referrer']");
        a && a.content && ("no-referrer" != a.content && "never" != a.content || (i = ""));
        var r = {
            src: n.src,
            support: n.support,
            title: o,
            isMainFrame: l(),
            referer: i,
            autoPlay: s,
            msgId: t,
            videoEnable: d,
            video: e instanceof HTMLVideoElement
        };
        return d && n.src.startsWith("blob") || webkit.messageHandlers.VideoHandler.postMessage(r), r
    }
    function M(e) {
        if (!e)
            return {
                src: ""
            };
        var t = e.src;
        if (t && 0 < t.length)
            t = e.src;
        else {
            for (var n = "", o = !0, i = e.getElementsByTagName("source"), a = 0; a < i.length; ++a) {
                var r = i[a],
                    l = r.getAttribute("src"),
                    d = r.getAttribute("type");
                if (l && 0 < l.length) {
                    var s = r.src;
                    if (s && 0 < s.length) {
                        if ("video/webm" == d) {
                            t = s,
                            o = !1;
                            break
                        }
                        var c = e.canPlayType(d);
                        if ("probably" == c) {
                            t = s;
                            break
                        }
                        "maybe" == c ? t = s : n = s
                    }
                }
            }
            (!t || t.length <= 0) && 0 < n.length && (t = n, o = !1)
        }
        return {
            src: t || "",
            support: o
        }
    }
    function T(e) {
        var t = e.target;
        if (t && t.getElementsByTagName) {
            var n = i(t.getElementsByTagName("video"), t.getElementsByTagName("audio"));
            t instanceof HTMLMediaElement && n.push(t),
            n.forEach(function(e) {
                N(e),
                A(e, "get")
            })
        }
    }
    function A(t, n) {
        if (t) {
            t.alookSrcObserver && t.alookSrcObserver.disconnect();
            var e = new MutationObserver(function(e) {
                e.forEach(function(e) {
                    "src" === e.attributeName ? (n = t.alookAutoPlay || t.autoplay ? "play" : n || "get", _(t, n) && "play" == n && E(t)) : "autoplay" === e.attributeName && (t.alookAutoPlay = t.autoplay, t.autoplay && _(t, "play"))
                })
            });
            e.observe(t, {
                attributes: !0,
                attributesFilter: ["src"]
            }),
            t.alookSrcObserver = e
        }
    }
    function L(e, t, n) {
        e.takeEventArray || (e.takeEventArray = new Array),
        -1 == e.takeEventArray.indexOf(t) && (e.addEventListener(t, n, !1), e.takeEventArray.push(t))
    }
    function N(e) {
        L(e, "play", b),
        L(e, "pause", k),
        e.alookAutoPlay = e.autoplay,
        e.removeAttribute("autoplay"),
        e.setAttribute("preload", "none"),
        e.setAttribute("webkit-playsinline", ""),
        e.setAttribute("playsinline", ""),
        e.tagName && "audio" != e.tagName.toLowerCase() && (e.controls = 1)
    }
    document.addEventListener("DOMContentLoaded", function() {
        y()
    }),
    window.addEventListener("load", m),
    window.__firefox__.sendVideoNode = function(e) {
        d || o() || _(r = e, "get")
    }
}();
