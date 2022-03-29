//
//  UITabBarController_Extension.swift
//  JingCaiTianTian
//
//  Created by CaiGou on 2022/3/29.
//

import Foundation
import UIKit
extension UITabBarController {
    
    /// 设置 TabBar item Title Color
    /// - Parameters:
    ///   - color: 标题颜色
    ///   - state: 控制状态 只有 normal 有效？需要调用 setTabBarColor 后，其他状态才会生效
    func setTabBarTitle(Color color: UIColor, for state: UIControl.State){
        var attributes:[NSAttributedString.Key:Any] = UITabBarItem.appearance().titleTextAttributes(for: state) ?? [:]
        attributes[.foregroundColor] = color
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: state)
    }
    
    /// 设置 TabBar item Title Font
    /// - Parameters:
    ///   - font: 字体
    ///   - state: 控制状态 只有 normal 有效？
    func setTabBarTitle(Font font: UIFont, for state: UIControl.State) {
        var attributes:[NSAttributedString.Key:Any] = UITabBarItem.appearance().titleTextAttributes(for: state) ?? [:]
        attributes[.font] = font
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: state)
    }
    
    /// 设置 TabBar Color
    /// - Parameter color: 颜色
    func setTabBarColor(_ color: UIColor) {
        self.tabBar.barTintColor = color
    }
}
