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
    
    var decidePolicyAction: Observable<(WKNavigationAction, (WKNavigationActionPolicy) -> Void)>{
        navigationDelegate.methodInvoked(.decidePolicyNavigationAction).map{ a in
            let action = try castOrThrow(WKNavigationAction.self, a[1])
            typealias block = @convention(block) (WKNavigationActionPolicy) -> Void
            let handler = unsafeBitCast(a[2] as AnyObject, to: block.self)
            return (action, handler)
        }
    }
    
    public var decidePolicyResponse: Observable<(WKNavigationResponse, (WKNavigationResponsePolicy) -> ())>{
        navigationDelegate.methodInvoked(.decidePolicyForNavigationResponse).map{ args in
            let response = try castOrThrow(WKNavigationResponse.self, args[1])
            typealias block = @convention(block) (WKNavigationResponsePolicy) -> ()
            let handler = unsafeBitCast(args[2] as AnyObject, to: block.self)
            return (response, handler)
        }
    }
    
    public var didReceiveServerRedirect: Observable<WKNavigation> {
        navigationDelegate.methodInvoked(#selector(WKNavigationDelegate.webView(_:didReceiveServerRedirectForProvisionalNavigation:))).map{ a in try castOrThrow(WKNavigation.self, a[1])}
    }
    
    public var didReceive: Observable<(URLAuthenticationChallenge, (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)> {
        navigationDelegate.methodInvoked(#selector(WKNavigationDelegate.webView(_:didReceive:completionHandler:))).map{ a in
            let challenge = try castOrThrow(URLAuthenticationChallenge.self, a[1])
            typealias block =  @convention(block) (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
            let handler = unsafeBitCast(a[2] as AnyObject, to: block.self)
            return (challenge, handler)
        }
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
    
}
