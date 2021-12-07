//
//  TabControllerVM.swift
//  LookArt
//
//  Created by xzh on 2021/11/14.
//

import Foundation
import RxCocoa
import RxSwift
class TabControllerVM {
    private(set) var dataSource: [TabModel] = []
    let data: BehaviorRelay<[TabModel]>
    init() {
        data = BehaviorRelay(value: dataSource)
        addData()
    }
    func bindDataSource(view: UICollectionView, disposeBag: DisposeBag) {
        data.bind(to: view.rx.items) {(collectionView, item, model) in
            let cell = collectionView.dequeueReusableCell(withClass: TabCell.self, for: IndexPath(item: item, section: 0))
            cell.imgView.image = model.image
            cell.closeAction = {
                self.deleteData(index: item)
            }
            return cell
        }.disposed(by: disposeBag)
    }
    
    func addData(){
        let model = TabModel(title: "起始页", image: UIImage(color: UIColor.gray, size: CGSize(width: 1, height: 1)), webRoot: WebNavigationController())
        model.webRoot.modalPresentationStyle = .fullScreen
        dataSource.append(model)
        data.accept(dataSource)
    }
    
    /// 删除一条数据
    /// - Parameter index: 下标
    func deleteData(index: Int){
        dataSource.remove(at: index)
        data.accept(dataSource)
    }
}
