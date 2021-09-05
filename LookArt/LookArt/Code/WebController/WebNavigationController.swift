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
    }
    
    private func setupUI(){
        //配置工具栏
        if let toolbar = self.toolbar as? WebToolBar {
            webController.setToolbarItems(toolbar.items, animated: false)
        }
        if let searchBar = self.navigationBar as? WebSearchBar {
            searchBar.topItem?.setRightBarButton(searchBar.rightActionItem, animated: true)
            print("search bar item",searchBar.topItem ?? "没有")
        }
    }
    
    @objc private func tabMarkBtnAction() {
        self.view.removeFromSuperview()
        self.removeFromParent()
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
