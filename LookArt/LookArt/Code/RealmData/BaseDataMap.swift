//
//  BaseDataMap.swift
//  LookArt
//
//  Created by CaiGou on 2021/12/20.
//

import Foundation
import ObjectMapper
import RealmSwift
class BaseDataMap: Object, Mappable {
    
    override init() {
        
    }
    
    required init?(map: ObjectMapper.Map) {

    }
    
    func mapping(map: ObjectMapper.Map) {

    }
}
