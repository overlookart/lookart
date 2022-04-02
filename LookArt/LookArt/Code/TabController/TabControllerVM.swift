//
//  TabControllerVM.swift
//  LookArt
//
//  Created by xzh on 2021/11/14.
//

import Foundation
import RxCocoa
import RxSwift
class TabControllerVM: BaseDataVM<TabModel> {
    
    func bindDataSource(view: UICollectionView, disposeBag: DisposeBag) {
        data.bind(to: view.rx.items) {(collectionView, item, model) in
            let cell = collectionView.dequeueReusableCell(withClass: TabCell.self, for: IndexPath(item: item, section: 0))
            cell.imgView.image = model.image
            cell.closeAction = {
                self.removeModel(model)
            }
            return cell
        }.disposed(by: disposeBag)
    }
    
    override func addModel(_ model: TabModel) {
        model.webRoot.modalPresentationStyle = .fullScreen
        datasource.append(model)
        data.accept(datasource)
    }
    
    
    override func removeModel(_ model: TabModel) {
        datasource.removeAll { m in m == model }
        data.accept(datasource)
    }
    
}
