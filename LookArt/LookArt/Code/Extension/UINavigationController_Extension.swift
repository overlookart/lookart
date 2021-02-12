//
//  UINavigationController_Extension.swift
//  DaoSample
//
//  Created by xzh on 2021/1/7.
//

import Foundation
import UIKit

extension UINavigationController {
    
    /// 设置NavigationBar分割线颜色
    /// - Parameter color: 颜色
    func setNavigationBar(AppearanceShadowColor color: UIColor) {
        self.navigationBar.shadowImage = UIImage(color: color, size: CGSize(width: 1, height: 1))
    }
    
    /// 设置NavigationBar的tintColor
    /// - Parameter color: tintColor
    func setNavigationBar(TintColor color: UIColor) {
        self.navigationBar.tintColor = color
    }
    
    /// 设置NavigationBar的背景色 beat
    /// - Parameter color: 颜色
    func setNavigationBar(BackgroundColor color: UIColor ) {
        self.navigationBar.backgroundColor = color
        self.navigationBar.barTintColor = color
    }
    
    /// 设置是否开启NavigationBar的大标题
    /// - Parameter enable: 是否开启
    @available(iOS 11.0, *)
    func setNavigationBar(PrefersLargeTitlesEnable enable: Bool) {
        self.navigationBar.prefersLargeTitles = enable
    }
}
