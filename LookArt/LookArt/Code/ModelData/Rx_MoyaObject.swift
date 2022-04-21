//
//  Rx_MoyaObject.swift
//  JingCaiTianTian
//
//  Created by CaiGou on 2022/3/25.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper

/// Moya + ObjectMapper
public extension Response {
    
    /// 将接收到的数据映射到实现 Mappable 协议的对象中
    /// 如果转换失败，抛出错误
    func mapObject<T: BaseMappable> (_ type: T.Type, context: MapContext? = nil) throws -> T {
        guard let object = Mapper<T>(context: context).map(JSONObject: try mapJSON()) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
    
    /// 将接收到的数据映射到实现 Mappable 的对象数组中
    /// 如果转换失败，抛出错误
    func mapArray<T: BaseMappable> (_ type: T.Type, context: MapContext? = nil) throws -> [T] {
        guard let array = try mapJSON() as? [[String:Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return Mapper<T>(context: context).mapArray(JSONArray: array)
    }
    
    /// 将从接收到的数据映射到实现 Mappable 协议的对象中
    /// 如果转换失败，抛出错误
    func mapObject<T: BaseMappable> (_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) throws -> T {
        guard let object = Mapper<T>(context: context).map(JSONObject: (try mapJSON() as? NSDictionary)?.value(forKey: keyPath)) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
    
    /// 将接收到的数据映射到实现 Mappable 的对象数组中
    /// 如果转换失败，抛出错误
    func mapArray<T: BaseMappable> (_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) throws -> [T] {
        guard let array = (try mapJSON() as? NSDictionary)?.value(forKeyPath: keyPath) as? [[String : Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return Mapper<T>(context: context).mapArray(JSONArray: array)
    }
    
}


/// 通过 ObjectMapper 将响应处理为可映射对象的扩展
/// Rx + Moya + ObjectMapper
public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    
    /// 将从signal接收到的数据映射到一个对象中
    /// 实现 Mappable 协议并返回结果
    /// 如果转换失败，signal错误。
    func mapObject<T: BaseMappable> (_ type: T.Type, context: MapContext? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type, context: context))
        }
    }
    
    /// 将从signal接收到的数据映射到一个对象数组中
    /// 实现 Mappable 协议并返回结果
    /// 如果转换失败，signal错误
    func mapArray<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArray(type, context: context))
        }
    }
    
    /// 将从signal接收到的数据映射到一个对象中
    /// 实现 Mappable 协议并返回结果
    /// 如果转换失败，signal错误
    func mapObject<T: BaseMappable> (_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type, atKeyPath: keyPath, context: context))
        }
    }
    
    /// 将从signal接收到的数据映射到一个对象数组中
    /// 实现 Mappable 协议并返回结果
    /// 如果转换失败，signal错误
    func mapArray<T: BaseMappable> (_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArray(type, atKeyPath: keyPath, context: context))
        }
    }
    
}


public extension ObserverType where Element == Response {
    
//    func mapObject<T: BaseMappable> (_ type: T.Type, context: MapContext? = nil) -> Observable<T> {
//
//        return flatMap{response -> Observable<T> in
//            return Observable.just(try response?.mapObject(type, context: context))
//        }
//    }
    
}
