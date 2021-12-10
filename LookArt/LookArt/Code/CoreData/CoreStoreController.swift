//
//  CoreStoreController.swift
//  LookArt
//
//  Created by CaiGou on 2021/12/8.
//

import Foundation
import CoreStore
class CoreStoreController {
    private static let instance = CoreStoreController()
    class var share: CoreStoreController {
        return instance
    }
    
    var dataStack = DataStack(xcodeModelName: "LookArtModel", bundle: Bundle.main, migrationChain: [])
    func configCoreStore() {
        let sqliteStore = SQLiteStore(fileName: "LookArt.sqlite", configuration: "Default", localStorageOptions: .recreateStoreOnModelMismatch)
        let migrationProgress = dataStack.addStorage(sqliteStore, completion: { (result) in
            switch result{
                case .success(let sqlitestore):
                    print("Successfully added sqlite store: \(sqlitestore)")
                case .failure(let error):
                    print("Failed adding sqlite store with error: \(error)")
            }
        })
        CoreStoreDefaults.dataStack = dataStack
    }
    
}

// MARK: - 历史记录的数据操作
extension CoreStoreController {
    func insertHistory(url: String, title: String, domain: String, favicon: String) {
        CoreStoreDefaults.dataStack.perform(asynchronous: {(transaction) in
            let history = transaction.create(Into<History>())
            history.website?.url = url
            history.website?.title = title
            history.website?.domain = domain
            history.website?.favicon = favicon
            history.openTime = Date()
        }, success: {(result) in
            print("插入数据成功")
        }, failure: {(error) in
            print("插入数据失败",error)
        })
    }
    
    func fetchHistory(){
        CoreStoreDefaults.dataStack.perform(asynchronous: {(transaction) in
            let histories = try transaction.fetchAll(From<History>())
            for history in histories {
                print(history)
            }
        }, success: {(result) in
            print("查询数据成功")
        }, failure: {(error) in
            print("查询数据失败",error)
        })
    }
    
    func fetchOneHistory(url: String){
        CoreStoreDefaults.dataStack.perform(asynchronous: {(transaction) in
            
        }, success: {(result) in
            
        }, failure: {(error) in
            
        });
    }
}
