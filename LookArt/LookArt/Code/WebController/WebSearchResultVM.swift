//
//  WebSearchResultVM.swift
//  LookArt
//
//  Created by CaiGou on 2021/12/24.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import Kingfisher
class WebSearchResultVM: BaseDataVM<WebSiteModel> {
    override init() {
        super.init()
    }
    
    override func bindDataSource(view: UIScrollView, disposeBag: DisposeBag) {
        guard let tableView = view as? UITableView else { return }
        data.bind(to: tableView.rx.items){(view, index, model) in
            let cell =  view.dequeueReusableCell(withClass: WebSearchResultCell.self)
            cell.imgView.kf.setImage(with:URL(string: model.favicon))
            cell.titleLab.text = model.title
            cell.subTitleLab.text = model.url
            return cell
        }.disposed(by: disposeBag)
    }
    
    override func updateDataSource() {
        data.accept(datasource)
    }
}
