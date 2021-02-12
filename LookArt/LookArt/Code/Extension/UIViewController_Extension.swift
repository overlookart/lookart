//
//  UIViewController_Extension.swift
//  DaoSample
//
//  Created by xzh on 2021/1/7.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// 控制导航条的显示隐藏
    /// - Parameter visible: true:显示导航条,false:隐藏导航条
    func setNavigationBarVisible(Visible visible : Bool) {
        self.navigationController?.setNavigationBarHidden(!visible, animated: true)
    }
    
    /// 设置NavigationBar的大标题显示方式
    /// - Parameter mode:显示方式
    @available(iOS 11.0, *)
    func setNavigationBarLargeTitleDisplay(Mode mode: UINavigationItem.LargeTitleDisplayMode) {
        self.navigationItem.largeTitleDisplayMode = mode
    }
    
    /// 控制底部工具条的显示隐藏
    /// - Parameter visible: true:显示导航条,false:隐藏导航条
    func setTabBarVisible(Visible visible : Bool) {
        self.hidesBottomBarWhenPushed = visible
    }
}
