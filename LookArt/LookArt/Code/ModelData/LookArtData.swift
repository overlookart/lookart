//
//  LookArtData.swift
//  LookArt
//
//  Created by xzh on 2021/12/28.
//

import Foundation
import Cache
import SwiftUI
class LookArtData {
    private static let instance = RealmController()
    class var share: RealmController {
        return instance
    }
    
    func config(){
        let diskConfig = DiskConfig(name: "LookArt.Setting")
        let memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)
        let storage = try? Storage<String, [SettingData]>(diskConfig: diskConfig, memoryConfig: memoryConfig, transformer: TransformerFactory.forCodable(ofType:Array<SettingData>.self))
        
    }
}

extension LookArtData {
    static func themeList() -> [ThemeData] {
        return [ThemeData(type: .Normal), ThemeData(type: .Night),
                ThemeData(type: .Green), ThemeData(type: .Dark)]
    }
    
    static func engineList() -> [EngineData] {
        return [EngineData(type: .Ecosia),EngineData(type: .Bing),
                EngineData(type: .Sougo),EngineData(type: .Jianshu)]
    }
    
    static func defaultSetting() -> [SettingData] {
        return [SettingData(type: .Theme), SettingData(type: .Engine)]
    }
}

struct ThemeData: Codable {
    var type: ThemeType
}

struct EngineData: Codable{
    var type: EngineType
}

protocol SettingDetailData{
    var defaultName: String { get }
    var defaultIcon: String { get }
    var title: String { get }
    var value: String { get }
    var icon: String  { get }
}

enum EngineType: Codable {
    case Ecosia
    case Bing
    case Sougo
    case Jianshu
}

extension EngineType: SettingDetailData {
    var defaultName: String {
        return "搜索引擎"
    }
    var defaultIcon: String {
        return "opticaldisc"
    }
    var title: String {
        switch self {
            case .Ecosia:
                return "Ecosia"
            case .Bing:
                return "必应"
            case .Sougo:
                return "搜狗"
            case .Jianshu:
                return "简书"
        }
    }
    
    var value: String {
        switch self {
            case .Ecosia:
                return "https://www.ecosia.org/search?q="
            case .Bing:
                return "https://cn.bing.com/search?q="
            case .Sougo:
                return "https://www.sogou.com/web?query="
            case .Jianshu:
                return "https://www.jianshu.com/search?q="
        }
    }
    
    var icon: String {
        switch self {
            case .Ecosia:
                return ""
            case .Bing:
                return ""
            case .Sougo:
                return ""
            case .Jianshu:
                return ""
        }
    }
}

enum ThemeType: Codable {
    case Normal
    case Night
    case Green
    case Dark
}

extension ThemeType: SettingDetailData {
    var defaultName: String {
        return "主题"
    }
    var defaultIcon: String {
        return "face.dashed.fill"
    }
    
    var title: String {
        switch self {
            case .Normal:
                return ""
            case .Night:
                return ""
            case .Green:
                return ""
            case .Dark:
                return ""
        }
    }
    
    var value: String {
        switch self {
            case .Normal:
                return ""
            case .Night:
                return ""
            case .Green:
                return ""
            case .Dark:
                return ""
        }
    }
    
    var icon: String {
        switch self {
            case .Normal:
                return ""
            case .Night:
                return ""
            case .Green:
                return ""
            case .Dark:
                return ""
        }
    }
}

enum SettingType {
    case Theme
    case Engine
}

extension SettingType: Codable {
    var dateil: SettingDetailData {
        switch self {
            case .Theme:
                return ThemeData(type: .Normal).type
            case .Engine:
                return EngineData(type: .Ecosia).type
        }
    }
}

struct SettingData: Codable {
    var type: SettingType
}
