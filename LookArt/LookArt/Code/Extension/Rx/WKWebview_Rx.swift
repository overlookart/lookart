//
//  WKWebview_Rx.swift
//  LookArt
//
//  Created by xzh on 2021/4/22.
//

import Foundation
import RxSwift
import RxCocoa
import WebKit

/// WKWebView Observer Property 监听 wkwebview 属性
extension Reactive where Base: WKWebView {
    public var title: Observable<String> {
        self.observeWeakly(String.self, "title").map{$0 ?? ""}
    }
    
    public var loading: Observable<Bool> {
        self.observeWeakly(Bool.self, "loading").map{$0 ?? false}
    }
    
    public var progress: Observable<Float> {
        self.observeWeakly(Double.self, "estimatedProgress").map { Float($0 ?? 0.0) }
    }
    
    public var url: Observable<URL?> {
        self.observeWeakly(URL.self, "URL")
    }
    
    public var canGoBack: Observable<Bool> {
        self.observeWeakly(Bool.self, "canGoBack").map{ $0 ?? false}
    }
    
    public var canGoForward: Observable<Bool> {
        self.observeWeakly(Bool.self, "canGoForward").map { $0 ?? false }
    }
    
    public var serverTrust: Observable<SecTrust?> {
        self.observeWeakly(SecTrust.self, "serverTrust")
    }
    
    public var hasOnlySecureContent: Observable<Bool?> {
        self.observeWeakly(Bool.self, "hasOnlySecureContent")
    }
}


extension Reactive where Base: WKWebView {
    
    public typealias WKNavigationActionHandler = (WKNavigationActionPolicy) -> Void
    public typealias WKNavigationActionPolicyEvent = ( webView: WKWebView, action: WKNavigationAction, decisionHandler: WKNavigationActionHandler)
    var decidePolicyForNavigationAction: ControlEvent<WKNavigationActionPolicyEvent> {
        
        let event = navigationDelegate.methodInvoked(.decidePolicyNavigationAction).map { args -> WKNavigationActionPolicyEvent in
            let view = try castOrThrow(WKWebView.self, args[0])
            let action = try castOrThrow(WKNavigationAction.self, args[1])
            let closureObject = args[2] as AnyObject
            
            // block 与 closure 的转化
            typealias Block_ActionHandler = @convention(block) (WKNavigationActionPolicy) -> ()
            let actionHandler = unsafeBitCast(closureObject, to: Block_ActionHandler.self)
            return (view, action, actionHandler)
        }
        return ControlEvent(events: event)
    }
    
    public typealias WKNavigationResponseHandler = (WKNavigationResponsePolicy) -> Void
    public typealias WKNavigationResponsePolicyEvent = ( webView: WKWebView, reponse: WKNavigationResponse, decisionHandler: WKNavigationResponseHandler)
    var decidePolicyForNavigationResponse:ControlEvent<WKNavigationResponsePolicyEvent>{
        let event = navigationDelegate.methodInvoked(.decidePolicyForNavigationResponse).map { (args) -> WKNavigationResponsePolicyEvent in
            let view = try castOrThrow(WKWebView.self, args[0])
            let navigationResponse = try castOrThrow(WKNavigationResponse.self, args[1])
            let closureObject = args[2] as AnyObject
            typealias Block_Handler = @convention(block) (WKNavigationResponsePolicy) -> ()
            let handler = unsafeBitCast(closureObject, to: Block_Handler.self)
            return (view, navigationResponse, handler)
        }
        return ControlEvent(events: event)
    }
    
    public var didReceiveServerRedirect: Observable<WKNavigation> {
        navigationDelegate.methodInvoked(#selector(WKNavigationDelegate.webView(_:didReceiveServerRedirectForProvisionalNavigation:))).map{ a in try castOrThrow(WKNavigation.self, a[1])}
    }
    
    public typealias ChallengeHandler = (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    public typealias WKNavigationChallengeEvent = (webView: WKWebView, challenge: URLAuthenticationChallenge, handler: ChallengeHandler)
    var didReceiveChallenge: ControlEvent<WKNavigationChallengeEvent> {
        let event = navigationDelegate.methodInvoked(.didReceiveChallenge).map { (args) -> WKNavigationChallengeEvent in
            let view = try castOrThrow(WKWebView.self, args[0])
            let challenge = try castOrThrow(URLAuthenticationChallenge.self, args[1])
            let closureObject = args[2] as AnyObject
            typealias Block_Handler =  @convention(block) (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
            let handler = unsafeBitCast(closureObject, to: Block_Handler.self)
            return (view, challenge, handler)
        }
        return ControlEvent(events: event)
    }
    
    
    public var didFailProvisional: Observable<(WKNavigation, Error)> {
        navigationDelegate.methodInvoked(#selector(WKNavigationDelegate.webView(_:didFailProvisionalNavigation:withError:))).map{ a in
            (
                try castOrThrow(WKNavigation.self, a[1]),
                try castOrThrow(Error.self, a[2])
            )
        }
    }
    
    public var didTerminate: Observable<WKWebView> {
        navigationDelegate.methodInvoked(#selector(WKNavigationDelegate.webViewWebContentProcessDidTerminate(_:))).map{ a in
            try castOrThrow(WKWebView.self, a[0])
        }
    }
    
    
    
    
}

// 扩展 Selector 支持 WKNavigationDelegate 的方法
extension Selector {
#if swift(>=5.7)
    static let decidePolicyNavigationAction = #selector(WKNavigationDelegate.webView(_:decidePolicyFor:decisionHandler:) as (WKNavigationDelegate) -> ((WKWebView, WKNavigationAction, @escaping(WKNavigationActionPolicy) -> Void) -> Void)?)
    static let decidePolicyForNavigationResponse = #selector(WKNavigationDelegate.webView(_: decidePolicyFor: decisionHandler:) as (WKNavigationDelegate) -> ((WKWebView, WKNavigationResponse, @escaping(WKNavigationResponsePolicy) -> Void) -> Void)?)
#else
    static let decidePolicyNavigationAction = #selector(WKNavigationDelegate.webView(_: decidePolicyFor: decisionHandler:) as ((WKNavigationDelegate) -> (WKWebView, WKNavigationAction, @escaping(WKNavigationActionPolicy) -> Void) -> Void)?)
    static let decidePolicyForNavigationResponse = #selector(WKNavigationDelegate.webView(_:decidePolicyFor:decisionHandler:) as ((WKNavigationDelegate) -> (WKWebView, WKNavigationResponse, @escaping(WKNavigationResponsePolicy) -> Void) -> Void)?)
#endif
    
    static let didReceiveChallenge = #selector(WKNavigationDelegate.webView(_:didReceive:completionHandler:))
    
}
