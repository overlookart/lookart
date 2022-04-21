//
//  JcaittService.swift
//  JingCaiTianTian
//
//  Created by CaiGou on 2022/3/23.
//

import Foundation
import Moya
enum JcaittService {
    /// 首页内容接口
    case content
    
    case login(String, String)
}


/// 精采天添 Request 协议
protocol JcttTargetType: TargetType, AccessTokenAuthorizable {
    
    /// 缓存策略
    var cachePolicy: URLRequest.CachePolicy? { get }
}

extension JcaittService: JcttTargetType {
    var authorizationType: AuthorizationType? { 
        return .none
    }
    
    var cachePolicy: URLRequest.CachePolicy? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: "https://testwwwapi.jcaitt.com")!
    }
    
    var path: String {
        switch self {
            case .content:
                return "/home/content"
            case .login:
                return "/sso/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .content:
                return Moya.Method.get
            case .login:
                return Moya.Method.post
        }
    }
    
    var validationType: ValidationType{
        return .successAndRedirectCodes
    }
    
    var task: Task {
        switch self {
            case .content:
                return .requestParameters(parameters: [:], encoding: URLEncoding.default)
            case .login(let username, let password):
                return .requestParameters(parameters: ["username":username, "password":password], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
            
            case .login:
                return ["Content-type":"application/x-www-form-urlencoded"]
//                return ["Content-type": "application/json"]
            default:
                return ["Content-type": "application/json"]
        }
    }
    
    
}

