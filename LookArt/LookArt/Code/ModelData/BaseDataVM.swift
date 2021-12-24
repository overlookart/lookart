//
//  BaseDataVM.swift
//  LookArt
//
//  Created by CaiGou on 2021/12/24.
//

import Foundation
import RxSwift
import RxCocoa
class BaseDataVM<Model: ModelData> {
    var datasource: [Model] = []
    var data: BehaviorRelay<[Model]>
    init() {
        data = BehaviorRelay(value: datasource)
    }
    
    func bindDataSource<R1,R2>(binder: (BehaviorRelay<[Model]>)->(R1)->(R2), curriedArgument: R1) -> R2 {
        return data.bind(to: binder, curriedArgument: curriedArgument)
    }
}
