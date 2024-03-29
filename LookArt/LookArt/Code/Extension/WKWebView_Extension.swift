//
//  WKWebView_Extension.swift
//  DaoSample
//
//  Created by MoYing on 2020/11/21.
//

import Foundation
import WebKit

extension WKWebView {
    func loadweb(urlStr: String) {
        var urls: String = ""
        if let str = urlStr.removingPercentEncoding {
            urls = str.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
        }else{
            urls = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
        }
        
        // 还原被编码的“#”
        urls = urls.replacingOccurrences(of: "%23", with: "#")
        if let url = URL(string: urls) {
            let request = URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 30)
            self.load(request)
        }
    }
    
    func loadFile(fileUrl: URL) {
        self.loadFileURL(fileUrl, allowingReadAccessTo: fileUrl)
    }
    
    
    /// 配置 user agent
    /// - Parameter str: 自定义的内容
    /// - Returns: 结果
    func configUserAgent(str: String) throws -> String  {
        var userAgent: String! = self.configuration.applicationNameForUserAgent
        userAgent = userAgent.appending(str)
        return userAgent
    }
    
}
