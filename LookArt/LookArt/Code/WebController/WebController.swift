//
//  WebController.swift
//  LookArt
//
//  Created by xzh on 2021/2/12.
//

import UIKit
import WebKit
import RxSwift
class WebController: BaseViewController {
    let disposeBag = DisposeBag()
    
//    let searchBar: SearchBar = SearchBar()
    
    let web: TabWebView = TabWebView(config: WebConfigComponent(), script: WebScriptComponent(), webUI: WebUIComponent())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //显示导航栏
        self.setNavigationBarVisible(Visible: true)
        //显示工具栏
        self.setToolBarVisible(Visible: true)
//        self.hidesBarsOnTap(Hide: true)
        //滑动时显示隐藏
        self.hidesBarsOnSwipe(Hide: true)
        view.addSubview(self.web)
        web.snp.makeConstraints { (make) in
            make.trailing.equalTo(0)
            make.leading.equalTo(0)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        let favo = PersonalFavoritesController()
        addChild(favo)
        view.addSubview(favo.view)
        favo.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.web.snp.top).offset(7)
            make.leading.equalTo(self.web.snp.leading)
            make.trailing.equalTo(self.web.snp.trailing)
            make.bottom.equalTo(self.web.snp.bottom)
        }
        
        favo.openWebSiteAction = { urlStr in
            favo.removeFromParent()
            favo.view.removeFromSuperview()
            
            self.web.loadweb(urlStr: urlStr)
        }
        
    
        self.definesPresentationContext = true
        
        /*
        web.webObserves = (Title:{(title) in
            print("web title: \(title)")
//            self.title = title
        },Progress:{(progress) in
            print("web load progress: \(progress)")
        },CanGoBack:{(back) in
            print("web can go back: \(back)")
        },CanGoForward:{(forward) in
            print("web can go forward: \(forward)")
        })*/
        
        web.rx.title.subscribe { title in
            print("webview_rx title: \(String(describing: title))")
            if let url = self.web.url {
                RealmController.share.insertHistory(url: url, title: title)
            }
        }.disposed(by: disposeBag)
        
        web.rx.url.subscribe { url in
            print("webview_rx url: \(String(describing: url))")
        }.disposed(by: disposeBag)
        
        web.rx.serverTrust.subscribe { serverTrust in
            print("webview_rx serverTrust: \(serverTrust)")
            
        }.disposed(by: disposeBag)
        
        web.rx.hasOnlySecureContent.subscribe { hasOnlySecureContent in
            print("webview_rx hasOnlySecureContent: \(hasOnlySecureContent)")
        }.disposed(by: disposeBag)
        
        web.rx.decidePolicyAction.subscribe { action, handler in
            print("webview_rx:是否允许导航")
            self.setNavigationBarVisible(Visible: true)
            self.setToolBarVisible(Visible: true)
            handler(.allow)
        }.disposed(by: disposeBag)
        
        web.rx.didStartLoad.subscribe { event in
            print("webview_rx:开始加载")
        }.disposed(by: disposeBag)
        
        web.rx.decidePolicyResponse.subscribe { (response, handler) in
            print("webview_rx:收到响应后是否允许导航")
            handler(.allow)
        }.disposed(by: disposeBag)
        
        web.rx.didCommit.subscribe { event in
            print("webview_rx:开始接收内容")
        }.disposed(by: disposeBag)
        
        web.rx.didReceiveServerRedirect.subscribe { event in
            print("webview_rx:服务器重定向")
        }.disposed(by: disposeBag)
        
        web.rx.didReceive.subscribe { (challenge, completionHandler) in
            print("webview_rx:需要响应身份验证")
            completionHandler(.rejectProtectionSpace, nil)
        }.disposed(by: disposeBag)
        
        web.rx.didFinishLoad.subscribe { event in
            print("webview_rx:加载完成")
        }.disposed(by: disposeBag)
        
        web.rx.didFailLoad.subscribe { event in
            print("webview_rx:导航期间发生错误")
        }.disposed(by: disposeBag)
        
        web.rx.didFailProvisional.subscribe { event in
            print("webview_rx:加载内容时发生错误")
        }.disposed(by: disposeBag)
        
        web.rx.didTerminate.subscribe { event in
            print("webview_rx:内容终止")
        }.disposed(by: disposeBag)
        
        
        /*
        web.navigationDelegates = (DecidePolicyNavigationAction:{(navigationAction) in
            return WKNavigationActionPolicy.allow
        }, DidStartNavigation:{(navigation) in
            
        }, DecidePolicyNavigationResponse:{(navigationResponse) in
            return WKNavigationResponsePolicy.allow
        }, DidCommitNavigation:{(navigation) in
            
        }, DidReceiveServerRedirect:{(navigation) in
            
        }, DidReceiveAuthChallenge:{
            return (.rejectProtectionSpace,nil)
        }, DidFinishNavigation:{(navigation) in
            
        }, DidFailNavigation:{(navigation, error) in
            
        }, DidFailProvisional:{(navigation, error) in
            
        }, DidTerminate:{
            
        })*/
        
        
        
//        web.loadweb(urlStr: "http://172.20.10.2:8080/")
//        web.loadweb(urlStr: "https://github.com/matteocrippa/awesome-swift")
        let h5Path = Bundle.main.path(forResource: "test_html", ofType: "html")
        print(h5Path)
//        web.loadFile(fileUrl: URL(fileURLWithPath: h5Path!))
        if RealmController.configRealm() {
            print("数据库配置成功")
        }else{
            print("数据库配置失败")
        }
    }
    
    func gotoBack() {
        if self.web.canGoBack {
            self.web.goBack()
        }
    }
    
    func gotoForward() {
        if self.web.canGoForward {
            self.web.goForward()
        }
    }
    
    
    /// 刷新页面
    func refresh() {
        self.web.reload()
    }
    
    /// 停止加载
    func stopload() {
        self.web.stopLoading()
    }
    
    func updateSearchBar(height: CGFloat) {
        print("---",height)
          
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    deinit {
        
    }
}
