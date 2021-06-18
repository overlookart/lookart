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
    let searchBar: WebSearchBar = {
        let search = WebSearchBar(frame: .zero)
        return search
        
    }()
    
    let web: TabWebView = {
        let tabWebView = TabWebView(config: WebConfig())
        return tabWebView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        view.addSubview(self.web)
        self.setNavigationBarVisible(Visible: false)
        self.setToolBarVisible(Visible: true)
        web.snp.makeConstraints { (make) in
            make.trailing.equalTo(0)
            make.leading.equalTo(0)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(49)
            make.bottom.equalTo(0)
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
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.bottom.equalTo(self.web.snp.top);
        }
    
        self.definesPresentationContext = true
        setToolBar()
 
        
        
        
        
        
        web.scrollDelegates = (DidScroll:{
            if self.web.scrollContentOffset.y < self.web.scrollBeginDragOffset.y {
                return
            }
            let adjustedOffsetY = self.web.scrollContentOffset.y + self.web.scrollView.contentInset.top - self.web.scrollBeginDragOffset.y
            let boundedOffset = min(max(adjustedOffsetY, 0), 56)
            self.updateSearchBar(height: boundedOffset)
            
        },BeginDragging:{
            
        },WillEndDragging:{ (velocity) in
            
        },EndDragging:{
            
        },BeginDecelerating:{
            
        },EndDecelerating:{
            
        })
        
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
        web.rx.title.subscribe(onNext: { (title) in
            print("webview_rx title: \(String(describing: title))")
        }).disposed(by: disposeBag)

        web.rx.url.subscribe(onNext: {(url) in
            print("webview_rx url: \(String(describing: url))")
        }).disposed(by: disposeBag)

        web.rx.progress.subscribe(onNext: { (progress) in
            print("webview_rx progress: \(progress)")
            self.searchBar.setProgress(progress: Float(progress))
        }).disposed(by: disposeBag)
        web.rx.canGoBack.subscribe(onNext: { (can) in
            print("webview_rx canGoBack: \(can)")
            if let nvc = self.navigationController as? WebNavigationController{
                nvc.backBtnItem.isEnabled = can
            }
        }).disposed(by: disposeBag)
        web.rx.canGoForward.subscribe(onNext: { (can) in
            print("webview_rx canGoForward: \(can)")
            if let nvc = self.navigationController as? WebNavigationController{
                nvc.forwardBtnItem.isEnabled = can
            }
        }).disposed(by: disposeBag)
        web.rx.loading.subscribe(onNext: {(isloading) in
            print("webview_rx 加载状态: \(isloading)")
        }).disposed(by: disposeBag)


        
        web.rx.decidePolicyForNavigationAction.subscribe { (webview, action, handler) in
            print("webview_rx:是否允许导航")
            handler(.allow)
        } .disposed(by: disposeBag)
        web.rx.didStartProvisionalNavigation.subscribe { (webview, navigation) in
            print("webview_rx:开始加载")
        }.disposed(by: disposeBag)
        web.rx.decidePolicyForNavigationResponse.subscribe { (webview, navigationResponse, decisionHandler) in
            print("webview_rx:收到响应后是否允许导航")
            decisionHandler(.allow)
        }.disposed(by: disposeBag)
        web.rx.didCommitNavigation.subscribe { (webview, navigation) in
            print("webview_rx:开始接收内容")
        }.disposed(by: disposeBag)
        web.rx.didReceiveServerRedirect.subscribe { (webview, navigation) in
            print("webview_rx:服务器重定向")
        }.disposed(by: disposeBag)
        web.rx.didReceiveChallenge.subscribe { (webview, challenge, completionHandler) in
            print("webview_rx:需要响应身份验证")
            completionHandler(.rejectProtectionSpace, nil)
        }.disposed(by: disposeBag)
        web.rx.didFinishNavigation.subscribe { (webview, navigation) in
            print("webview_rx:加载完成")
        }.disposed(by: disposeBag)
        web.rx.didFailNavigation.subscribe { (webview, navigation, err) in
            print("webview_rx:导航期间发生错误")
        }.disposed(by: disposeBag)
        web.rx.didFailProvisionalNavigation.subscribe { (webview, navigation, err) in
            print("webview_rx:加载内容时发生错误")
        }.disposed(by: disposeBag)
        web.rx.didTerminateContentProcess.subscribe { (webview) in
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
        
        if let nvc = self.navigationController as? WebNavigationController {
            nvc.backBtnItem.rx.tap.subscribe(onNext: {
                self.web.goBack()
            }).disposed(by: disposeBag)
            nvc.forwardBtnItem.rx.tap.subscribe(onNext: {
                self.web.goForward()
            }).disposed(by: disposeBag)
            nvc.actionBtnItem.rx.tap.subscribe(onNext: {
                let activity = UIActivityViewController(activityItems: [""], applicationActivities: [SettingActivity()]);
//                activity.completionWithItemsHandler 
                self.present(activity, animated: true, completion: nil)
            }).disposed(by: disposeBag)
            nvc.bookmarkBtnItem.rx.tap.subscribe(onNext: {
               
            }).disposed(by: disposeBag)
            
        }
        
//        web.loadweb(urlStr: "http://172.20.10.2:8080/")
//        web.loadweb(urlStr: "https://github.com/matteocrippa/awesome-swift")
//        let h5Path = Bundle.main.path(forResource: "test_html", ofType: "html")
//        web.loadFile(fileUrl: URL(fileURLWithPath: h5Path!))
    }

    
    private func setToolBar() {
        if let webNavigation = self.navigationController as? WebNavigationController {
            webNavigation.setToolBar(webController: self)
        }
    }
    
    

    func updateSearchBar(height: CGFloat) {
//        let minHeight = min(height, 20)
//        let perc = height / 56
//        let f = self.navigationController?.navigationBar.frame
//        self.navigationController?.navigationBar.setNeedsDisplay(CGRect(x: f?.origin.x ?? 0, y: f?.origin.y ?? 0, width: f?.width ?? 0, height: minHeight))

        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
