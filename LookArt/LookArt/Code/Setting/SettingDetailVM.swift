//
//  SettingDetailVM.swift
//  LookArt
//
//  Created by CaiGou on 2021/12/31.
//

import Foundation
import RxSwift
import RxCocoa
class SettingDetailVM: BaseDataVM<SettingDetailData> {
    
    override func bindDataSource(view: UIScrollView, disposeBag: DisposeBag) {
        guard let tableView = view as? UITableView else { return }
        data.bind(to: tableView.rx.items){(view, index, model) in
            let cell = view.dequeueReusableCell(withClass: SettingDetailCell.self)
            cell.setdata(data: model)
            return cell
        }.disposed(by: disposeBag)
    }
    
    override func updateDataSource() {
        data.accept(datasource)
    }
}
