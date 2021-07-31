/*
 * @Author: 丫丫的刀了 
 * @Date: 2021-07-31 06:51:27 
 * @Last Modified by: 丫丫的刀了
 * @Last Modified time: 2021-07-31 08:10:20
 */

!function() {
    console.log("主题脚本---开始");
    "use strict";
    /**
     * 当前窗口是否为最顶层的窗口 o()
     * @returns isTop
     */
    function isTopWindow() {
        try {
            return window.self === window.top;
        } catch (e) {
            return false;
        }
    }
    window.__firefox__ || (window.__firefox__ = {}),
    window.__firefox__.isNightMode = false;
    // 匹配透明颜色 (g)
    var rgba_0_Regex = /rgba\(\s*?\d+?\s*?,\s*?\d+?\s*?,\s*?\d+?\s*?,\s*?0\s*?\)/i;
    // 匹配 rgb 值为200以上的颜色 (l)
    var rgb_200_regex = /rgb\(\s*?2\d{2}\s*?,\s*?2\d{2}\s*?,\s*?2\d{2}\s*?\)/i;
    // 匹配 rgb 值为160以上的颜色 (s)
    var rgb_160_regex = /rgb\(\s*?1(6|7|8|9)\d\s*?,\s*?1(6|7|8|9)\d\s*?,\s*?1(6|7|8|9)\d\s*?\)/i;
    // 匹配 rgb 值为255 白色 (T)
    var rgba_255_regex = /rgba\(255\, 255\, 255\,/i;
    // 匹配颜色关键词 (h)
    var color_key_regex = /rgb|-webkit-gradient/i;
    // 匹配标签 (a) CANVAS, IMG, IFRAME, BR, SCRIPT, NOSCRIPT, STYLE, META, LINK, TITLE
    var tag_key = /\bCANVAS\b|\bIMG\b|\bIFRAME\b|\bBR\b|\bSCRIPT\b|\bNOSCRIPT\b|\bSTYLE\b|\bMETA\b|\bLINK\b|\bTITLE\b/;
    // (m)
    var tag_sub = /\bCANVAS\b|\bIMG\b|\bIFRAME\b|\bBR\b|\bSCRIPT\b/;

    // 0.8倍的窗口宽度 (p)
    var width_08 = .8 * window.innerWidth;
    // 当前主题名称 (i)
    var currentThemeName = "Normal";
    // r b c 客户端的主题配置
    var r = false;
    // 是否为绿色主题
    var isGreen = false;
    var c = false;

    var d = null,
        t = null,
        n = null,
        u = false;
    function k(e, t, o) {
        return e.split(t).join(o)
    }
    function f(e) {
        width_08 = .8 * window.innerWidth,
        currentThemeName != e ? ("Night" == e ? (y(), null == t && ((t = document.createElement("style")).id = "take_theme_id"), N(), function() {
            var e = document.head ? document.head : document.documentElement;
            e.appendChild(t),
            e.addEventListener("DOMNodeRemoved", M, !1)
        }(), I(B)) : ("Night" == currentThemeName && (function() {
            document.head.removeEventListener("DOMNodeRemoved", M),
            document.documentElement.removeEventListener("DOMNodeRemoved", M);
            var e = document.getElementById("take_theme_id");
            e && e.parentNode && e.parentNode.removeChild(e)
        }(), document.body && document.body.clientWidth && I(L)), "Green" == e ? (null == n && (n = document.createElement("style")), n.innerText = "*{background-color: #d1efd6!important}", (document.head ? document.head : document.documentElement).appendChild(n), I(v)) : y()), currentThemeName = e) : "Night" == e && N()
    }
    function N() {
        if (null != t) {
            var e = "[TakeTheme][TakeNightModeTransBg]{background-color: transparent !important}.black_border{border: 1px solid rgba(0, 0, 0,0.2)}#bg_sheep{background-image: none !important}#bg_cow{background-image: none !important}[TakeTheme][TakeNightDarkBgImage]{filter: brightness(62%)!important}[TakeTheme][TakeNightModeReplaceBgColor]{background:#212121!important}[TakeTheme][TakeNightModeReplaceBgColorLight]{background:#181818!important}[TakeTheme][TakeNightModeBackground]{background:#212121!important;color:#868686!important}[TakeTheme][TakeNightModeReplaceBgLinear]{background:rgba(40,40,40,.6)!important}[TakeTheme][TakeNightModeReplaceBorder]{border-color:#45484c!important}:not([TakeTheme]){border-color:#212121!important;background-color:#212121!important}*{text-shadow:none!important;box-shadow:none!important}:after,:before{-webkit-filter:brightness(0.4)}body,html{background:#212121!important;color:#868686!important}abbr,address,article,aside,b,bdi,bdo,blockquote,br,caption,cite,code,col,colgroup,data,datalist,dc,dd,dfn,dl,dt,em,fieldset,figcaption,figure,footer,form,h1,h2,h3,h4,h5,h6,header,hr,i,kbd,keygen,label,legend,li,main,mark,meter,nav,ol,optgroup,option,output,p,pre,progress,q,rp,rt,ruby,s,samp,section,small,span,strong,sub,sup,table,tbody,td,textarea,tfoot,th,thead,time,tr,u,ul,var,wbr{background-color:none;color:#868686!important}textarea{background-color:#212121!important}div,div[TakeTheme]{color:#868686!important}[TakeTheme]{color:#868686!important}a,a *,a[TakeTheme]{color:#6d97d5 !important}a[TakeTheme]:visited,a[TakeTheme]:visited [TakeTheme],a[TakeTheme]:visited div[TakeTheme],a:visited,a:visited *{color:#bd8cff!important}button:not([TakeNightModeTransBg]):not([TakeTheme]),div:not([TakeNightModeTransBg]):not([TakeTheme]),input:not([TakeNightModeTransBg]):not([TakeTheme]),select:not([TakeNightModeTransBg]):not([TakeTheme]){background:#212121!important}button[TakeThemeActionDone]:not([TakeNightModeTransBg]):not([TakeNightModeReplaceBgLinear]):not([TakeNightModeBackground]),div[TakeThemeActionDone]:not([TakeNightModeTransBg]):not([TakeNightModeReplaceBgLinear]):not([TakeNightModeBackground]),input[TakeThemeActionDone]:not([TakeNightModeTransBg]):not([TakeNightModeReplaceBgLinear]):not([TakeNightModeBackground]),select[TakeThemeActionDone]:not([TakeNightModeTransBg]):not([TakeNightModeReplaceBgLinear]):not([TakeNightModeBackground]){background-color:#212121!important}input[type=date],input[type=date] *,input[type=datetime-local],input[type=datetime-local] *,input[type=month],input[type=month] *,input[type=time],input[type=time] *,select,select *{color:#fff!important}button,input:not([type=button]):not([type=submit]):not([type=reset]):not([type=image]):not([type=file]):not([type=date]):not([type=datetime-local]):not([type=month]):not([type=time]),input[type=button],input[type=file],input[type=image],input[type=reset],input[type=submit]{color:#FFFFFF!important;border-color:#45484c!important}";
            e = r ? k(e = k(e = k(e = k(e, "212121", c ? "000000" : "121212"), "868686", "b0b0b0"), "486599", "6d97d5"), "181818", "212121") : 'input[type="image"]{filter: brightness(62%)!important}img{filter: brightness(62%)!important}' + e,
            t.innerText = e
        }
    }
    function y() {
        n && n.parentNode && n.parentNode.removeChild(n)
    }
    function v() {
        d && window.clearTimeout(d),
        n.innerText = "body,[alook__green]{background-color: #d1efd6!important}",
        document.addEventListener("DOMNodeInserted", A, !1);
        for (var e = (document.body ? document.body : document).getElementsByTagName("*"), t = 0; t < e.length; t++)
            w(e[t])
    }
    function w(e) {
        var t = window.getComputedStyle(e, null);
        (rgb_200_regex.test(t.backgroundColor) || rgba_255_regex.test(t.backgroundColor)) && e.setAttribute("alook__green", 1)
    }
    function M(e) {
        e.target && "take_theme_id" == e.target.id && window.setTimeout(function() {
            "Night" == currentThemeName && (document.head ? document.head : document.documentElement).appendChild(t)
        }, 1)
    }
    function _(e) {
        if (!e || e.nodeType == Node.TEXT_NODE || e.nodeType == Node.COMMENT_NODE)
            return null;
        if (tag_sub.test(e.tagName))
            return null;
        var t = window.getComputedStyle(e, null);
        return t ? function(e) {
            var t = parseInt(e.width, 0),
                o = parseInt(e.height, 0),
                n = rgba_0_Regex.test(e.backgroundColor),
                a = !1;
            (rgb_200_regex.test(e.borderColor) || rgb_160_regex.test(e.borderColor)) && (a = !0);
            var i = !1,
                r = !1,
                d = !1;
            if ("" !== e.backgroundImage && "none" !== e.backgroundImage) {
                var m = e.backgroundImage;
                if (-1 == m.indexOf("url(") && color_key_regex.test(m))
                    i = !0;
                else {
                    var c = e.backgroundRepeat;
                    "no-repeat" != c && "repeat" == c && (width_08 < t || 100 < o) && (r = !0)
                }
            } else
                n && !rgb_200_regex.test(e.backgroundColor) && !rgba_255_regex.test(e.backgroundColor) || (d = !0);
            var u = "";
            n ? u = i ? u + " TakeNightModeReplaceBgLinear" : r ? u + " TakeNightDarkBgImage TakeNightModeTransBg" : u + " TakeNightModeTransBg" : i ? u += " TakeNightModeReplaceBgLinear" : r && (u += " TakeNightModeBackground");
            d && (-1 != location.host.indexOf("google.com") && location.search && -1 != location.search.indexOf("tbm=isch") ? u += " TakeNightModeTransBg" : t < width_08 && o < 100 && "visible" == e.visibility ? u += "TakeNightModeReplaceBgColorLight" : u += " TakeNightModeReplaceBgColor");
            return a && (u += " TakeNightModeReplaceBorder"), u
        }(t) : null
    }
    function B() {
        d && window.clearTimeout(d),
        document.addEventListener("DOMNodeInserted", A, !1);
        for (var e = (document.body ? document.body : document).getElementsByTagName("*"), t = 0; t < e.length; t++)
            E(e[t])
    }
    function E(e) {
        e && !e.hasAttribute("TakeTheme") && e.setAttribute("TakeTheme", "");
        var t = _(e);
        if (t && 0 < t.length && e.tagName && "svg" != e.tagName.toLowerCase())
            for (var o = t.split(" "), n = 0; n < o.length; n++)
                0 < o[n].length && e.setAttribute(o[n], "")
    }
    function C(e) {
        if (e && (R(e), e.getElementsByTagName))
            for (var t = e.getElementsByTagName("*"), o = 0; o < t.length; o++)
                R(t[o])
    }
    function R(e) {
        e && e.nodeType != Node.TEXT_NODE && e.nodeType != Node.COMMENT_NODE && !tag_key.test(e.tagName) && ("Night" == currentThemeName ? E(e) : isGreen && w(e))
    }
    function A(e) {
        window.setTimeout(C, 0, e.target)
    }
    function L() {
        d && window.clearTimeout(d),
        document.removeEventListener("DOMNodeInserted", A, !1);
        for (var e = /takenightmode[\s\S]*?\b/g, t = document.getElementsByTagName("*"), o = 0; o < t.length; ++o) {
            var n = t[o];
            if (n && n.nodeType != Node.TEXT_NODE && n.nodeType != Node.COMMENT_NODE) {
                if (tag_sub.test(n.tagName))
                    continue;
                if (n.hasAttribute("TakeTheme")) {
                    n.removeAttribute("TakeTheme"),
                    n.removeAttribute("TakeThemeActionDone");
                    for (var a = n.getAttributeNames(), i = 0; i < a.length; i++) {
                        var r = a[i].match(e);
                        r && 0 < r.length && n.removeAttribute(a[i])
                    }
                }
            }
        }
    }
    function O(e) {
        /interactive|complete/.test(document.readyState) ? u || (e(), u = !0) : window.setTimeout(O, 500, e)
    }
    function I(t) {
        /interactive|complete/.test(document.readyState) ? window.setTimeout(t, 0) : (document.addEventListener("readystatechange", function e() {
            "complete" == document.readyState && (u || (t(), u = !0), document.removeEventListener("readystatechange", e, !1))
        }, !1), O(t))
    }
    function x(e, t) {
        if (e) {
            var o = e.getAttribute("style");
            -1 == (o = o || "").indexOf(t) && e.setAttribute("style", o + t)
        }
    }

    /**
     * 清除元素的背景色 D(e)
     * @param {Element} element 
     */
    function clearElementBgColor(element) {
        if (element) {
            element.style.backgroundColor = null;
        }
    }
    /**
     * 更新主题 e(e)
     * @param {Boolean} isNight 是否为夜间主题
     */
    function updateTheme(isNight) {
        console.log('------->更新主题样式');
        function t() {
            if (window.__firefox__.isNightMode) {
                f("Night");
            }else{
                f(isGreen ?  "Green" : "Normal");
            }
        }
        
        window.__firefox__.isNightMode = isNight;
        var htmlElements = document.getElementsByTagName('html');
        var subHtmElement = null;
        if (htmlElements && 0 < htmlElements.length){
            subHtmElement = htmlElements[0];
            clearElementBgColor(subHtmElement);
            clearElementBgColor(document.body);
            if (isNight) {
                var bgColorStyle = r ? c ? "background-color:#000000 !important;" : "background-color:#121212 !important;" : "background-color:#212121 !important;";
                x(subHtmElement, bgColorStyle);
                x(document.body, bgColorStyle);
            }else if (isGreen){
                var bgColorStyle = "background-color:#d1efd6 !important;";
                x(subHtmElement, bgColorStyle);
                x(document.body, bgColorStyle);
            }
        }
        if (document.head) {
            t();
        }else{
            window.setTimeout(function(){
                t();
            }, 0)
        }
    }
    
    /**
     * 获取客户端的主题配置 S()
     */
    function clientThemeConfig() {
        try {
            // t 为 字符串数组， t[0] 为控制是否为夜间模式 t[]
            var t = window.prompt("_ThemeConfig_").split("==");
        } catch (e) {
            t = ["true", "", "", ""];
        }
        console.log('获取客户端主题配置', t);
        r = "true" == t[1];
        isGreen = "true" == t[2];
        c = "true" == t[3];
        var isNight = "true" == t[0];
        updateTheme(isNight);
    }

    if (isTopWindow()) {
        window.__firefox__.forceUpdateTheme = function() {
            clientThemeConfig();
            if (isTopWindow()){
                var frams = window.frames;
                console.log('遍历 frams ',frams.length);
                for (t = 0; t < frams.length; t++){
                    console.log('为 fram 发送更新主题的 message');
                    frams[t].postMessage('{"alookUpdateTheme":1}', "*");
                }  
            }
        }
    }else{
        console.log('为 window 添加 message 监听')
        window.addEventListener("message", function(event) {
            console.log('收到 message>>>>',event.data);
            if ("string" == typeof(event.data) && -1 != event.data.indexOf("alookUpdateTheme")) {
                clientThemeConfig();
            }
        }, false);
    }
    clientThemeConfig();
    console.log("主题脚本---结束");
}();
