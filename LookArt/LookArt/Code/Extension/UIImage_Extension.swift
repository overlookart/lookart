//
//  UIImage_Extension.swift
//  LookArt
//
//  Created by xzh on 2022/8/9.
//
#if canImport(UIKit)
import UIKit

public extension UIImage {
    
    /// UIImage 缩放到固定宽高
    /// - Parameters:
    ///   - toWidth: 宽度
    ///   - toHeight: 高度
    ///   - opaque: 是否透明
    /// - Returns: 缩放后的image
    func scaled(toWidth: CGFloat, toHeight: CGFloat, opaque: Bool = false) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: toWidth, height: toHeight), opaque, self.scale)
        draw(in: CGRect(x: 0, y: 0, width: toWidth, height: toHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}



#endif
