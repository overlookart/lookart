//
//  DispatchFunc.swift
//  LookArt
//
//  Created by CaiGou on 2023/7/4.
//

import Foundation

/// 延时函数
/// - Parameters:
///   - delay: 延时的秒数
///   - closure: Closure
func delay(_ delay:Double, closure:@escaping ()->()){
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}
