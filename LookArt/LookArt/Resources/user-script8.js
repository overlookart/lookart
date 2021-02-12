!function() {
    "use strict";
    window.__firefox__ || (window.__firefox__ = {});
    var a = "fr" == document.documentElement.lang,
        e = !1,
        t = null,
        u = ["余下全文", "下页", "下一页", "下一张", "下张", "下章", "下一篇", "下篇", "下一章", "下节", "下一节", "下一頁", "下頁", "下屏", "下一屏", "[->]", "[>]", "[->>]", "[>>]", "nextchapter", "nextpage", "[next", "continuereading", "siguiente", "Próxima", "páginasiguiente", "pagesuivante", "suivant", "próxima", "próximo", "продолжитьчтение", "след", "следующая", "еще", "tiếp", "trangtiếp", "trangkế", "chươngtiếp", "chươngsau", "sau", "다음회", "次のページ", "次の章", "次へ"],
        i = ["章节列表", "章节目录", "返回目录", "目录", "목록", "index", "contents", "mục lục", "Chỉ mục", "索引", "ディレクトリ"];
    function f(e, t, n) {
        if (!t || !t.textContent)
            return 0;
        var r = t.textContent.replace(/\s/g, "").toLowerCase();
        if (0 == r.length)
            return 0;
        for (var i = 0; i < e.length; i++)
            if (-1 != r.indexOf(e[i]))
                return "A" == t.tagName && 0 == t.href.length ? 2 : 3;
        return n ? r.endsWith(">") || r.endsWith("»") || r.startsWith("下一") ? 2 : -1 != r.indexOf("moreresults") || -1 != r.indexOf("更多结果") ? 2 : r.startsWith("next") ? 1 : a && -1 != r.indexOf("plus") ? 1 : 0 : 0
    }
    function l(e) {
        if (!e)
            return !1;
        if (0 < e.clientHeight && 0 < e.clientHeight)
            return !0;
        var t = e.getBoundingClientRect();
        return 0 < t.width && 0 < t.height
    }
    function n(e) {
        for (var t = 0, n = null, r = null, i = 0; i < e.length; i++) {
            var a = e[i];
            if (l(a)) {
                var o = a.className + " " + a.id;
                -1 == o.indexOf("nextpage") && -1 == o.indexOf("pnnext") || (n = a, t = 2);
                var s = f(u, a, !0);
                if (3 == s)
                    return a;
                0 != s ? t < s && (n = a, t = s) : !r && a.parentNode && a.parentNode.childNodes.length < 4 && 3 == f(u, a.parentNode) && (r = a)
            }
        }
        return n || r
    }
    function o() {
        var e = n(document.querySelectorAll("button,a"));
        return e || n(document.querySelectorAll("[class*='button'],[class*='btn']"))
    }
    window.__firefox__.getNextPageAndIndexURL = function() {
        var e = o(),
            t = function(e) {
                if (!e)
                    return "";
                var t = "";
                if (e.href && 0 == e.href.indexOf("http"))
                    t = e.href;
                else {
                    var n = e.getAttribute("data-href");
                    if (n && 0 == n.indexOf("http"))
                        t = n;
                    else
                        for (var r = e.attributes, i = 0; i < r.length; i++)
                            if ((n = r[i].nodeValue) && 0 == n.indexOf("http")) {
                                t = n;
                                break
                            }
                }
                return t
            }(e);
        e && 0 == t.length && (t = "1");
        var n = function() {
                for (var e = document.getElementsByTagName("a"), t = 0; t < e.length; t++) {
                    var n = e[t];
                    if (0 < f(i, n, !1))
                        return n
                }
                return null
            }(),
            r = "";
        return n && n.href && (r = n.href), {
            next: t,
            index: r
        }
    },
    window.__firefox__.checkHaveNextPage = function() {
        e && t ? webkit.messageHandlers.nextPageMessageHandler.postMessage(1) : (t = o()) ? (e = !0, webkit.messageHandlers.nextPageMessageHandler.postMessage(1)) : (e = !1, webkit.messageHandlers.nextPageMessageHandler.postMessage(0))
    },
    window.__firefox__.loadNextPage = function() {
        if (t && l(t) || (t = o()), t) {
            if ("m.baidu.com" == location.host || "www.baidu.com" == location.host) {
                var e = document.createEvent("HTMLEvents");
                e.initEvent("click", !1, !0),
                t.dispatchEvent(e)
            } else
                t.click();
            return !0
        }
        return !1
    }
}();
