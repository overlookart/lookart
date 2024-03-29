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
    
    /// 控制底部工具栏的显示隐藏
    /// - Parameter visible: true:显示,false:隐藏
    func setToolBarVisible(Visible visible: Bool) {
        self.navigationController?.setToolbarHidden(!visible, animated: true)
    }
    
    
    /// 点击时 导航控制器的导航栏和工具栏是否隐藏
    /// - Parameter isHide: 是否隐藏
    func hidesBarsOnTap(Hide isHide: Bool) {
        self.navigationController?.hidesBarsOnTap = isHide
    }
    
    
    /// 滑动时 导航控制器的导航栏和工具栏是否隐藏(向上滑动)/显示(向下滑动)
    /// - Parameter isHide: 是否隐藏
    func hidesBarsOnSwipe(Hide isHide: Bool) {
        self.navigationController?.hidesBarsOnSwipe = isHide
    }
    
    /// 设置NavigationBar的大标题显示方式
    /// - Parameter mode:显示方式
    @available(iOS 11.0, *)
    func setNavigationBarLargeTitleDisplay(Mode mode: UINavigationItem.LargeTitleDisplayMode) {
        self.navigationItem.largeTitleDisplayMode = mode
    }
    
    /// 控制底部标签栏的显示隐藏
    /// - Parameter visible: true:显示导航条,false:隐藏导航条
    func setTabBarVisible(Visible visible : Bool) {
        self.hidesBottomBarWhenPushed = visible
    }
}
