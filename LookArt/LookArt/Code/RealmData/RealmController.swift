//
//  RealmController.swift
//  LookArt
//
//  Created by CaiGou on 2021/12/8.
//

import Foundation
import RealmSwift
import CryptoSwift
class RealmController {
    private static let instance = RealmController()
    class var share: RealmController {
        return instance
    }
    
   
    let localRealm = try! Realm()
    func configCoreStore() {
        
    }
    
}

// MARK: - Create, Read, Update, and Delete Objects
extension RealmController {
    func addObject(object: Object) {
        try! self.localRealm.write {
            self.localRealm.add(object)
        }
    }
    
    
    
    /// 读取所有的数据
    /// - Parameter type: 数据类型
    /// - Returns: 结果
    func readAllObjects(type: Object.Type) -> Results<Object>{
        let objects =  self.localRealm.objects(type)
        return objects
    }
    
    func updateObject(obj: Object){
        
    }
    
}


// MARK: - 历史记录的数据操作
extension RealmController {
    func insertHistory(url: URL, title: String) {
        let reult = self.localRealm.objects(HistoryData.self).where {
            $0.website.urlMD5 == url.absoluteString.md5()
        }
        if reult.count > 0 {
            print("更新历史数据")
            let history = reult[0]
            try! self.localRealm.write({
                history.openTime = Date()
                history.website?.update(url: url, title: title,  favicon: "")
            })
            
        }else{
            print("新增历史数据")
            let website = WebSiteData(url: url, title: title,  favicon: "")
            let history = HistoryData(time: Date(), website: website)
            self.addObject(object: history)
        }
        
    }
    
    func fetchHistory(){
        let histories = self.localRealm.objects(HistoryData.self)
        print(histories)
    }
    
    func fetchOneHistory(url: String, success: @escaping(Any)->(), failure: @escaping(Error)->()){
        
    }
}
