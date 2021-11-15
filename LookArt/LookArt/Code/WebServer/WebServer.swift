//
//  WebServer.swift
//  LookArt
//
//  Created by xzh on 2021/2/12.
//

import Foundation
class WebServer {
    private static let instance = WebServer()
    class var share : WebServer {
        return instance
    }
    
    lazy var server: GCDWebServer = {
        let webServer = GCDWebServer()
        webServer.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self) { (request) -> GCDWebServerResponse? in
            
            return GCDWebServerDataResponse(html: "<html><body><p>Hello World</p></body></html>")
        }
        
        // 将本地网站转化为动态网站
        if let websitePath = Bundle.main.path(forResource: "website", ofType: nil) {
            print("获取本地网站路径:",websitePath)
            //添加静态文件访问服务
            webServer.addGETHandler(forBasePath: "/", directoryPath: websitePath, indexFilename: nil, cacheAge: 3600, allowRangeRequests: true)
            //为所有对“*.html” URL 的请求添加一个覆盖处理程序以执行特殊的 HTML 模板化
            webServer.addHandler(forMethod: "GET", pathRegex: "/.*.html", request: GCDWebServerRequest.self) { request in
                return GCDWebServerDataResponse(htmlTemplate: websitePath.appendingPathComponent(request.path), variables: ["value":"variable"])
            }
            
            webServer.addHandler(forMethod: "GET", path: "/", request: GCDWebServerRequest.self) { request in
                return GCDWebServerResponse(redirect: URL(string: "index.html", relativeTo: request.url) ?? URL.init(fileURLWithPath: ""), permanent: false)
            }
        }
        
        return webServer
    }()
    
    /// 启动服务
    func start() {
        self.server.start(withPort: 8088, bonjourName: nil)
        print("Visit in your web browser:",server.serverURL?.absoluteString ?? "")
    }
    
    /// 关闭服务
    func stop(){
        self.server.stop()
    }
}
