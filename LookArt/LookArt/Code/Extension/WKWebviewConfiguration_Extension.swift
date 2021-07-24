//
//  WKWebviewConfiguration_Extension.swift
//  DaoSample
//
//  Created by xzh on 2021/1/18.
//

import Foundation
import WebKit


// MARK: - WKUserContentController
// WKUserContentController对象为JavaScript提供了一种发布消息并将用户脚本注入Web视图的方法。
extension WKWebViewConfiguration {
    /// 添加脚本消息处理
    /// - Parameters:
    ///   - handler: 消息处理
    ///   - name: 脚本消息名称
    func addScriptMessageHandler(_ handler: WKScriptMessageHandler, name: String) {
        userContentController.removeScriptMessageHandler(forName: name)
        userContentController.add(handler, name: name)
    }
    
    /// 添加用户脚本
    /// - Parameters:
    ///   - script: js脚本
    ///   - injectionTime: 注入时间
    ///   - forMainFrameOnly: 是否仅在主Document注入
    ///   - world: 关键词
    func addUserScript(script: String, injectionTime: WKUserScriptInjectionTime, forMainFrameOnly: Bool, world: String? = nil) {
        let userScript = WKUserScript(source: script, injectionTime: injectionTime, forMainFrameOnly: forMainFrameOnly)
        addUserScript(script: userScript)
    }
    
    /// 添加用户脚本
    /// - Parameters:
    ///   - fileName: js脚本文件名
    ///   - injectionTime: 注入时间
    ///   - forMainFrameOnly: 是否仅在主Document注入
    ///   - world: 关键词
    func addUserScript(fileName: String, injectionTime: WKUserScriptInjectionTime, forMainFrameOnly: Bool, world: String? = nil) {
        if let userScript = WKUserScript.localUserScript(fileName: fileName) {
            addUserScript(script: userScript)
        }else{
            print("添加脚本失败：\(fileName)")
        }
    }
    
    func addUserScript(script: WKUserScript?) {
        if let s = script {
            userContentController.addUserScript(s)
        }else{
            print("添加脚本失败")
        }
        
    }
    
    /// 移除所有的用户脚本
    func removeAllUserScript() {
        if userContentController.userScripts.count > 0 {
            userContentController.removeAllUserScripts()
        }
    }
    
    /// 添加用户过滤规则
    @available(iOS 11.0, *)
    func addUserRule(rulelist: WKContentRuleList) {
        userContentController.add(rulelist)
    }
    
    /// 移除用户过滤规则
    @available(iOS 11.0, *)
    func removeUserRule(rulelist: WKContentRuleList) {
        userContentController.remove(rulelist)
    }
}
