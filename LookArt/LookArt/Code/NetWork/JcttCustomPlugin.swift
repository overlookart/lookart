//
//  JcttPlugin.swift
//  JingCaiTianTian
//
//  Created by CaiGou on 2022/3/24.
//

import Foundation
import Moya
import UIKit
/// 自定义 Moya 插件
final class JcttCustomPlugin: PluginType {
    /// 准备发起请求
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        
        return request
    }
    
    /// 请求将要发送
    func willSend(_ request: RequestType, target: TargetType) {

        print("自定义插件")
    }
    
    /// 请求已接收到
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {

    }
    
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
//        if let response = try? result.get() {
//            if response.statusCode != 200 {
//                let error = MoyaError.jsonMapping(response)
//                return Result<Response, MoyaError>.failure(error)
//            }
//        }
        return result
    }
}
