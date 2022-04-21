//
//  JcttCachePlugin.swift
//  JingCaiTianTian
//
//  Created by CaiGou on 2022/3/24.
//

import Foundation
import Moya
/// 缓存策略插件
final class JcttCachePlugin: PluginType {
    
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let t = target as? JcttTargetType, let cache = t.cachePolicy else { return request }
        var req = request
        req.cachePolicy = cache
        return req
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        print("缓存策略插件")
    }
}
