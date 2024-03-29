//
//  UIApplication_Extension.swift
//  DaoSample
//
//  Created by MoYing on 2020/11/14.
//

import Foundation
import UIKit
import SystemConfiguration.CaptiveNetwork

extension UIApplication {
    
    var bundleIdentifier: String? {
        return Bundle.main.bundleIdentifier
    }
    
    var deviceModel: String {
        return UIDevice.current.model
    }
    
    var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    
    var appIDFV: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    /// 状态栏高度
    var stateBarHeight: CGFloat {
        var height: CGFloat = 0
        if #available(iOS 13.0, *) {
            let keyWindow = connectedScenes.map { scene in
                scene as? UIWindowScene
            }.compactMap { scene in
                scene
            }.first?.windows.first
            height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        }else{
            height = statusBarFrame.height
        }
        return height
    }
    
    
    //是否为iPhoneX 刘海屏设备
    var iPhoneX: Bool {
        if stateBarHeight > 20 {
            return true
        }else{
            return false
        }
        
    }
    
    // 网络mac地址
    var mac: String? {
        if let cfas: NSArray = CNCopySupportedInterfaces() {
            for cfa in cfas {
                if let dict = CFBridgingRetain(CNCopyCurrentNetworkInfo(cfa as! CFString)) {
                    if let _ = dict["SSID"] as? String, let bssid = dict["BSSID"] as? String {
                        return bssid
                    }
                }
            }
        }
        return nil
    }
    
    /// 加载本地文件
    /// - Parameters:
    ///   - fileName: 文件名
    ///   - formatName: 格式名
    /// - Returns: 文件中的 utf8字符
    static func loadLocalFile(Name fileName: String, Format formatName: String) -> String? {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: formatName) else { return nil }
        guard let str = try? String(contentsOfFile: filePath, encoding: .utf8) else { return nil }
        return str
    }
}
