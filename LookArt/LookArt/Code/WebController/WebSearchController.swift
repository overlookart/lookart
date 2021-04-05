//
//  WebSearchController.swift
//  LookArt
//
//  Created by xzh on 2021/4/4.
//

import UIKit

class WebSearchController: UISearchController {
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        self.searchBar.searchBarStyle = .default
        self.searchBar.placeholder = "搜索或输入网站名称"
        self.searchBar.barStyle = .default
        self.searchBar.setPositionAdjustment(UIOffset(horizontal: 90, vertical: 0), for: .search)
        self.searchBar.delegate = self
        self.obscuresBackgroundDuringPresentation = false
        self.hidesNavigationBarDuringPresentation = false
        self.delegate = self
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.backgroundColor = UIColor.random
        print("search did load")
    }

    override func viewDidAppear(_ animated: Bool) {
        
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

extension WebSearchController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("开始编辑")
        self.searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("结束编辑")
        self.searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("取消按钮点击")
        self.setEditing(false, animated: true)
    }
    
    
    
    func willPresentSearchController(_ searchController: UISearchController) {
//        self.setNavigationBarVisible(Visible: true)
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        print("进入搜索控制器")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        print("离开搜索控制器")
    }
}
