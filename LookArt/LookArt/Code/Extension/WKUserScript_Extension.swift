//
//  WKUserScript_Extension.swift
//  LookArt
//
//  Created by xzh on 2021/7/24.
//

import Foundation
import WebKit
extension WKUserScript {
    /// 加载本地的脚本
    /// - Parameter fileName: 脚本文件名称
    /// - Returns: 脚本
    static func localUserScript(fileName: String) -> WKUserScript? {
        guard let source = UIApplication.loadLocalFile(Name: fileName, Format: "js") else {
            return nil
        }
        return WKUserScript(source: source, injectionTime: .atDocumentStart, forMainFrameOnly: true)
    }
}
