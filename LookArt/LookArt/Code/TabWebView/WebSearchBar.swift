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
    let refreshOrStopBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage.init(systemName: "arrow.clockwise")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .normal)
        btn.setImage(UIImage.init(systemName: "xmark")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .selected)
        return btn
    }()
    let refreshBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "arrow.clockwise")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .normal)
        btn.setImage(UIImage(systemName: "arrow.clockwise")?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal), for: .highlighted)
        return btn
    }()
    let stoploadBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "xmark")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .normal)
        btn.setImage(UIImage(systemName: "xmark")?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal), for: .highlighted)
        return btn
    }()
    let refreshItem: UIBarButtonItem!
    let stoploadItem: UIBarButtonItem!
    let rightActionItem: UIBarButtonItem!
    let progressBar: UIProgressView = UIProgressView(progressViewStyle: .bar)
    override init(frame: CGRect) {
        refreshItem = UIBarButtonItem(customView: refreshBtn)
        stoploadItem = UIBarButtonItem(customView: stoploadBtn)
        rightActionItem = UIBarButtonItem(customView: self.refreshOrStopBtn)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension WebSearchBar {
    var progress: Binder<Float> {
        return self.progressBar.rx.progress
    }
    
    var loading: Binder<Bool> {
        return Binder(self) { searchBar, loading in
            if loading {
                searchBar.topItem?.setRightBarButton(searchBar.stoploadItem, animated: true)
            }else{
                searchBar.topItem?.setRightBarButton(searchBar.refreshItem, animated: true)
            }
        }
    }
}


