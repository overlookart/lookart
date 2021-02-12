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
}
