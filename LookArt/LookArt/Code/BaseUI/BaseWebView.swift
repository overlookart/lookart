//
//  BaseWebView.swift
//  DaoSample
//
//  Created by MoYing on 2020/11/21.
//

import UIKit
import WebKit

// MARK: - webview监听枚举
private enum WebObserve {
    case title
    case progress
    case canGoBack
    case canGoForward
    
    var keyStr: String {
        switch self {
        case .title: return "title"
        case .progress: return "estimatedProgress"
        case .canGoBack: return "canGoBack"
        case.canGoForward: return "canGoForward"
        }
    }
}

class BaseWebView: WKWebView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var webTitle: ((String) -> Void)?
    private var webProgress: ((Float) -> Void)?
    private var webCanGoBack: ((Bool) -> Void)?
    private var webCanGoForward: ((Bool) -> Void)?
    
    /// 网页标题的监听
    var webTitleObserve: (isObserve: Bool, webTitle: (String) -> Void)? {
        didSet {
            if webTitleObserve?.isObserve ?? false {
                if oldValue?.isObserve ?? false {
                    self.removeObserver(self, forKeyPath: WebObserve.title.keyStr)
                }
                print("添加webtitle的监听")
                self.addObserver(self, forKeyPath: WebObserve.title.keyStr, options: .new, context: nil)
            }else{
                if oldValue?.isObserve ?? false {
                    self.removeObserver(self, forKeyPath: WebObserve.title.keyStr)
                    print("移除webtitle的监听")
                }
            }
            webProgress = webProgressObserve?.webProgress
        }
    }
    
    /// 网页进度的监听
    var webProgressObserve: (isObserve: Bool, webProgress: (Float) -> Void)? {
        didSet {
            if webProgressObserve?.isObserve ?? false {
                if oldValue?.isObserve ?? false {
                    self.removeObserver(self, forKeyPath: WebObserve.progress.keyStr)
                }
                print("添加webProgress的监听")
                self.addObserver(self, forKeyPath: WebObserve.progress.keyStr, options: .new, context: nil)
            }else{
                if oldValue?.isObserve ?? false {
                    self.removeObserver(self, forKeyPath: WebObserve.progress.keyStr)
                    print("移除webProgress的监听")
                }
            }
            webProgress = webProgressObserve?.webProgress
        }
    }
    

    /// 网页可以返回的监听
    var webCanGoBackObserve: (isObserve: Bool, webCanGoBack: (Bool) -> Void)? {
        didSet {
            if webCanGoBackObserve?.isObserve ?? false {
                if oldValue?.isObserve ?? false {
                    self.removeObserver(self, forKeyPath: WebObserve.canGoBack.keyStr)
                }
                self.addObserver(self, forKeyPath: WebObserve.canGoBack.keyStr, options: .new, context: nil)
                print("添加webCanGoBack的监听")
            }else{
                if oldValue?.isObserve ?? false {
                    self.removeObserver(self, forKeyPath: WebObserve.canGoBack.keyStr)
                    print("移除webCanGoBack的监听")
                }
            }
            webCanGoBack = webCanGoBackObserve?.webCanGoBack
        }
    }
    
    /// 网页可以前进的监听
    var webCanGoForwardObserve: (isObserve: Bool, webCanGoForward: (Bool) -> Void)? {
        didSet {
            if webCanGoForwardObserve?.isObserve ?? false {
                if oldValue?.isObserve ?? false {
                    self.removeObserver(self, forKeyPath: WebObserve.canGoForward.keyStr)
                }
                self.addObserver(self, forKeyPath: WebObserve.canGoForward.keyStr, options: .new, context: nil)
                print("添加webGoForward的监听")
            }else{
                if oldValue?.isObserve ?? false {
                    self.removeObserver(self, forKeyPath: WebObserve.canGoForward.keyStr)
                    print("移除webGoForward的监听")
                }
            }
            webCanGoForward = webCanGoForwardObserve?.webCanGoForward
        }
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == WebObserve.progress.keyStr {
            if webProgress != nil {
                webProgress!(Float(self.estimatedProgress))
            }
        }else if keyPath == WebObserve.title.keyStr {
            if webTitle != nil {
                webTitle!(self.title ?? "Null")
            }
        }else if keyPath == WebObserve.canGoBack.keyStr {
            if webCanGoBack != nil {
                webCanGoBack!(self.canGoBack)
            }
        }else if keyPath == WebObserve.canGoForward.keyStr {
            if webCanGoForward != nil {
                webCanGoForward!(self.canGoForward)
            }
        }else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if webProgressObserve?.isObserve ?? false {
            self.removeObserver(self, forKeyPath: WebObserve.progress.keyStr)
        }
        
        if webTitleObserve?.isObserve ?? false {
            self.removeObserver(self, forKeyPath: WebObserve.title.keyStr)
        }
        
        if webCanGoBackObserve?.isObserve ?? false {
            self.removeObserver(self, forKeyPath: WebObserve.canGoBack.keyStr)
        }
        
        if webCanGoForwardObserve?.isObserve ?? false {
            self.removeObserver(self, forKeyPath: WebObserve.canGoForward.keyStr)
        }
    }
    
}




