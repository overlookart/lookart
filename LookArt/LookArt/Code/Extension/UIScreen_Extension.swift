//
//  UIScreen_Extension.swift
//  ONEBrowser
//
//  Created by MoYing on 2020/8/7.
//  Copyright © 2020 MoYing. All rights reserved.
//

import UIKit
import SnapKit
// MARK: - Properties
extension UIScreen {
    //屏幕的大小
    class func Bounds() -> CGRect{
        return UIScreen.main.bounds
    }
    
    //屏幕的宽度
    class func ScreenWidth() -> CGFloat {
        return UIScreen.Bounds().size.width
    }
    
    //屏幕的高度
    class func ScreenHeight() -> CGFloat {
        return UIScreen.Bounds().size.height
    }
    
    
//    class func SafeTop() -> CGFloat{
//        
//    }
    
}
