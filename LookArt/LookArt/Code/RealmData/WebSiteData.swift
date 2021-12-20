//
//  WebSiteModel.swift
//  LookArt
//
//  Created by CaiGou on 2021/12/15.
//

import Foundation
import RealmSwift
import ObjectMapper
class WebSiteData:BaseDataMap {
    @Persisted var title: String?
    @Persisted var urlStr: String
    @Persisted var urlMD5: String
    @Persisted var domain: String
    @Persisted var favicon: String
    convenience init(url: URL, title: String?=nil, favicon: String){
        self.init()
        self.urlStr = url.absoluteString
        self.urlMD5 = self.urlStr.md5()
        self.domain = url.host ?? ""
        self.favicon = ((url.scheme ?? "") + "://" + self.domain) + "/favicon.ico"
        self.title = title
    }
    
    func update(url: URL, title: String?=nil, favicon: String){
        self.urlStr = url.absoluteString
        self.urlMD5 = urlStr.md5()
        self.domain = url.host ?? ""
        self.favicon = ((url.scheme ?? "") + "://" + self.domain) + "/favicon.ico"
        self.title = title
    }
    required init?(map: ObjectMapper.Map) {
        super.init(map: map)
    }
    override func mapping(map: ObjectMapper.Map) {
        super.mapping(map: map)
        title <- map["title"]
        urlStr <- map["urlStr"]
        urlMD5 <- map["urlMD5"]
        domain <- map["domain"]
        favicon <- map["favicon"]
    }
}


