//
//  PersonalFavoritesController.swift
//  LookArt
//
//  Created by xzh on 2021/4/5.
//

import UIKit
import RxSwift
import RxCocoa
class PersonalFavoritesController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let personalFavoriteMV = PersonalFavoritesVM()
    let disposeBag = DisposeBag()
    
    var openWebSiteAction: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.register(nibWithCellClass: PersonalFavoriteCell.self)
        personalFavoriteMV.bindDataSource(view: self.collectionView, disposeBag: disposeBag)
        self.collectionView.rx.modelSelected(WebSiteModel.self).subscribe(onNext: {websitemodel in
            self.openWebSiteAction?(websitemodel.url)
        }).disposed(by: disposeBag)
        
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
