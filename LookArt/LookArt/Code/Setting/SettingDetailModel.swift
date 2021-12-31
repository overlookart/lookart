//
//  SettingDetailModel.swift
//  LookArt
//
//  Created by xzh on 2021/12/28.
//

import Foundation
import ObjectMapper
class SettingDetailModel: ModelData {
    var title: String
    init(title: String) {
        self.title = title
        super.init()
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}
