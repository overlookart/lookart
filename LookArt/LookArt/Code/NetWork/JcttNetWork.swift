//
//  JcttNetWork.swift
//  JingCaiTianTian
//
//  Created by CaiGou on 2022/3/23.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper
import SVProgressHUD
import UIKit
struct JcttNetWork {
    /// 网络加载指示插件
    private static let activityPlugin: NetworkActivityPlugin = {
        let plugin = NetworkActivityPlugin(networkActivityClosure: {(state, targetType) in
            switch state {
                case .began:
                    DispatchQueue.main.async {
                        SVProgressHUD.setDefaultStyle(.dark)
                        SVProgressHUD.setDefaultMaskType(.clear)
                        SVProgressHUD.show()
                    }
                case .ended:
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                    }
            }
        })
        return plugin
    }()
    
    /// 网络请求日志插件
    private static let loggerPlugin: NetworkLoggerPlugin = {
        let plugin = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        return plugin
    }()
    
    /// 令牌访问认证插件
    private static let accessTokenPlugin: AccessTokenPlugin = {
        let plugin = AccessTokenPlugin(tokenClosure: { tokenType in
            return ""
        })
        return plugin
    }()
    
    private static let plugins: [PluginType] = [loggerPlugin,
                                                activityPlugin,
                                                accessTokenPlugin,
                                                JcttCustomPlugin(),
                                                JcttCachePlugin()]
    /// Target -> EndPoint
    /// 为 Target 提供 EndPoint 闭包
    /// 详见 MoyaProvider.defaultEndpointMapping
    private static let endpointClosure = {(target: JcaittService) -> Endpoint in
        
        let sampleResponseClosure = { () -> EndpointSampleResponse in
            return .networkResponse(200, target.sampleData)
            
        }
        
        return Endpoint(url: URL(target: target).absoluteString, sampleResponseClosure: sampleResponseClosure, method: target.method, task: target.task, httpHeaderFields: target.headers)
    }
    
    ///  EndPoint -> RequestResult
    ///  将 EndPoint 转换为 RequestResult 闭包
    ///  详见 MoyaProvider.defaultRequestMapping
    private static let requestClosure = { (endpoint: Endpoint, resultClosure: MoyaProvider.RequestResultClosure) in
        
    }
    
    static let provider = MoyaProvider<JcaittService>(plugins: plugins, trackInflights: false)
    
    
    /// 适配器
    static func request<T: Mappable> (_ type:T.Type, target: JcaittService, AsModel asModel: @escaping (T) -> Void, OnError onError: ((Error) -> Void)? = nil, OnCompleted onCompleted: (() -> Void)? = nil, by disposeBag: DisposeBag){
//        provider.request(target) { result in
//            switch result {
//                case let .success(response):
//                    print(response)
//                case let .failure(error):
//                    print(error)
//                    errLog(error: error)
//
//            }
//        }
    
        provider.rx.request(target).mapObject(type).asObservable().subscribe { model in
             asModel(model)
        } onError: { error in
            if let onerror = onError {
                onerror(error)
            }
        } onCompleted: {
            if let completed = onCompleted {
                completed()
            }
        }.disposed(by: disposeBag)

    }
    
    /// 错误处理
    static func errLog(error: MoyaError) {
        switch error {
            case .imageMapping(let response):
                print(response)
            case .jsonMapping(let response):
                print(response)
            case .statusCode(let response):
                print(response)
            case .stringMapping(let response):
                print(response)
            case .underlying(let err as NSError, let response):
                print(err.code)
                print(err.domain)
            case .requestMapping(let requestStr):
                print(requestStr)
            case .objectMapping(let err as NSError, let response):
                print(err,response)
            case .encodableMapping(let err as NSError):
                print(err)
            case .parameterEncoding(let err as NSError):
                print(err)
        }
    }
}
