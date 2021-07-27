/** lookart script */


//代码规范
//1.命名空间(namespace)
//把变量放到匿名立即执行函数里，让变量锁死在函数作用域里
(function() {
    if (!window.lookArt) {
        //为 window 定义 lookArt 属性
        Object.defineProperty(window, "lookArt", {
            //该属性能否被修改/删除 默认false，true时可以被修改/删除
            configurable: false,
            //是否为对象的枚举属性，默认false， true时为对象的枚举属性
            enumerable: false,
            //value 的值是否能被赋值运算符改变
            writable: false,
            //
            value: {
                enabled: false,
                isNightMode: true
            }
        });
    }

    try {
        window.webkit.messageHandlers.lookArt.postMessage({'code': 200, 'msg': '初始化脚本成功'});
    } catch (error) {
        console.log(error);
    }
})();

(function(){
    console.log("主题脚本---开始");
    function o(){
        try {
            return window.self === window.top;
        } catch (e) {
            return false;
        }
    }
    /**
     * 正则表达式
     * 调试地址：https://projects.verou.me/regexplained/
     * \s 匹配所有空白符和换行 \S非空白符和非换行
     * * 匹配前面的子表达式零次或多次,等价于{0,}
     * \d 匹配一个数字字符。等价于 [0-9]
     * + 匹配前面的子表达式一次或多次, 等价于 {1,}
     * ? 匹配前面的子表达式零次或一次, 等价于 {0,1}
     * /i 不区分大小写
     * /b 匹配一个单词边界，也就是指单词和空格间的位置
     */

    // 匹配透明颜色 (g)
    var rgba_0_Regex = /rgba\(\s*?\d+?\s*?,\s*?\d+?\s*?,\s*?\d+?\s*?,\s*?0\s*?\)/i;
    // 匹配 rgb 值为200以上的颜色 (l)
    var rgb_200_regex = /rgb\(\s*?2\d{2}\s*?,\s*?2\d{2}\s*?,\s*?2\d{2}\s*?\)/i;
    // 匹配 rgb 值为160以上的颜色 (s)
    var rgb_160_regex = /rgb\(\s*?1(6|7|8|9)\d\s*?,\s*?1(6|7|8|9)\d\s*?,\s*?1(6|7|8|9)\d\s*?\)/i;
    // 匹配 rgb 值为255 白色 (T)
    var rgba_255_regex = /rgba\(\s*?255\s*?\,\s*?255\s*?\,\s*?255\s*?\,/i;
    // 匹配颜色关键词 (h)
    var color_key_regex = /rgb|-webkit-gradient/i;
    // 0.8倍的窗口宽度 (p)
    var width_08 = .8 * window.innerWidth;
    // 匹配标签 (a) CANVAS, IMG, IFRAME, BR, SCRIPT, NOSCRIPT, STYLE, META, LINK, TITLE
    var tag_key = /\bCANVAS\b|\bIMG\b|\bIFRAME\b|\bBR\b|\bSCRIPT\b|\bNOSCRIPT\b|\bSTYLE\b|\bMETA\b|\bLINK\b|\bTITLE\b/;
    // (m)
    var tag_sub = /\bCANVAS\b|\bIMG\b|\bIFRAME\b|\bBR\b|\bSCRIPT\b/;
    // 当前主题名称 (i)
    var currentThemeName = 'Normal';

    var r = false;
    var c = false;
    var u = false;
    // 是否为绿色主题 (b)
    var isGreen = false;

    //
    var d = null;
    // html元素 (t) 标签为style id:take_theme_id
    var themeStyleElement  = null;
    // 可能为 某个节点
    var n = null;
    
    /**
     * 替换 String 中的某些字符
     * @param {*} str 源字符串
     * @param {*} subStr 被替换的字符串
     * @param {*} useStr 用来替换的字符串
     * @returns 替换完成的字符串
     */
    function k(str, subStr, useStr){
        // split(t) 方法用于把一个字符串分割成字符串数组 t为分割符
        // join(o) 把数组中的所有元素转换一个字符串 o为连接符
        return str.split(subStr).join(useStr);
    }

    /**
     * 将 n 节点从父节点上移除
     */
    function y() {
        console.log("function y() 移除节点 n");
        if (n && n.parentNode) {
            n.parentNode.removeChild(n)
        }
    }

    /**
     * 为 themeStyleElement 设置样式属性
     */
    function N() {
        if (themeStyleElement) {
            var e = "[TakeTheme][TakeNightModeTransBg]{background-color: transparent !important}.black_border{border: 1px solid rgba(0, 0, 0,0.2)}#bg_sheep{background-image: none !important}#bg_cow{background-image: none !important}[TakeTheme][TakeNightDarkBgImage]{filter: brightness(62%)!important}[TakeTheme][TakeNightModeReplaceBgColor]{background:#212121!important}[TakeTheme][TakeNightModeReplaceBgColorLight]{background:#181818!important}[TakeTheme][TakeNightModeBackground]{background:#212121!important;color:#868686!important}[TakeTheme][TakeNightModeReplaceBgLinear]{background:rgba(40,40,40,.6)!important}[TakeTheme][TakeNightModeReplaceBorder]{border-color:#45484c!important}:not([TakeTheme]){border-color:#212121!important;background-color:#212121!important}*{text-shadow:none!important;box-shadow:none!important}:after,:before{-webkit-filter:brightness(0.4)}body,html{background:#212121!important;color:#868686!important}abbr,address,article,aside,b,bdi,bdo,blockquote,br,caption,cite,code,col,colgroup,data,datalist,dc,dd,dfn,dl,dt,em,fieldset,figcaption,figure,footer,form,h1,h2,h3,h4,h5,h6,header,hr,i,kbd,keygen,label,legend,li,main,mark,meter,nav,ol,optgroup,option,output,p,pre,progress,q,rp,rt,ruby,s,samp,section,small,span,strong,sub,sup,table,tbody,td,textarea,tfoot,th,thead,time,tr,u,ul,var,wbr{background-color:none;color:#868686!important}textarea{background-color:#212121!important}div,div[TakeTheme]{color:#868686!important}[TakeTheme]{color:#868686!important}a,a *,a[TakeTheme]{color:#6d97d5 !important}a[TakeTheme]:visited,a[TakeTheme]:visited [TakeTheme],a[TakeTheme]:visited div[TakeTheme],a:visited,a:visited *{color:#bd8cff!important}button:not([TakeNightModeTransBg]):not([TakeTheme]),div:not([TakeNightModeTransBg]):not([TakeTheme]),input:not([TakeNightModeTransBg]):not([TakeTheme]),select:not([TakeNightModeTransBg]):not([TakeTheme]){background:#212121!important}button[TakeThemeActionDone]:not([TakeNightModeTransBg]):not([TakeNightModeReplaceBgLinear]):not([TakeNightModeBackground]),div[TakeThemeActionDone]:not([TakeNightModeTransBg]):not([TakeNightModeReplaceBgLinear]):not([TakeNightModeBackground]),input[TakeThemeActionDone]:not([TakeNightModeTransBg]):not([TakeNightModeReplaceBgLinear]):not([TakeNightModeBackground]),select[TakeThemeActionDone]:not([TakeNightModeTransBg]):not([TakeNightModeReplaceBgLinear]):not([TakeNightModeBackground]){background-color:#212121!important}input[type=date],input[type=date] *,input[type=datetime-local],input[type=datetime-local] *,input[type=month],input[type=month] *,input[type=time],input[type=time] *,select,select *{color:#fff!important}button,input:not([type=button]):not([type=submit]):not([type=reset]):not([type=image]):not([type=file]):not([type=date]):not([type=datetime-local]):not([type=month]):not([type=time]),input[type=button],input[type=file],input[type=image],input[type=reset],input[type=submit]{color:#FFFFFF!important;border-color:#45484c!important}";
            if(r){
                e = k(e, "212121", c ? "000000" : "121212");
                e = k(e, "868686", "b0b0b0");
                e = k(e, "486599", "6d97d5");
                e = k(e, "181818", "212121");
            }else{
                e = 'input[type="image"]{filter: brightness(62%)!important}img{filter: brightness(62%)!important}' + e;
            }
            themeStyleElement.innerText = e;
        }
    }

    

    /**
     * 清空元素背景色 (D())
     * @param {Element} element 
     */
    function clearElementBGColor(element) {
        console.log("function clearElementBGColor 为标签",element.tagName,"清空背景色");
        if (element) {
            element.style.backgroundColor = null;
        }
    }

    /**
     * 为 element 附加 新的style (x(e,t))
     * @param {Element} element 
     * @param {String} styleStr 
     */
    function addStyleForElement(element, styleStr) {
        console.log("function addStyleForElement为标签",element.tagName,"添加样式：",styleStr);
        if (element) {
            var elementStyle = element.getAttribute("style");
            elementStyle = elementStyle ? elementStyle : "";
            if (-1 == elementStyle.indexOf(styleStr)) {
                element.setAttribute("style", elementStyle + styleStr);
            }
        }
    }

    /**
     * 
     * @param {*} e 
     */
    function e(e) {
        function t() {
            if (window.lookArt.isNightMode) {
                f("Night");
            }else{
                f(isGreen ? "Green" : "Normal")
            }
        }
        console.log("function e 参数:",e);
        (function(e){
            console.log("function e 匿名函数 参数:",e);
            var t = document.getElementsByTagName("html");
            var o = null;
            if (t && t.length > 0, e) {
                o = t[0];
                clearElementBGColor(o);
                clearElementBGColor(document.body);
                var test =  c ? "background-color:#000000 !important;" : "background-color:#121212 !important;";
                var test1 = r ? test : "background-color:#212121 !important;";
                addStyleForElement(o, test1);
                addStyleForElement(document.body, test1);
            }else if (isGreen){
                var n = "background-color:#d1efd6 !important;";
                addStyleForElement(o, n);
                addStyleForElement(document.body, n);
            }
        })(window.lookArt.isNightMode = e); // 修改了 lookArt.isNightMode

        if (document.head) {
            t();
        }else{
            window.setTimeout(function(){
                t();
            }, 0);
        }

    }

    function O(e) {
        if (/interactive|complete/.test(document.readyState)) {
            u = true;
            e();
        }else{
            window.setTimeout(O, 500, e)
        }
    }

    /**
     * 
     * @param {Function} t 
     */
    function I(t) {
        if(/interactive|complete/.test(document.readyState)){
            window.setTimeout(t, 0);
        }else{
            document.addEventListener("readystatechange", function e(){
                if ("complete" == document.readyState) {
                    u = true;
                    t();
                    document.removeEventListener("readystatechange", e, false);
                }
            },false);
            O(t);
        }
    }

    function w(e) {
        var t = window.getComputedStyle(e, null);
        if(rgb_200_regex.test(t.backgroundColor) || rgba_255_regex.test(t.backgroundColor)){
            e.setAttribute("lookart_green",1);
        }
        
    }

    function R(e) {
        if (e && e.nodeType!= Node.TEXT_NODE && e.nodeType != Node.COMMENT_NODE && !tag_key.test(e.tagName)) {
            if("Night" == currentThemeName){
                E(e);
            }else if (isGreen){
                w(e)
            }
        }
    }

    function C(e) {
        if (e){
            R(e);
            var t = e.getElementsByTagName("*");
            for (var o = 0; o < t.length; o++){
                R(t[o]);
            }
        }
    }

    function A(e) {
        window.setTimeout(C, 0, e.target);
    }

    /**
     * 
     * @param {*} e 
     * @returns 
     */
    function _(e) {
        if(!e || e.nodeType == Node.TEXT_NODE || e.nodeType == Node.COMMENT_NODE){
            return null;
        }
        if(tag_sub.test(e.tagName)){
            return null;
        }
        var t = window.getComputedStyle(e, null);
        if (t){
            return function(e){
                var t = parseInt(e.width, 0);
                var o = parseInt(e.height, 0);
                var n = rgba_0_Regex.test(e.backgroundColor);
                var a = false;
                if(rgb_200_regex.test(e.borderColor) || rgb_160_regex.test(e.borderColor)){
                    a = true;
                }
                var i = false;
                var r = false;
                var d = false;
                if("" !== e.backgroundImage && "none" !== e.backgroundImage){
                    var m = e.backgroundImage;
                    if(-1 == m.indexOf("url(") && color_key_regex.test(m)){
                        i = true;
                    }else{
                        var c = e.backgroundRepeat;
                        if("no-repeat" != c && "repeat" == c && (width_08 < t)){
                            r = true;
                        }
                    }
                }else{
                    if(n && rgb_200_regex.test(e.backgroundColor) && !rgba_255_regex.test(e.backgroundColor)){
                        d = true;
                    }
                }
                var u = "";
                if (n){
                    if (i){
                        u = u + " TakeNightModeReplaceBgLinear";
                    }else{
                        
                        if (r) {
                            u = u + " TakeNightDarkBgImage TakeNightModeTransBg";
                        }else{
                            u = u + " TakeNightModeTransBg";
                        } 
                    }
                }else{
                    if (i) {
                        u = u + " TakeNightModeReplaceBgLinear";
                    }else{
                        if (r) {
                            u = u + "TakeNightModeBackground";
                        }
                    }
                }

                if (d && -1 != location.host.indexOf("google.com") && -1 != location.search.indexOf("tbm=isch")){
                    u = u + " TakeNightModeTransBg";
                }else{
                    if (t < width_08 && o < 100 && "visible" == e.visiblity) {
                        u = u + "TakeNightModeReplaceBgColorLight";
                    }else{
                        u = u + "TakeNightModeReplaceBgColor"
                    }
                }
                if (a) {
                    u = u + " TakeNightModeReplaceBorder";
                }
                return u;
            }(t);
        }else{
            return null;
        }
    }

    function E(e){
        if(e && !e.hasAttribute("TakeTheme")){
            e.setAttribute("TakeTheme", "");
        }
    }

    function B() {
        if (d) {
            window.clearTimeout(d);
            document.addEventListener("DOMNodeInserted", A, false);
            var e = document.body ? document.body : document.getElementsByTagName("*");
            for (var t = 0; t < e.length; t++){
                
            }
        }
    }   

    function L(){
        if (d) {
            window.clearTimeout(d);
        }
        document.removeEventListener("DOMNodeInserted", A, false);
        var e = /takenightmode[\s\S]*?\b/g;
        var t = document.getElementsByTagName("*");
        for (var o = 0; o < t.length; o++){
            var n = t[o];
            if (n && n.nodeType != Node.TEXT_NODE && n.nodeType != Node.COMMENT_NODE) {
                if (tag_sub.test(n.tagName)) {
                    continue;
                }
                if (n.hasAttribute("TakeTheme")) {
                    n.removeAttribute("TakeTheme");
                    n.removeAttribute("TakeThemeActionDone");
                    var a = n.getAttributeNames();
                    for(var i = 0; i < a.length; i++){
                        var r = a[i].match(e);
                        if (r && 0 < r.length) {
                            n.removeAttribute(a[i]);
                        }
                    }
                }
            }
        }
    }

    //event listener function

    /**
     * 监听 DOMNodeRemoved 的回调方法 (M())
     * @param {MutationEvent} event 
     */
    function domNodeRemoved(event) {
        console.log("function domNodeRemoved 收到 DOM 移除 Node的回调",e.target);
        if (event.target && "take_theme_id" == event.target.id) {
            setTimeout(function(){
                if("Night" == currentThemeName){
                    var p = document.head ? document.head : document.documentElement;
                    p.appendChild(themeStyleElement);
                }
            }, 1)
        }
    }

    function v() {
        if (d) {
            window.clearTimeout(d);
            n.innerText = "body,[alook__green]{background-color: #d1efd6!important}";
            document.addEventListener("DOMNodeInserted", A, false);
        }
        var e = (document.body ? document.body : document).getElementsByTagName("*");
        for (var t = 0; t < e.length; t++){
            w(e[t]);
        }
    }

    /**
     * 
     * @param {String} themeName 主题名称
     */
    function f(themeName) {
        width_08 = .8 * window.innerWidth;
        if (currentThemeName != themeName) {
            if ("Night" == themeName) {
                y();
                if(themeStyleElement == null){
                    themeStyleElement = document.createElement("style");
                    themeStyleElement.id = "take_theme_id";
                }
                N();
                (function(){
                    var e = document.head ? document.head : document.documentElement;
                    e.appendChild(themeStyleElement);
                    e.addEventListener("DOMNodeRemoved", domNodeRemoved, false);
                })();
                I(B);
            }else{
                if ("Night" == currentThemeName) {
                    (function(){
                        document.head.removeEventListener("DOMNodeRemoved", domNodeRemoved);
                        document.documentElement.removeEventListener("DOMNodeRemoved", domNodeRemoved);
                        var e = document.getElementById("take_theme_id");
                        if (e && e.parentNode) {
                            console.log("function f() 移除节点")
                            e.parentNode.removeChild(e);
                        }
                    })();
                    if (document.body && document.body.clientWidth) {
                        I(L);
                    }
                    if ("Green" == e){
                        if(!n){
                            n = document.createElement("style");
                            n.innerText = "*{background-color: #d1efd6!important}";
                            (document.head ? document.head : document.documentElement).appendChild(n);
                            I(v);
                        }else{
                            y();
                            currentThemeName = e;
                        }
                    }else{
                        if("Night" == e){
                            N();
                        }
                    }
                }
            }
        }else{
            if ("Night" == themeName) {
                N();
            }
        }
    }
    function S() {
        try {
            // t 为 字符串数组， t[0] 为控制是否为夜间模式
            var t = window.prompt("_ThemeConfig_").split("==");
        } catch (e) {
            t = ["true", "", "", ""];
        }
        console.log("theme config", t);
        r = "true" == t[1];
        b = "true" == t[2];
        c = "true" == t[3];
        e("true" == t[0]);
    }
    if (o()) {
        console.log("a----------");
        window.lookArt.forceUpdateTheme = function () {
            S();
            (function () {
                if (o()) {
                    var e = window.frames;
                    for (var t = 0; t < e.length; t++){
                        var nn = e[t];
                        console.log("window frame:",nn);
                        nn.postMessage('{"alookUpdateTheme":1}', "*");
                    }
                }
            })()
        }
    }else{
        console.log("b----------");
        window.addEventListener("message", function (e) {
            console.log("message event listener", e);
            if ("string" == typeof e.data && -1 != e.data.indexOf("alookUpdateTheme")) {
                console.log("")
                S();
            }
        }, false);
        S();
    }
    console.log("主题脚本---结束");
})()