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
    
    //是否为iPhoneX 刘海屏设备
    class func iPhoneX() -> Bool {
        if (Int((ScreenHeight()/ScreenWidth())*100) == 216 ||  Int((ScreenWidth()/ScreenHeight())*100) == 216){
            return true
        }else {
            return false
        }
        
    }
    
    
    /// 状态栏高度
    class func StateBarHeight() -> CGFloat {
        if iPhoneX() {
            return 34
        }else{
            return 20
        }
    }
    
    /// 底部安全区域
    class func BottomSafeHeight() -> CGFloat {
        if iPhoneX() {
            return 34
        }else{
            return 0
        }
    }
    
//    class func SafeTop() -> CGFloat{
//        
//    }
    
}
