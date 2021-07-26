/** lookart script */


//代码规范
//1.命名空间(namespace)
//把变量放到匿名立即执行函数里，让变量锁死在函数作用域里
(function() {
    if (window.lookArt) {
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
                enabled: false
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
    function o(){
        try {
            return window.self === window.top;
        } catch (e) {
            return false
        }
    }
    window.lookArt.isNightMode = false
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

    // 匹配透明颜色
    var rgba_0_Regex = /rgba\(\s*?\d+?\s*?,\s*?\d+?\s*?,\s*?\d+?\s*?,\s*?0\s*?\)/i;
    // 匹配 rgb 值为200以上的颜色
    var rgb_200_regex = /rgb\(\s*?2\d{2}\s*?,\s*?2\d{2}\s*?,\s*?2\d{2}\s*?\)/i;
    // 匹配 rgb 值为160以上的颜色
    var rgb_160_regex = /rgb\(\s*?1(6|7|8|9)\d\s*?,\s*?1(6|7|8|9)\d\s*?,\s*?1(6|7|8|9)\d\s*?\)/i;
    // 匹配 rgb 值为255 白色
    var rgba_255_regex = /rgba\(\s*?255\s*?\,\s*?255\s*?\,\s*?255\s*?\,/i;
    // 匹配颜色关键词
    var color_key_regex = /rgb|-webkit-gradient/i;
    // 0.8倍的窗口宽度
    var width_08 = .8 * window.innerWidth;
    // 匹配标签 CANVAS, IMG, IFRAME, BR, SCRIPT, NOSCRIPT, STYLE, META, LINK, TITLE
    var tag_key = /\bCANVAS\b|\bIMG\b|\bIFRAME\b|\bBR\b|\bSCRIPT\b|\bNOSCRIPT\b|\bSTYLE\b|\bMETA\b|\bLINK\b|\bTITLE\b/;
    //
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
    var t = null;
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
        if (n && n.parentNode) {
            n.parentNode.removeChild(n)
        }
    }

    /**
     * 为 t 设置样式属性
     */
    function N() {
        if (t) {
            var e = "[TakeTheme][TakeNightModeTransBg]{background-color: transparent !important}.black_border{border: 1px solid rgba(0, 0, 0,0.2)}#bg_sheep{background-image: none !important}#bg_cow{background-image: none !important}[TakeTheme][TakeNightDarkBgImage]{filter: brightness(62%)!important}[TakeTheme][TakeNightModeReplaceBgColor]{background:#212121!important}[TakeTheme][TakeNightModeReplaceBgColorLight]{background:#181818!important}[TakeTheme][TakeNightModeBackground]{background:#212121!important;color:#868686!important}[TakeTheme][TakeNightModeReplaceBgLinear]{background:rgba(40,40,40,.6)!important}[TakeTheme][TakeNightModeReplaceBorder]{border-color:#45484c!important}:not([TakeTheme]){border-color:#212121!important;background-color:#212121!important}*{text-shadow:none!important;box-shadow:none!important}:after,:before{-webkit-filter:brightness(0.4)}body,html{background:#212121!important;color:#868686!important}abbr,address,article,aside,b,bdi,bdo,blockquote,br,caption,cite,code,col,colgroup,data,datalist,dc,dd,dfn,dl,dt,em,fieldset,figcaption,figure,footer,form,h1,h2,h3,h4,h5,h6,header,hr,i,kbd,keygen,label,legend,li,main,mark,meter,nav,ol,optgroup,option,output,p,pre,progress,q,rp,rt,ruby,s,samp,section,small,span,strong,sub,sup,table,tbody,td,textarea,tfoot,th,thead,time,tr,u,ul,var,wbr{background-color:none;color:#868686!important}textarea{background-color:#212121!important}div,div[TakeTheme]{color:#868686!important}[TakeTheme]{color:#868686!important}a,a *,a[TakeTheme]{color:#6d97d5 !important}a[TakeTheme]:visited,a[TakeTheme]:visited [TakeTheme],a[TakeTheme]:visited div[TakeTheme],a:visited,a:visited *{color:#bd8cff!important}button:not([TakeNightModeTransBg]):not([TakeTheme]),div:not([TakeNightModeTransBg]):not([TakeTheme]),input:not([TakeNightModeTransBg]):not([TakeTheme]),select:not([TakeNightModeTransBg]):not([TakeTheme]){background:#212121!important}button[TakeThemeActionDone]:not([TakeNightModeTransBg]):not([TakeNightModeReplaceBgLinear]):not([TakeNightModeBackground]),div[TakeThemeActionDone]:not([TakeNightModeTransBg]):not([TakeNightModeReplaceBgLinear]):not([TakeNightModeBackground]),input[TakeThemeActionDone]:not([TakeNightModeTransBg]):not([TakeNightModeReplaceBgLinear]):not([TakeNightModeBackground]),select[TakeThemeActionDone]:not([TakeNightModeTransBg]):not([TakeNightModeReplaceBgLinear]):not([TakeNightModeBackground]){background-color:#212121!important}input[type=date],input[type=date] *,input[type=datetime-local],input[type=datetime-local] *,input[type=month],input[type=month] *,input[type=time],input[type=time] *,select,select *{color:#fff!important}button,input:not([type=button]):not([type=submit]):not([type=reset]):not([type=image]):not([type=file]):not([type=date]):not([type=datetime-local]):not([type=month]):not([type=time]),input[type=button],input[type=file],input[type=image],input[type=reset],input[type=submit]{color:#FFFFFF!important;border-color:#45484c!important}";
            if(r){
                e = k(e, "212121", c ? "000000" : "121212");
                e = k(e, "868686", "b0b0b0");
                e = k(e, "486599", "6d97d5");
                e = k(e, "181818", "212121");
            }else{
                e = 'input[type="image"]{filter: brightness(62%)!important}img{filter: brightness(62%)!important}' + e;
            }
            t.innerText = e;
        }
    }

    function M(e) {
        if (e.target && "take_theme_id" == e.target.id) {
            setTimeout(function(){
                if("Night" == currentThemeName){
                    var p = document.head ? document.head : document.documentElement;
                    p.appendChild(t);
                }
            }, 1)
        }
    }

    /**
     * 清空元素背景色 (D)
     * @param {*} e 
     */
    function clearElementBGColor(element) {
        if (element) {
            element.style.backgroundColor = null;
        }
    }

    function e(e) {
        function t() {
            if (window.lookArt.isNightMode) {
                f("Night");
            }else{
                f(isGreen ? "Green" : "Normal")
            }
        }
        (function(e){
            var t = document.getElementsByTagName("html");
            var o = null;
            if (t && t.length > 0, e) {
                o = t[0];
                clearElementBGColor(o);
                clearElementBGColor(document.body);
                //-------- x() 
            }else if (isGreen){
                var n;
                //--------- x()
            }
        })()
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

    /**
     * 
     * @param {String} themeName 主题名称
     */
    function f(themeName) {
        width_08 = .8 * window.innerWidth;
        if (currentThemeName != themeName) {
            y();
            if(t == null){
                t = document.createElement("style");
                t.id = "take_theme_id";
                N();
                (function(){
                    var e = document.head ? document.head : document.documentElement;
                    e.appendChild(t);
                    e.addEventListener("DOMNodeRemoved", M, false);
                })();

            }
        }else{

        }
    }
})()