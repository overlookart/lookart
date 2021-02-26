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
        return webServer
    }()
    func startServer() {
        self.server.start(withPort: 8080, bonjourName: nil)
        print("Visit \(server.serverURL) in your web browser")
    }
}
