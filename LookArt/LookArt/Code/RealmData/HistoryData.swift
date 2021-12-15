//
//  HistoryData.swift
//  LookArt
//
//  Created by CaiGou on 2021/12/15.
//

import Foundation
import RealmSwift
class HistoryData: Object {
    @Persisted var openTime: Date
    @Persisted var website: WebSiteData?
    convenience init(time: Date, website: WebSiteData){
        self.init()
        self.openTime = time
        self.website = website
    }
}
