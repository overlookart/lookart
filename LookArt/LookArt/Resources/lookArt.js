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