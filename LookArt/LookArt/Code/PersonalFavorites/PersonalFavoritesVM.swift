//
//  PersonalFavoritesVM.swift
//  LookArt
//
//  Created by xzh on 2021/4/5.
//

import Foundation
import RxSwift
class PersonalFavoritesVM {
    let data = Observable.just([WebSiteModel(title: "Apple", url: "https://www.apple.com"),WebSiteModel(title: "bing", url: "https://www.bing.com"),WebSiteModel(title: "百度大法师", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com")])
    
    
    
    
    
    func bindDataSource(view: UICollectionView, disposeBag: DisposeBag) {
         data.bind(to: view.rx.items) {(collectionview, item, websitemodel) in
            let cell = collectionview.dequeueReusableCell(withClass: PersonalFavoriteCell.self, for: IndexPath(item: item, section: 0))
            cell.titleLab.text = websitemodel.title
            return cell
         }.disposed(by: disposeBag)
        
        
        
        
    }
    
}
