//
//  RealmController.swift
//  LookArt
//
//  Created by xzh on 2021/12/8.
//

import Foundation
import RealmSwift
import CryptoSwift
import SwiftyJSON
import CryptoKit
class RealmController {
    private static let instance = RealmController()
    class var share: RealmController {
        return instance
    }
    public typealias RealmSuccess = () -> Void
    public typealias Realmfailure = (Error) -> Void
    public typealias RealmActions = (Realm) -> Void
    public typealias RealmWhere<Element: Object> = (Query<Element>) -> Query<Element>
    var localRealm: Realm?
    
    private var currentSchemaVersion: UInt64 = 0
    /// 配置数据库
    static func configRealm() -> Bool {
        let documentsURL = (FileManager.default.documentsPath ?? "")+"/lookArt.realm"
        let config = Realm.Configuration(fileURL: URL(string: documentsURL), readOnly: false, schemaVersion: 0, migrationBlock: { (migration, oldSchemaVersion) in
            //进行数据库的迁移操作
        },  shouldCompactOnLaunch: { allSize, userSize in
            return true
        })
        
        do {
            instance.localRealm = try Realm(configuration: config, queue: nil)
            return true
        } catch let err as NSError {
            print(err.description)
            return false
        }
    }
    
}

// MARK: - Create, Read, Update, and Delete Objects
extension RealmController {
    
    /// 添加一条数据
    /// - Parameters:
    ///   - object: 数据模型
    ///   - update: 是否更新
    ///   - success: 成功回调
    ///   - failure: 失败回调
    static func add(_ object: Object, update: Realm.UpdatePolicy = .error, success: RealmSuccess? = nil, failure: Realmfailure? = nil){
        instance.realmAction { realm in
            realm.add(object, update: update)
            if let s = success { s() }
        } failure: { err in
            if let f = failure { f(err) }
        }

    }
    
    /// 添加多条数据
    /// - Parameters:
    ///   - objects: 数据模型数组
    ///   - update: 是否更新
    ///   - success: 成功回调
    ///   - failure: 成功回调
    static func addList(_ objects: Array<Object>, update: Realm.UpdatePolicy = .error, success: RealmSuccess? = nil, failure: Realmfailure? = nil){
        instance.realmAction { realm in
            realm.add(objects, update: update)
            if let s = success { s() }
        } failure: { err in
            if let f = failure { f(err) }
        }

    }
    
    
    /// 删除一条数据
    /// - Parameters:
    ///   - object: 数据模型
    ///   - success: 成功回调
    ///   - failure: 失败回调
    static func delete(_ object: Object, success: RealmSuccess? = nil, failure: Realmfailure? = nil){
        instance.realmAction { realm in
            realm.delete(object)
            if let s = success { s() }
        } failure: { err in
            if let f = failure { f(err) }
        }

    }
    
    
    /// 删除多条数据
    /// - Parameters:
    ///   - objects: 数据数组
    ///   - success: 成功回调
    ///   - failure: 失败回调
    static func deleteList(_ objects: Array<Object>, success: RealmSuccess? = nil, failure: Realmfailure? = nil){
        instance.realmAction { realm in
            realm.delete(objects)
            if let s = success { s() }
        } failure: { err in
            if let f = failure { f(err) }
        }

    }
    
    /// 删除数据库所有数据
    /// - Parameters:
    ///   - success: 成功回调
    ///   - failure: 失败回调
    static func deleteAll(_ success: RealmSuccess? = nil, failure: Realmfailure? = nil){
        instance.realmAction { realm in
            realm.deleteAll()
            if let s = success { s() }
        } failure: { err in
            if let f = failure { f(err) }
        }

    }
    
    
    /// 更新一条数据
    /// - Parameters:
    ///   - object: 数据模型
    ///   - update: 是否更新
    ///   - success: 成功回调
    ///   - failure: 失败回调
    static func update(_ object: Object, update: Realm.UpdatePolicy = .modified, success: RealmSuccess? = nil, failure: Realmfailure? = nil){
        instance.realmAction { realm in
            realm.add(object, update: update)
            if let s = success { s() }
        } failure: { err in
            if let f = failure { f(err) }
        }

    }
    
    /// 更新多条数据
    /// - Parameters:
    ///   - objects: 数据数组
    ///   - update: 是否更新
    ///   - success: 成功回调
    ///   - failure: 失败回调
    static func updateList(_ objects: Array<Object>, update: Realm.UpdatePolicy = .modified, success: RealmSuccess? = nil, failure: Realmfailure? = nil){
        instance.realmAction { realm in
            realm.add(objects, update: update)
            if let s = success { s() }
        } failure: { err in
            if let f = failure { f(err) }
        }
    }
    
    
    
    
    /// 更新一个一个对象的多个属性值（根据主键存在来更新，元素必须有主键）
    /// - Parameters:
    ///   - type: 数据类型
    ///   - value: 属性值
    ///   - update: 是否更新
    ///   - success: 成功回调
    ///   - failure: 失败回调
    static func updateAttribute(_ type: Object.Type, value: Any = [:], update: Realm.UpdatePolicy = .modified, success: RealmSuccess? = nil, failure: Realmfailure? = nil){
        instance.realmAction { realm in
            realm.create(type, value: value, update: update)
            if let s = success { s() }
        } failure: { err in
            if let f = failure { f(err) }
        }

    }
    
}

// MARK: - Realm Core 核心
extension RealmController {

    /// 查询类型数据
    /// - Parameter type: 数据类型
    /// - Parameter predicate: 查询条件
    /// - Parameter keyPath: 排序的键
    /// - Parameter ascending: 升序还是降序，默认升序
    /// - Returns: 查询结果
    func queryWith<object: Object>(type: object.Type, predicate: NSPredicate? = nil, keyPath: String? = nil, ascending: Bool = true) -> Results<object>? {
        let realm = localRealm
        var results = realm?.objects(type)
        if let _ = predicate {
            results = results?.filter(predicate!)
        }
        
        if let _ = keyPath {
            results = results?.sorted(byKeyPath: keyPath!, ascending: ascending)
        }
        return results
    }
    
    /// 查询类型数据
    /// - Parameter type: 数据类型
    /// - Parameter predicate: 查询条件
    /// - Parameter keyPath: 排序的键
    /// - Parameter ascending: 升序还是降序，默认升序
    /// - Returns: 查询结果
    func queryWith<object: Object>(type: object.Type, keyPath: String? = nil, ascending: Bool = true, rWhere: RealmWhere<object>? = nil) -> Results<object>? {
        let realm = localRealm
        var results = realm?.objects(type)
        if let _ = rWhere {
            results = results?.where(rWhere!)
        }
        if let _ = keyPath {
            results = results?.sorted(byKeyPath: keyPath!, ascending: ascending)
        }
        return results
    }
    
    /// 将 Results 转化为数组
    /// - Returns: 数组
    private func results<object: Object>(_ results: Results<object>) -> [object] {
        if results.count > 0 {
            let indexset = IndexSet(integersIn: results.startIndex ..< results.endIndex)
            return results.objects(at: indexset)
        }else{
            return []
        }
    }
    
    /// 数据库操作
    /// - Parameters:
    ///   - action: 写入回调
    ///   - failure: 失败回调
    private func realmAction(_ action: RealmActions, failure: Realmfailure? = nil) {
        let realm = localRealm
        do {
            try realm?.write({
                action(realm!)
            })
        } catch let err as NSError {
            if let f = failure { f(err) }
        }
    }
}

// MARK: - 历史记录的数据操作
extension RealmController {
    func insertHistory(url: URL, title: String) {
        if let reult = queryWith(type: HistoryData.self, rWhere: {
            $0.website.urlMD5 == url.absoluteString.md5()
        }), reult.count > 0 {
            print("更新历史数据")
            let history = reult[0]
            realmAction({realm in
                history.openTime = Date()
                history.website?.update(url: url, title: title,  favicon: "")
            }, failure: {err in
                
            })
        }else{
            print("新增历史数据")
            let website = WebSiteData(url: url, title: title,  favicon: "")
            let history = HistoryData(time: Date(), website: website)
            RealmController.add(history, success: {
                
            }, failure: {err in
                
            })
        }
    }
    
    func fetchHistory()->[HistoryData]{
        if let result = queryWith(type: HistoryData.self, rWhere: nil) {
            return results(result)
        }
        return []
    }
    
    func fetchOneHistory(url: String, success: @escaping(Any)->(), failure: @escaping(Error)->()){
        
    }
}
