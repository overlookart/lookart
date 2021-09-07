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
    
    let web: TabWebView = TabWebView(config: WebConfigComponent(), script: WebScriptComponent())
    
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
            make.top.equalTo(0)
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
        web.rx.title.subscribe(onNext: { (title) in
            print("webview_rx title: \(String(describing: title))")
        }).disposed(by: disposeBag)

        web.rx.url.subscribe(onNext: {(url) in
            print("webview_rx url: \(String(describing: url))")
//            self.searchBar.updateHost(host: url?.host);
        }).disposed(by: disposeBag)
        

        if let searchBar = self.navigationController?.navigationBar as? WebSearchBar {
            web.rx.progress.bind(to: searchBar.progress).disposed(by: disposeBag)
            web.rx.loading.bind(to: searchBar.loading).disposed(by: disposeBag)
    
        }


        
        web.rx.decidePolicyForNavigationAction.subscribe { (webview, action, handler) in
            print("webview_rx:是否允许导航")
            //开始导航时 导航栏与工具栏显示
            self.setNavigationBarVisible(Visible: true)
            self.setToolBarVisible(Visible: true)
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
//            nvc.backBtnItem.rx.tap.subscribe(onNext: {
//                self.web.goBack()
//            }).disposed(by: disposeBag)
//            nvc.forwardBtnItem.rx.tap.subscribe(onNext: {
//                self.web.goForward()
//            }).disposed(by: disposeBag)
//            nvc.actionBtnItem.rx.tap.subscribe(onNext: {
//                let activity = LookArtActivityController(activityItems: []);
//                self.present(activity, animated: true, completion: nil)
//            }).disposed(by: disposeBag)
//            nvc.bookmarkBtnItem.rx.tap.subscribe(onNext: {
//
//            }).disposed(by: disposeBag)
            
        }
        
//        web.loadweb(urlStr: "http://172.20.10.2:8080/")
//        web.loadweb(urlStr: "https://github.com/matteocrippa/awesome-swift")
//        let h5Path = Bundle.main.path(forResource: "test_html", ofType: "html")
//        web.loadFile(fileUrl: URL(fileURLWithPath: h5Path!))
    }
    
    

    func updateSearchBar(height: CGFloat) {
        print("---",height)
        //search bar 最大高度 49
        //search bar 最小高度 19
        //navigition 最大高度 96
        //navigation 最小高度 66
        //iPhone X   顶部安全 47
//        66 96 30
//        19 49 30
//        66 47 19
        
//        self.searchBar.snp.updateConstraints { make in
//            make.top.equalTo(self.view)
//            make.leading.equalTo(0)
//            make.trailing.equalTo(0)
//            make.bottom.equalTo(self.web.snp.top);
//        }
//        if (self.searchBar.isFold && height != 30) || (!self.searchBar.isFold && height != 0) {
//            self.searchBar.updateHeight(height: height);
//            self.web.snp.updateConstraints { make in
//                make.trailing.equalTo(0)
//                make.leading.equalTo(0)
//                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(SearchBarHeight-height)
//                make.bottom.equalTo(0)
//            }
//        }
        
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
