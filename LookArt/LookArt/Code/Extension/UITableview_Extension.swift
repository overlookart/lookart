//
//  UITableview_Extension.swift
//  LookArt
//
//  Created by CaiGou on 2022/1/6.
//

import Foundation
import UIKit
extension UITableView {
    
    /// 设置单元格的分割线
    /// - Parameters:
    ///   - inset: 上下左右间距
    ///   - color: 颜色
    func separator(Inset inset:UIEdgeInsets? = UIEdgeInsets.zero, Color color:UIColor? = UIColor.separator ) {
        
    }
    
    /// 使用 Nib 注册 Header Footer View
    func register<T: UITableViewHeaderFooterView>(nibWithHeaderFooterViewClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        register(UINib(nibName: identifier, bundle: bundle), forHeaderFooterViewReuseIdentifier: identifier)
    }
}
