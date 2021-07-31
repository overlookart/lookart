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

  `listener` 事件处理方法

  `useCapture` 事件传递方式 ture捕获阶段调用, false冒泡阶段调用 默认false
  
* removeEventListener(type, listener, useCapture) 移除事件监听
  
    `type` 事件类型字符串

    `listener` 要移除的事件处理方法

    `useCapture` 要移除的传递方式 默认false 

* dispatchEvent(event) 向一个指定的事件目标派发事件