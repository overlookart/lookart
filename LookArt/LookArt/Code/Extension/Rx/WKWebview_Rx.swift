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
    public var title: Observable<String?> {
        return self.observeWeakly(String.self, "title")
    }
    
    public var loading: Observable<Bool> {
        return self.observeWeakly(Bool.self, "loading").map{$0 ?? false}
    }
    
    public var progress: Observable<Float> {
        return self.observeWeakly(Double.self, "estimatedProgress").map { Float($0 ?? 0.0) }
    }
    
    public var url: Observable<URL?> {
        return self.observeWeakly(URL.self, "URL")
    }
    
    public var canGoBack: Observable<Bool> {
        return self.observeWeakly(Bool.self, "canGoBack").map{ $0 ?? false}
    }
    
    public var canGoForward: Observable<Bool> {
        return self.observeWeakly(Bool.self, "canGoForward").map { $0 ?? false }
    }
    public var backItemList: ControlProperty<[WKBackForwardListItem]?> {
        backForwardList
    }
    public var backForwardList: ControlProperty<[WKBackForwardListItem]> {
        return base.rx.controlPropertyWithDefaultEvents{
            
        }
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
            
//            var mutableArgs = args
//            mutableArgs.withUnsafeMutableBufferPointer { ptr in
//                closureObject = ptr[2] as AnyObject
//
//            }
//            let __actionBlockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(closureObject).toOpaque())
            
            // block 与 closure 的转化
            typealias Block_ActionHandler = @convention(block) (WKNavigationActionPolicy) -> ()
            let actionHandler = unsafeBitCast(closureObject, to: Block_ActionHandler.self)
            return (view, action, actionHandler)
        }
        return ControlEvent(events: event)
    }
    
    public typealias WKNavigationEvent = (webView: WKWebView, navigation: WKNavigation)
    var didStartProvisionalNavigation:ControlEvent<WKNavigationEvent> {
        let event = navigationDelegate.methodInvoked(.didStartProvisionalNavigation).map { (args) -> WKNavigationEvent in
            let view = try castOrThrow(WKWebView.self, args[0])
            let navigation = try castOrThrow(WKNavigation.self, args[1])
            return (view, navigation)
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
    
    
    var didCommitNavigation: ControlEvent<WKNavigationEvent> {
        let event = navigationDelegate.methodInvoked(.didCommitNavigation).map { (args) -> WKNavigationEvent in
            let view = try castOrThrow(WKWebView.self, args[0])
            let navigation = try castOrThrow(WKNavigation.self, args[1])
            return (view, navigation)
        }
        return ControlEvent(events: event)
    }
    
    var didReceiveServerRedirect: ControlEvent<WKNavigationEvent> {
        let event = navigationDelegate.methodInvoked(.didReceiveServerRedirect).map { (args) -> WKNavigationEvent in
            let view = try castOrThrow(WKWebView.self, args[0])
            let navigation = try castOrThrow(WKNavigation.self, args[1])
            return (view, navigation)
        }
        return ControlEvent(events: event)
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
    
    var didFinishNavigation: ControlEvent<WKNavigationEvent> {
        let event = navigationDelegate.methodInvoked(.didFinishNavigation).map { (args) -> WKNavigationEvent in
            let view = try castOrThrow(WKWebView.self, args[0])
            let navigation = try castOrThrow(WKNavigation.self, args[1])
            return (view, navigation)
        }
        return ControlEvent(events: event)
    }
    
    
    public typealias WKNavigationFailEvent = (webView: WKWebView, navigation: WKNavigation, error: Error)
    
    var didFailNavigation: ControlEvent<WKNavigationFailEvent> {
        let event = navigationDelegate.methodInvoked(.didFailNavigation).map { (args) -> WKNavigationFailEvent in
            let view = try castOrThrow(WKWebView.self, args[0])
            let navigation = try castOrThrow(WKNavigation.self, args[1])
            let err = try castOrThrow(Error.self, args[2])
            return (view, navigation, err)
        }
        return ControlEvent(events: event)
    }
    
    var didFailProvisionalNavigation: ControlEvent<WKNavigationFailEvent> {
        let event = navigationDelegate.methodInvoked(.didFailProvisionalNavigation).map { (args) -> WKNavigationFailEvent in
            let view = try castOrThrow(WKWebView.self, args[0])
            let navigation = try castOrThrow(WKNavigation.self, args[1])
            let err = try castOrThrow(Error.self, args[2])
            return (view, navigation, err)
        }
        return ControlEvent(events: event)
    }
    
    var didTerminateContentProcess: ControlEvent<WKWebView> {
        let event = navigationDelegate.methodInvoked(.didTerminateContentProcess).map { (args) -> WKWebView in
            let view = try castOrThrow(WKWebView.self, args[0])
            return view
        }
        return ControlEvent(events: event)
    }
    
    
    
    
}

extension Selector {
    static let decidePolicyNavigationAction = #selector(WKNavigationDelegate.webView(_:decidePolicyFor:decisionHandler:) as ((WKNavigationDelegate) -> (WKWebView, WKNavigationAction, @escaping(WKNavigationActionPolicy) -> Void) -> Void)?)
    
    static let didStartProvisionalNavigation = #selector(WKNavigationDelegate.webView(_:didStartProvisionalNavigation:))
    
    static let decidePolicyForNavigationResponse = #selector(WKNavigationDelegate.webView(_:decidePolicyFor:decisionHandler:) as ((WKNavigationDelegate) -> (WKWebView, WKNavigationResponse, @escaping(WKNavigationResponsePolicy) -> Void) -> Void)?)
    
    static let didCommitNavigation = #selector(WKNavigationDelegate.webView(_:didCommit:))
    
    static let didReceiveServerRedirect = #selector(WKNavigationDelegate.webView(_:didReceiveServerRedirectForProvisionalNavigation:))
    
    static let didReceiveChallenge = #selector(WKNavigationDelegate.webView(_:didReceive:completionHandler:))
    
    static let didFinishNavigation = #selector(WKNavigationDelegate.webView(_:didFinish:))
    
    static let didFailNavigation = #selector(WKNavigationDelegate.webView(_:didFail:withError:))
    
    static let didFailProvisionalNavigation = #selector(WKNavigationDelegate.webView(_:didFailProvisionalNavigation:withError:))
    
    static let didTerminateContentProcess = #selector(WKNavigationDelegate.webViewWebContentProcessDidTerminate(_:))
}
