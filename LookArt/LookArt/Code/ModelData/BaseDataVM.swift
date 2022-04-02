//
//  BaseDataVM.swift
//  LookArt
//
//  Created by xzh on 2021/12/24.
//

import Foundation
import RxSwift
import RxCocoa
class BaseDataVM<Model> {
    var datasource: [Model] = []
    var data: BehaviorRelay<[Model]>
    init() {
        data = BehaviorRelay(value: datasource)
    }
    
    
    /// 绑定数据源
    /// - Parameters:
    ///   - view: tableView or collectionView
    ///   - disposeBag: 回收池
    func bindDataSource(view: UIScrollView, disposeBag: DisposeBag){
        
    }
    
    /// 添加一条数据模型
    /// - Parameter model: 数据模型 泛型
    func addModel(_ model: Model){
        
    }
    
    /// 添加一组数据模型
    /// - Parameter models: 数据模型数组 泛型
    func addModels(_ models: [Model]){
        
    }
    
    
    /// 移除一条数据模型
    /// - Parameter model: 数据模型 泛型
    func removeModel(_ model: Model) {
        
    }
    
    
    /// 移除一组数据模型
    /// - Parameter models: 数据模型数组 泛型
    func removeModels(_ models: [Model]) {
        
    }
    
    /// 更新数据源
    func updateDataSource(){
        
    }
}
