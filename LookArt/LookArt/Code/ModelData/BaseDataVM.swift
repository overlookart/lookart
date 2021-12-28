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
    
    /// 更新数据源
    func updateDataSource(){
        
    }
}
