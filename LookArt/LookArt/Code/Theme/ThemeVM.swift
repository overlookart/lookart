//
//  ThemeVM.swift
//  LookArt
//
//  Created by xzh on 2021/10/11.
//

import Foundation
import RxSwift
struct ThemeVM {
    let data = Observable.just([ThemeModel(title: "默认", name: "Normal"), ThemeModel(title: "夜间", name: "Night"), ThemeModel(title: "绿色", name: "Green"), ThemeModel(title: "暗黑", name: "Dark")])
    
    func bindDataSource(view: UITableView, disposeBag: DisposeBag){
        data.bind(to: view.rx.items){(tableview, index, model) in
            let cell = tableview.dequeueReusableCell(withClass: ThemeViewCell.self)
            cell.titleLab.text = model.title
            return cell
        }.disposed(by: disposeBag)
    }
}
