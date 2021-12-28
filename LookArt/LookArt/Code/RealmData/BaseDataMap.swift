//
//  BaseDataMap.swift
//  LookArt
//
//  Created by xzh on 2021/12/20.
//

import Foundation
import ObjectMapper
import RealmSwift
class BaseDataMap: Object {
    @Persisted var defStr: String? = ""
    
    override init() {
        
    }
}
