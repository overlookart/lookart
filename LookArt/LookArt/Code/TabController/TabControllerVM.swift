//
//  TabControllerVM.swift
//  LookArt
//
//  Created by xzh on 2021/11/14.
//

import Foundation
import RxCocoa
import RxSwift
import CollectionViewPagingLayout
class TabControllerVM: BaseDataVM<TabModel> {
    
    var collectionView: UICollectionView?
    
    func bindDataSource(view: UICollectionView, disposeBag: DisposeBag) {
        collectionView = view
        data.bind(to: view.rx.items) {(collectionView, item, model) in
            let indexPath = IndexPath(item: item, section: 0)
            let cell = collectionView.dequeueReusableCell(withClass: TabCell.self, for: indexPath)
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
        guard let removeIndex = datasource.firstIndex(of: model) else { return }
        debugPrint(removeIndex)
        
        self.datasource.removeAll { m in m == model }
        self.data.accept(self.datasource)
        DispatchQueue.main.async {
            if let layout = self.collectionView?.collectionViewLayout as? CollectionViewPagingLayout {
                layout.invalidateLayoutInBatchUpdate(invalidateOffset: true)
            }
        }
        
    }
    
}
