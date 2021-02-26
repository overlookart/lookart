//
//  TabWebView.swift
//  LookArt
//
//  Created by xzh on 2021/2/12.
//

import UIKit
import WebKit
class TabWebView: BaseWebView {

    private let WebObserveTitle: String = "title"
    private let WebObserveProgress: String = "estimatedProgress"
    private let WebObserveBack: String = "canGoBack"
    private let WebObserveForward: String = "canGoForward"
    /// 开始拖动时的offset
    private(set) var scrollBeginDragOffset: CGPoint = CGPoint.zero
    /// 当前的offset
    private(set) var scrollContentOffset: CGPoint = CGPoint.zero
    /// 滑动代理
    var scrollDelegates: (DidScroll:(() -> Void)?, BeginDragging:(() -> Void)?, WillEndDragging:((CGPoint) -> Void)?, EndDragging:(() -> Void)?, BeginDecelerating:(() -> Void)?, EndDecelerating:(() -> Void)?)?
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    init(config: WebConfig) {
        super.init(frame: CGRect.zero, configuration: config)
        self.navigationDelegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TabWebView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollContentOffset = scrollView.contentOffset
        if let didScroll = self.scrollDelegates?.DidScroll {
            didScroll()
        }
    }
    
    /// 开始滑动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollBeginDragOffset = scrollView.contentOffset
        if let beginDragging = self.scrollDelegates?.BeginDragging {
            beginDragging()
        }
    }
    ///将要结束拖拽
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let willEndDragging = self.scrollDelegates?.WillEndDragging {
            willEndDragging(velocity)
        }
    }
    
    /// 结束拖拽
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let endDragging = self.scrollDelegates?.EndDragging {
            endDragging()
        }
    }
    /// 开始减速
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if let beginDecelerating = self.scrollDelegates?.BeginDecelerating {
            beginDecelerating()
        }
    }
    /// 停止减速
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let endDecelerating = self.scrollDelegates?.EndDecelerating {
            endDecelerating()
        }
    }
}

extension TabWebView: WKNavigationDelegate {
    
    /// Web是否允许导航
    /// - Parameters:
    ///   - webView: webView
    ///   - navigationAction: 有关触发导航请求的操作的描述性信息
    ///   - decisionHandler: Web决定是允许还是取消导航时要调用闭包
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("Web是否允许导航")
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Web开始加载内容")
    }
    
    /// Web收到响应后是否允许导航
    /// - Parameters:
    ///   - webView: webView
    ///   - navigationResponse: 有关导航响应的描述性信息
    ///   - decisionHandler: Web决定是允许还是取消导航时要调用闭包
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("Web收到响应后是否允许导航")
        decisionHandler(.allow)
    }
    
    /// Web开始接收内容 响应服务器操作
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: 开始加载页面的导航对象
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Web开始接收内容")
    }
    
    /// Web视图收到服务器重定向 响应服务器操作
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: 接收到服务器重定向的导航对象
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("Web视图收到服务器重定向")
    }
    
    /// Web需要响应身份验证
    /// - Parameters:
    ///   - webView: webView
    ///   - challenge: 身份验证
    ///   - completionHandler: <#completionHandler description#>
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("Web需要响应身份验证")
        completionHandler(.rejectProtectionSpace,nil)
    }
    
    /// Web加载完成
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: navigation
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Web加载完成")
    }
    
    /// Web导航期间发生错误
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: navigation
    ///   - error: error
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Web导航期间发生错误")
    }
    
    /// Web加载内容时发生错误
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: navigation
    ///   - error: error
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Web加载内容时发生错误")
    }
    
    /// Web内容终止
    /// - Parameter webView: webView
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("Web内容终止")
    }
}
