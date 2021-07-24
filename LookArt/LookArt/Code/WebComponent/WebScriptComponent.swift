//
//  WebScriptComponent.swift
//  LookArt
//
//  Created by xzh on 2021/7/24.
//

import Foundation
import WebKit
class WebScriptComponent: NSObject {
    var scripts: [LAUserScript] = []
    
    func setupScripts(userContentController: WKUserContentController) {
        for script in scripts {
            userContentController.addUserScript(script)
            if let messageName = script.messageName {
                userContentController.removeScriptMessageHandler(forName: messageName)
                userContentController.add(self, name: messageName)
            }
        }
    }
}

// js window.webkit.messageHandlers.xxx.postMessage() 调用
extension WebScriptComponent: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name, message.body)
    }
}

// js alert, input,  UI 调用
extension WebScriptComponent: WKUIDelegate {
    
}

class LAUserScript: WKUserScript {
    // 脚本名称
    var scriptName: String?
    // js 发送 messageHandlers 的名称
    var messageName: String?
    
    ///
    /// - Parameters: 初始化脚本方法
    ///   - source: 源代码
    ///   - injectionTime: 注入时机
    ///   - forMainFrameOnly: 是否仅在主 frame 启用
    ///   - messageName: js 发送 messageHandlers 的名称
    init(source: String, injectionTime: WKUserScriptInjectionTime, forMainFrameOnly: Bool, messageName: String? = nil) {
        super.init(source: source, injectionTime: injectionTime, forMainFrameOnly: forMainFrameOnly)
        self.messageName = messageName
    }
    
    /// 初始化脚本方法
    /// - Parameters:
    ///   - fileName: js 脚本文件名
    ///   - injectionTime: 注入时机
    ///   - forMainFrameOnly: 是否仅在主 frame 启用
    ///   - messageName: js 发送 messageHandlers 的名称
    init(fileName: String, injectionTime: WKUserScriptInjectionTime, forMainFrameOnly: Bool, messageName: String? = nil) {
        let source = UIApplication.loadLocalFile(Name: fileName, Format: "js") ?? ""
        super.init(source: source, injectionTime: injectionTime, forMainFrameOnly: forMainFrameOnly)
        self.messageName = messageName
    }
    
    @available(iOS 14.0, *)
    override init(source: String, injectionTime: WKUserScriptInjectionTime, forMainFrameOnly: Bool, in contentWorld: WKContentWorld) {
        super.init(source: source, injectionTime: injectionTime, forMainFrameOnly: forMainFrameOnly, in: contentWorld)
    }
}

// 脚本协议
protocol WebScriptProtocol {
    //1. 必须要有脚本String
    var scriptStr: String {get}
    //2. 必须要有脚本的全局变量
    
    //3. 必须要有脚本的消息名称
    var messageName: String? {get}
    //4. 脚本的全局变量函数
}


