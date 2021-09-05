//
//  NavigationBar.swift
//  LookArt
//
//  Created by xzh on 2021/2/16.
//

import UIKit

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
    let rightActionItem: UIBarButtonItem!
    let progressBar: UIProgressView = UIProgressView(progressViewStyle: .bar)
    override init(frame: CGRect) {
        rightActionItem = UIBarButtonItem(customView: self.refreshOrStopBtn)
        super.init(frame: frame)
        
//        searchItem.titleView = searchVC.searchBar
//        searchItem.titleView?.addSubview(progress);
        self.barTintColor = UIColor.random
        self.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(2)
        }
        
//        self.setItems([searchItem], animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


