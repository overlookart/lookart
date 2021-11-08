//
//  TabWebView.swift
//  LookArt
//
//  Created by xzh on 2021/2/12.
//

import UIKit
import WebKit
class TabWebView: BaseWebView {
    //配置组件
    private(set) var configComponent: WebConfigComponent
    //脚本组件
    private(set) var scriptComponent: WebScriptComponent?
    
    /// 开始拖动时的offset
    private(set) var scrollBeginDragOffset: CGPoint = CGPoint.zero
    /// 当前的offset
    private(set) var scrollContentOffset: CGPoint = CGPoint.zero
    /// 滑动代理
    var scrollDelegates: (
        DidScroll:(() -> Void)?,
        BeginDragging:(() -> Void)?,
        WillEndDragging:((CGPoint) -> Void)?,
        EndDragging:(() -> Void)?,
        BeginDecelerating:(() -> Void)?,
        EndDecelerating:(() -> Void)?)?
    
    /// web导航代理毁掉
    var navigationDelegates: (
        DecidePolicyNavigationAction:((WKNavigationAction) -> WKNavigationActionPolicy)?,
        DidStartNavigation:((WKNavigation) -> Void)?,
        DecidePolicyNavigationResponse:((WKNavigationResponse) -> WKNavigationResponsePolicy)?,
        DidCommitNavigation:((WKNavigation) -> Void)?,
        DidReceiveServerRedirect:((WKNavigation) -> Void)?,
        DidReceiveAuthChallenge:(() -> (AuthChallenge:URLSession.AuthChallengeDisposition,Credential:URLCredential?))?,
        DidFinishNavigation:((WKNavigation) -> Void)?,
        DidFailNavigation:((WKNavigation, Error) -> Void)?,
        DidFailProvisional:((WKNavigation, Error) -> Void)?,
        DidTerminate:(() -> Void)?)?{
        
        didSet {
            if navigationDelegates != nil {
                self.navigationDelegate = self
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    /// 初始化方法
    /// - Parameters:
    ///   - config: 配置组件
    ///   - script: 脚本组件
    init(config: WebConfigComponent, script: WebScriptComponent? = nil) {
        self.configComponent = config
        self.scriptComponent = script
        super.init(frame: CGRect.zero, configuration: config)
        if let _ = self.scriptComponent {
            //config script
            self.scriptComponent?.scripts.append(LAUserScript(fileName: "test_1", injectionTime: .atDocumentStart, forMainFrameOnly: false, messageName: "lookArt"))
            self.scriptComponent?.setupScripts(userContentController: self.configComponent.userContentController)
        }
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
        guard let decidePolicy = navigationDelegates?.DecidePolicyNavigationAction else { decisionHandler(.allow); return }
        decisionHandler(decidePolicy(navigationAction))
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Web开始加载内容")
        guard let didStart = navigationDelegates?.DidStartNavigation else { return }
        didStart(navigation)
    }
    
    /// Web收到响应后是否允许导航
    /// - Parameters:
    ///   - webView: webView
    ///   - navigationResponse: 有关导航响应的描述性信息
    ///   - decisionHandler: Web决定是允许还是取消导航时要调用闭包
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("Web收到响应后是否允许导航")
        guard let decidePolicy = navigationDelegates?.DecidePolicyNavigationResponse else { decisionHandler(.allow); return }
        decisionHandler(decidePolicy(navigationResponse))
    }
    
    /// Web开始接收内容 响应服务器操作
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: 开始加载页面的导航对象
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Web开始接收内容")
        guard let didcommit = navigationDelegates?.DidCommitNavigation else { return }
        didcommit(navigation)
    }
    
    /// Web视图收到服务器重定向 响应服务器操作
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: 接收到服务器重定向的导航对象
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("Web视图收到服务器重定向")
        guard let didReceiveServerRedirect = navigationDelegates?.DidReceiveServerRedirect else { return }
        didReceiveServerRedirect(navigation)
    }
    
    /// Web需要响应身份验证
    /// - Parameters:
    ///   - webView: webView
    ///   - challenge: 身份验证
    ///   - completionHandler: <#completionHandler description#>
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("Web需要响应身份验证")
        guard let didReceiveAuthChallenge = navigationDelegates?.DidReceiveAuthChallenge else { completionHandler(.rejectProtectionSpace,nil); return }
        let handler = didReceiveAuthChallenge()
        completionHandler(handler.AuthChallenge,handler.Credential)
    }
    
    /// Web加载完成
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: navigation
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Web加载完成")
        guard let didfinish = navigationDelegates?.DidFinishNavigation else { return }
        didfinish(navigation)
    }
    
    /// Web导航期间发生错误
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: navigation
    ///   - error: error
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Web导航期间发生错误")
        guard let didfail = navigationDelegates?.DidFailNavigation else { return }
        didfail(navigation, error)
    }
    
    /// Web加载内容时发生错误
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: navigation
    ///   - error: error
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Web加载内容时发生错误")
        guard let didfail = navigationDelegates?.DidFailProvisional else { return }
        didfail(navigation, error)
    }
    
    /// Web内容终止
    /// - Parameter webView: webView
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("Web内容终止")
        guard let didTerminate = navigationDelegates?.DidTerminate else { return }
        didTerminate()
    }
}


extension TabWebView: WKUIDelegate {
    
    //MARK: - 创建/关闭 webview
    
    /// 创建 webview
    /// - Parameters:
    ///   - webView: 调用委托方法的 WebView
    ///   - configuration: 创建新 Webview 时要使用的配置
    ///   - navigationAction: 导致创建新 Webview 的导航操作
    ///   - windowFeatures: 网页请求的窗口功能
    /// - Returns: 必须使用指定的配置创建返回的 Web 视图 WebKit 在返回的 Web 视图中加载请求
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        print("创建 webview")
        return nil
    }
    
    /// 通知您的应用 DOM 窗口已成功关闭
    /// - Parameter webView: 调用委托方法的 WebView
    /// 您的应用程序应该从视图层次结构中删除 Web 视图并根据需要更新 UI
    /// 例如通过关闭包含的浏览器选项卡或窗口
    func webViewDidClose(_ webView: WKWebView) {
        
    }
    
    //MARK: - 显示UI
    /**
     Web 视图用户界面委托实现此协议以控制新窗口的打开，
     增强用户单击元素时显示的默认菜单项的行为，
     并执行其他与用户界面相关的任务。
     这些方法可以作为处理 JavaScript 或其他插件内容的结果被调用。
     默认的 Web 视图实现假设每个 Web 视图有一个窗口，
     因此非常规用户界面可能会实现用户界面委托
     */
    /// 显示包含指定消息的 JavaScript 警报面板
    /// - Parameters:
    ///   - webView: 调用委托方法的 WebView
    ///   - message: 要显示的消息
    ///   - frame: 有关其 JavaScript 进程发起此调用的框架的信息
    ///   - completionHandler: 关闭警报面板后调用的完成处理程序
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }
    
    /// 显示带有指定消息的 JavaScript 确认面板
    /// - Parameters:
    ///   - webView: 调用委托方法的 WebView
    ///   - message: 在确认面板中显示的消息
    ///   - frame: 其 JavaScript 发起此调用的 Web 框架
    ///   - completionHandler: 在确认面板被解除后调用的完成处理程序。 如果用户选择 OK 则传递 true，如果用户选择 Cancel 则传递 false
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
    }
    
    /// 显示 JavaScript 文本输入面板
    /// - Parameters:
    ///   - webView: 调用委托方法的 WebView
    ///   - prompt: 要显示的消息
    ///   - defaultText: 要在文本输入字段中显示的初始文本
    ///   - frame: 有关其 JavaScript 进程发起此调用的框架的信息
    ///   - completionHandler: 在文本输入面板被关闭后调用的完成处理程序。 如果用户选择 OK，则传递输入的文本，否则 nil
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
    }
    
//    @available(iOS 15.0.0, *)
//    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo) async {
//
//    }
}
