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
    var searchItem = UINavigationItem(title: "");
    override init(frame: CGRect) {
        super.init(frame: frame)
        searchItem.titleView = searchVC.searchBar
        self.setItems([searchItem], animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


