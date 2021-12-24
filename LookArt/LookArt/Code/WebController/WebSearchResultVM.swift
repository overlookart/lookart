//
//  WebSearchResultVM.swift
//  LookArt
//
//  Created by CaiGou on 2021/12/24.
//

import Foundation
import RxSwift
import RxCocoa
class WebSearchResultVM {
    private(set) var datasource: [WebSiteModel] = []
    let data: BehaviorRelay<[WebSiteModel]>
    init() {
        self.data = BehaviorRelay(value: datasource)
    
    }
    
    func bindDataSource(){
        
    }
}
