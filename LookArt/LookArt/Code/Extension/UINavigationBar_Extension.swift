//
//  UINavigationBar_Extension.swift
//  LookArt
//
//  Created by xzh on 2021/2/17.
//

import Foundation
import UIKit
extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let s = super.sizeThatFits(size)
        return CGSize(width: s.width, height: 100)
    }
    
    
}
