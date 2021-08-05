# Document 加载状态

`document.readyState` 属性描述了 `document` 的加载状态

当该属性发生变时，`document` 对象触发 `readystatechange` 事件

## 状态值
* loading(正在加载) document 文档处于正在加载的状态

* interactive(可交互) 文档和所有子资源已加载完成,结束正在加载状态,DOM元素可以被访问,但图像,样式表,和框架等资源还在加载

* complete(完成) 页面所有内容加载完成 `load` 状态事件即将被触发



---

# Document 事件监听

`EventTarget` 是一个DOM接口, 可以接收事件, 可以创建监听器

`Element` `document` `window` 是最常见的 eventTarget, `XMLHttpRequest` `AudioNode` `AudioContext` 等也可以作为 eventTarget

## 方法

* addEventListener(type, listener, useCapture) 添加事件监听
  
  `type` 事件类型字符串

  `listener` 事件处理方法 参数 event, event.target 触发此事件的元素(事件的目标节点) 

  `useCapture` 事件传递方式 ture捕获阶段调用, false冒泡阶段调用 默认false
  
* removeEventListener(type, listener, useCapture) 移除事件监听
  
    `type` 事件类型字符串

    `listener` 要移除的事件处理方法

    `useCapture` 要移除的传递方式 默认false 

* dispatchEvent(event) 向一个指定的事件目标派发事件
  
---
# window 定时器

`setTimeOut(function|code, delay, arg1, ..., argN)` 为window设置定时器, 在计时结束后执行一个函数或指定的代码

`function|code` 计时之后执行的函数或一段代码

`delay` 延迟的毫秒 (1秒==1000毫秒)

`arg1, ..., argN` 传递给 function 的参数

`clearTimeout(timeoutID)` 取消 window设置的定时器

---
# DOM Node 节点

`Node` 对象代表文档树中的一个单独节点

## nodeType 节点类型

`Node.ELEMENT_NODE` 一个元素节点 如\<p>, \<div>

`Node.TEXT_NODE` Element 或者 Attr 中实际的  文字

`Node.CDATA_SECTION_NODE` 一个 CDATASection，例如 <!CDATA[[ … ]]>

`Node.PROCESSING_INSTRUCTION_NODE` 一个用于XML文档的 ProcessingInstruction (en-US) ，例如 <?xml-stylesheet ... ?> 声明。

`Node.COMMENT_NODE` 一个 Comment 节点

`Node.DOCUMENT_NODE` 一个 Document 节点

`Node.DOCUMENT_TYPE_NODE` 描述文档类型的 DocumentType 节点。例如 <!DOCTYPE html>  就是用于 HTML5 的

`Node.DOCUMENT_FRAGMENT_NODE` 一个 DocumentFragment 节点


