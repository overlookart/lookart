//
//  WebSiteModel.swift
//  LookArt
//
//  Created by xzh on 2021/4/5.
//

import Foundation
class WebSiteModel {
    var title: String
    var url: String
    var favicon: String
    init(title: String, url: String, favicon: String = "") {
        self.title = title
        self.url = url
        self.favicon = favicon
    }
}
