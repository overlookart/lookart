//
//  SettingModel.swift
//  LookArt
//
//  Created by xzh on 2021/7/24.
//

import Foundation
class SettingModel{
    // 唯一标识
    var uuid: String = ""
    // 标题
    var title: String? = ""
    // 默认图标
    var defaltImg: String? = ""
    
    var keyString: String
    
    var valueString: String
    
    init(title: String?, defaltImg: String?, keyString: String, valueString: String) {
        self.title = title
        self.defaltImg = defaltImg
        self.keyString = keyString
        self.valueString = valueString
    }
}
