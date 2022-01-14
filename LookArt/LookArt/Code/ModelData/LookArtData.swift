//
//  LookArtData.swift
//  LookArt
//
//  Created by xzh on 2021/12/28.
//

import Foundation
import Disk
class LookArtData {
    private static let instance = LookArtData()
    class var share: LookArtData {
        return instance
    }
    
    func config(){
        
    }
}

extension LookArtData {
    static func themeList() -> [ThemeType] {
        return [.Normal, .Night, .Green, .Dark, .NigthDark]
    }
    
    static func engineList() -> [EngineType] {
        return [.Ecosia, .Bing, .Sougo, .Jianshu]
    }
    
    
    
    
    /// 储存主题数据
    /// - Parameter theme: 主题
    static func saveSettingTheme(theme: ThemeType){
        do {
            try Disk.save(theme , to: .caches, as: "Setting/theme.json")
        } catch let err {
            print(err)
        }
    }
    
    /// 储存搜索引擎数据
    /// - Parameter engine: 搜索引擎
    static func saveSettingEngine(engine: EngineType) {
        try! Disk.save(engine, to: .caches, as: "Setting/engine.json")
    }
    
    /// 存储设置数据
    /// - Parameter data: 设置数据
    static func saveSettingData(data: SettingDetailData) {
        switch data.type {
            case .Theme:
                LookArtData.saveSettingTheme(theme: data as! ThemeType)
            case .Engine:
                LookArtData.saveSettingEngine(engine: data as! EngineType)
        }
    }
    
    /// 获取设置主题数据
    /// - Returns: 主题
    static func settingTheme() -> ThemeType {
        if let theme = try? Disk.retrieve("Setting/theme.json", from: .caches, as: ThemeType.self) {
            return theme
        }else{
            return ThemeType.Normal
        }
    }
    
    /// 获取设置搜索引擎数据
    /// - Returns: 搜索引擎
    static func settingEngine() -> EngineType {
        if let engine = try? Disk.retrieve("Setting/engine.json", from: .caches, as: EngineType.self) {
            return engine
        }else{
            return EngineType.Ecosia
        }
    }
    
    
    /// 获取设置列表数据
    /// - Returns: 设置数据
    static func SettingList() -> [SettingDetailData] {
        var list: [SettingDetailData] = []
        list.append(LookArtData.settingTheme())
        list.append(LookArtData.settingEngine())
        return list
    }
}



protocol SettingDetailData: Codable{
    var defaultName: String { get }
    var defaultIcon: String { get }
    var type: SettingType { get }
    var title: String { get }
    var value: String { get }
    var icon: String  { get }
}



// MARK: - theme data core

enum ThemeType {
    case Normal
    case Night
    case Green
    case Dark
    case NigthDark
}

extension ThemeType: SettingDetailData {
    var defaultName: String {
        return "主题"
    }
    var defaultIcon: String {
        return "face.dashed.fill"
    }
    var type: SettingType {
        return .Theme
    }
    var title: String {
        switch self {
            case .Normal:
                return "默认"
            case .Night:
                return "夜间"
            case .Green:
                return "绿色"
            case .Dark:
                return "暗黑"
            case .NigthDark:
                return "深夜"
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
            case .NigthDark:
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
            case .NigthDark:
                return ""
        }
    }
}




// MARK: - engine data core

enum EngineType {
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
    var type: SettingType {
        return .Engine
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



// MARK: - setting data core

enum SettingType {
    case Theme
    case Engine
}


