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
    
    func start() {
        self.server.start(withPort: 8088, bonjourName: nil)
        print("Visit in your web browser:",server.serverURL?.absoluteString ?? "")
    }
    
    func stop(){
        self.server.stop()
    }
}
