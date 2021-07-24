//
//  SettingVM.swift
//  LookArt
//
//  Created by xzh on 2021/7/24.
//

import Foundation
import RxSwift
class SettingVM {
    let data = Observable.just([SettingModel(title: "主题", defaltImg: "face.dashed.fill")])
    
    
    /// 绑定数据
    /// - Parameters:
    ///   - view: tableview
    ///   - disposeBag: 回收站
    func bindDataSource(view: UITableView, disposeBag: DisposeBag) {
        data.bind(to: view.rx.items){(tableview, index, model) in
            let cell = tableview.dequeueReusableCell(withClass: SettingViewCell.self)
            cell.titleLab.text = model.title
            cell.imageView?.image = UIImage(systemName: model.defaltImg ?? "")
            return cell
        }.disposed(by: disposeBag)
    }
}
