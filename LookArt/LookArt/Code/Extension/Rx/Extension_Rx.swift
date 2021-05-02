//
//  Extension_Rx.swift
//  LookArt
//
//  Created by xzh on 2021/5/1.
//

import Foundation
import RxCocoa

/**
 对 Rx 私有方法抽取
 */

///  尝试将 object 转化为指定类型
/// - Parameters:
///   - resultType: 指定的类型
///   - object: 任意类型
/// - Throws: 错误处理
/// - Returns: 已转化为指定类型的对象
func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}
