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
    
    private let backgroundView: UIView = UIView()
    
    let leftBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "qrcode.viewfinder")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .normal)
        btn.setImage(UIImage(systemName: "qrcode.viewfinder")?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal), for: .highlighted)
        btn.backgroundColor = UIColor.random
        return btn
    }()
    
    /// 刷新按钮
    let refreshBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "arrow.clockwise")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .normal)
        btn.setImage(UIImage(systemName: "arrow.clockwise")?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal), for: .highlighted)
        btn.backgroundColor = UIColor.random
        return btn
    }()
    
    /// 停止加载按钮
    let stoploadBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "xmark")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .normal)
        btn.setImage(UIImage(systemName: "xmark")?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal), for: .highlighted)
        btn.backgroundColor = UIColor.random
        return btn
    }()
    
    let titleItem: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.random
        return btn
    }()
    let searchBarBGView: UIView = {
        let view = BaseView()
        view.cornerRadius = 8
        return view
    }()
    /// 加载进度条
    let progressBar: BaseProgressView = BaseProgressView(progressViewStyle: .bar)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeUI()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI(){
        self.addSubview(searchBarBGView)
        searchBarBGView.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(40)
        }
        searchBarBGView.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(2)
        }
        
        searchBarBGView.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { make in
            make.left.equalTo(searchBarBGView)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalTo(searchBarBGView)
        }
        
        searchBarBGView.addSubview(refreshBtn)
        refreshBtn.snp.makeConstraints { make in
            make.right.equalTo(searchBarBGView)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalTo(searchBarBGView)
        }
        
        searchBarBGView.addSubview(stoploadBtn)
        stoploadBtn.snp.makeConstraints { make in
            make.right.equalTo(searchBarBGView)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalTo(searchBarBGView)
        }
        stoploadBtn.isHidden = true
        
        searchBarBGView.addSubview(titleItem)
        titleItem.snp.makeConstraints { make in
            make.left.equalTo(leftBtn.snp.right)
            make.right.equalTo(refreshBtn.snp.left)
            make.height.equalTo(40)
            make.centerY.equalTo(searchBarBGView)
        }
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
//                searchBar.topItem?.setRightBarButton(searchBar.stoploadItem, animated: true)
                searchBar.refreshBtn.isHidden = true
                searchBar.stoploadBtn.isHidden = false
            }else{ //非加载中 显示刷新按钮
//                searchBar.topItem?.setRightBarButton(searchBar.refreshItem, animated: true)
                searchBar.refreshBtn.isHidden = false
                searchBar.stoploadBtn.isHidden = true
            }
        }
    }
    
    
    /// 绑定web的标题
    var title: Binder<String> {
        return Binder(self) { searchBar, title in
            searchBar.titleItem.setTitle(title, for: .normal)
        }
    }
    
    /// 绑定web的url
    var urlStr: Binder<String> {
        return Binder(self) { searchBar, urlStr in
            
        }
    }
    
}


