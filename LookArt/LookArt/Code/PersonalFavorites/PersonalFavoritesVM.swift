//
//  PersonalFavoritesVM.swift
//  LookArt
//
//  Created by xzh on 2021/4/5.
//

import Foundation
import RxSwift
class PersonalFavoritesVM {
    let data = Observable.just([WebSiteModel(title: "Apple", url: "https://www.apple.com"),WebSiteModel(title: "bing", url: "https://www.bing.com"),WebSiteModel(title: "智能表单", url: "http://testmform.caigou2003.com/#/?formId=202107270946440446&platform=4&source=2"),WebSiteModel(title: "目录页", url: "http://testmform.caigou2003.com/#/list?catalogId=470880983999053824&source=2&platform=4"),WebSiteModel(title: "京训钉", url: "https://www.bjjnts.cn"),WebSiteModel(title: "易采通", url: "https://www.caigou2003.com"),WebSiteModel(title: "精彩天添", url: "https://testmalladmin.caigou2003.com/#/login"),WebSiteModel(title: "本地服务", url: ""),WebSiteModel(title: "研修班", url: "https://kaifa.caigou2003.com/weixin/api/detail?id=156"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com"),WebSiteModel(title: "百度", url: "https://www.baidu.com")])
    
    
    
    
    
    func bindDataSource(view: UICollectionView, disposeBag: DisposeBag) {
         data.bind(to: view.rx.items) {(collectionview, item, websitemodel) in
            let cell = collectionview.dequeueReusableCell(withClass: PersonalFavoriteCell.self, for: IndexPath(item: item, section: 0))
            cell.titleLab.text = websitemodel.title
            return cell
         }.disposed(by: disposeBag)
        
        
        
        
    }
    
}
