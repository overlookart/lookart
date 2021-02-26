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
    
    private(set) var searchBar: UISearchBar
    
    override init(frame: CGRect) {
        searchBar = UISearchBar(frame: CGRect.zero)
        super.init(frame: frame)
        let item = UINavigationItem(title: "URL")
        self.setItems([item], animated: true)
        
        self.preservesSuperviewLayoutMargins = true
        self.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.topItem?.titleView = searchBar
    }
}

