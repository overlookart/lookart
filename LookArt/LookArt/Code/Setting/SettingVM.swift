//
//  SettingVM.swift
//  LookArt
//
//  Created by xzh on 2021/7/24.
//

import Foundation
import RxSwift
import UIKit
class SettingVM: BaseDataVM<SettingData> {
    
    
    
    /// 绑定数据
    /// - Parameters:
    ///   - view: tableview
    ///   - disposeBag: 回收站
    override func bindDataSource(view: UIScrollView, disposeBag: DisposeBag) {
        guard let tableView = view as? UITableView else { return }
        data.bind(to: tableView.rx.items) {(view, index, model) in
            let cell = view.dequeueReusableCell(withClass: SettingViewCell.self)
            cell.imgView.image = UIImage(systemName: model.type.dateil.defaultIcon)
            cell.titleLab.text = model.type.dateil.defaultName
            return cell
        }.disposed(by: disposeBag)
    }
    
    
    override func updateDataSource() {
        self.datasource.append(contentsOf: LookArtData.defaultSetting())
        data.accept(self.datasource)
    }
    
    
}
