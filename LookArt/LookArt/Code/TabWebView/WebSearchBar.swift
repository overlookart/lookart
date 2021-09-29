//
//  NavigationBar.swift
//  LookArt
//
//  Created by xzh on 2021/2/16.
//

import UIKit
import RxSwift
import RxCocoa
class WebSearchBar: UINavigationBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var searchVC = WebSearchController(searchResultsController: nil)
    
    private let backgroundView: UIView = UIView()
    
    /// 刷新按钮
    let refreshBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "arrow.clockwise")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .normal)
        btn.setImage(UIImage(systemName: "arrow.clockwise")?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal), for: .highlighted)
        return btn
    }()
    
    /// 停止加载按钮
    let stoploadBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "xmark")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .normal)
        btn.setImage(UIImage(systemName: "xmark")?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal), for: .highlighted)
        return btn
    }()
    let refreshItem: UIBarButtonItem!
    let stoploadItem: UIBarButtonItem!
    
    
    /// 加载进度条
    let progressBar: BaseProgressView = BaseProgressView(progressViewStyle: .bar)
    override init(frame: CGRect) {
        refreshItem = UIBarButtonItem(customView: refreshBtn)
        stoploadItem = UIBarButtonItem(customView: stoploadBtn)
        super.init(frame: frame)
        
//        searchItem.titleView = searchVC.searchBar
//        searchItem.titleView?.addSubview(progress);
//        self.barTintColor = UIColor.random
        self.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(2)
        }
//        self.addSubview(backgroundView);
//        backgroundView.snp.makeConstraints { make in
//            make.left.equalTo(self)
//            make.right.equalTo(self)
//            make.top.equalTo(self)
//            make.bottom.equalTo(self)
//        }
//        backgroundView.backgroundColor = UIColor.random
        self.sendSubviewToBack(backgroundView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension WebSearchBar {
    
    /// 绑定web的加载进度
    var progress: Binder<Float> {
        return self.progressBar.rx.progress
    }
    
    /// 绑定web的加载状态
    var loading: Binder<Bool> {
        return Binder(self) { searchBar, loading in
            if loading { //如果加载中 显示停止加载按钮
                searchBar.topItem?.setRightBarButton(searchBar.stoploadItem, animated: true)
            }else{ //非加载中 显示刷新按钮
                searchBar.topItem?.setRightBarButton(searchBar.refreshItem, animated: true)
            }
        }
    }
    
    
    /// 绑定web的标题
    var title: Binder<String> {
        return Binder(self) { searchBar, title in
            
        }
    }
    
    /// 绑定web的url
    var urlStr: Binder<String> {
        return Binder(self) { searchBar, urlStr in
            
        }
    }
}


