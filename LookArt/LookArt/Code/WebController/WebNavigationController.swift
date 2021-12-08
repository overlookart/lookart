//
//  WebNavigationController.swift
//  LookArt
//
//  Created by xzh on 2021/3/23.
//

import UIKit
import RxSwift
import RxCocoa
class WebNavigationController: BaseNavigationController {
    private(set) var webController = WebController()
    let disposeBag = DisposeBag()
    init() {
        super.init(navigationBarClass: WebSearchBar.self, toolbarClass: WebToolBar.self)
        self.setViewControllers([self.webController], animated: false)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        bindWeb()
        bindAction()
    }
    
    private func setupUI(){
        //配置工具栏
        if let toolbar = self.toolbar as? WebToolBar {
            webController.setToolbarItems(toolbar.items, animated: false)
        }
        //配置导航栏
        if let searchBar = self.navigationBar as? WebSearchBar {
        
        }
    }
    
    @objc private func tabMarkBtnAction() {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    private func bindWeb() {
        if let toolbar = self.toolbar as? WebToolBar {
            webController.web.rx.canGoBack.bind(to: toolbar.canBack).disposed(by: disposeBag)
            webController.web.rx.canGoForward.bind(to: toolbar.canForward).disposed(by: disposeBag)
        }
        if let searchBar = self.navigationBar as? WebSearchBar {
            //绑定网页的加载进度
            webController.web.rx.progress.bind(to: searchBar.progress).disposed(by: disposeBag)
            //绑定网页的加载状态
            webController.web.rx.loading.bind(to: searchBar.loading).disposed(by: disposeBag)
            //绑定网页的标题
            webController.web.rx.title.bind(to: searchBar.title).disposed(by: disposeBag)
        }
    }
    
    private func bindAction() {
        if let toolbar = self.toolbar as? WebToolBar {
            toolbar.backBtnItem.rx.tap.subscribe(onNext: { [self] in
                webController.gotoBack()
            }).disposed(by: disposeBag)
            
            toolbar.forwardBtnItem.rx.tap.subscribe(onNext: { [self] in
                webController.gotoForward()
            }).disposed(by: disposeBag)
            
            toolbar.actionBtnItem.rx.tap.subscribe(onNext: {
                let activity = LookArtActivityController(activityItems: [""]);
                self.present(activity, animated: true, completion: nil)
            }).disposed(by: disposeBag)
            
            toolbar.bookmarkBtnItem.rx.tap.subscribe(onNext: {
                
            }).disposed(by: disposeBag)
            
            toolbar.tabmarkBtnItem.rx.tap.subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        }
        if let searchbar = self.navigationBar as? WebSearchBar {
            searchbar.refreshBtn.rx.tap.subscribe(onNext: { [self] in
                webController.refresh()
            }).disposed(by: disposeBag)
            searchbar.stoploadBtn.rx.tap.subscribe(onNext: { [self] in
                webController.stopload()
                print("\\\\\\web 是否加载",webController.web.isLoading)
            }).disposed(by: disposeBag)
            searchbar.titleItem.rx.tap.subscribe(onNext: {
                self.present(WebSearchController(searchResultsController: nil), animated: true, completion: nil)
            }).disposed(by: disposeBag)
        }
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

extension WebNavigationController {
    
}
