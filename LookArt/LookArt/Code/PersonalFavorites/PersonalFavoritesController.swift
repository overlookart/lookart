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
    var currentItemContextMenuIndex: IndexPath?
    let personalFavoriteMV = PersonalFavoritesVM()
    let disposeBag = DisposeBag()
    
    lazy var contextMenuPreview: ContextMenuPreview = {
        let view = ContextMenuPreview.loadFromNib()
        return view
    }()
    
    let testView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        view.backgroundColor = UIColor.random
        return view
    }()
    var openWebSiteAction: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView.register(nibWithCellClass: PersonalFavoriteCell.self)
        personalFavoriteMV.bindDataSource(view: self.collectionView, disposeBag: disposeBag)
        self.collectionView.rx.modelSelected(WebSiteModel.self).subscribe(onNext: {websitemodel in
            self.openWebSiteAction?(websitemodel.url)
        }).disposed(by: disposeBag)
        
        self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)

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


extension PersonalFavoritesController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        self.currentItemContextMenuIndex = indexPath
        let cell = collectionView.cellForItem(at: indexPath)
        self.contextMenuPreview.center = cell?.center ?? point
        let width = CGFloat.minimum(UIScreen.ScreenWidth(), UIScreen.ScreenHeight()) - 20
        self.contextMenuPreview.size = CGSize(width: width, height: 150)
        self.view.addSubview(self.contextMenuPreview)
        self.view.sendSubviewToBack(self.contextMenuPreview)
        let action1 = UIAction(title: "拷贝", image: UIImage(systemName: "doc.on.doc"), identifier: .none, discoverabilityTitle: nil, attributes: .init(rawValue: 0), state: .off) { (action) in
        }
        

        let action2 = UIAction(title: "在新标签页中打开", image: UIImage(systemName: "plus.square.on.square"), identifier: .none, discoverabilityTitle: nil, attributes: .init(rawValue: 0), state: .off) { (action) in
            
        }
        
        let action3 = UIAction(title: "编辑", image: UIImage(systemName: "square.and.pencil"), identifier: .none, discoverabilityTitle: nil, attributes: .init(rawValue: 0), state: .off) { (action) in
            
        }
        let action4 = UIAction(title: "删除", image: UIImage(systemName: "trash"), identifier: .none, discoverabilityTitle: nil, attributes: .destructive, state: .off) { (action) in
            
        }
        
        
        let contextMenu = UIContextMenuConfiguration(identifier: nil) { () -> UIViewController? in
            return nil
        } actionProvider: { (elements) -> UIMenu? in
            let menu = UIMenu(title: "", image: nil, identifier: .view, options: .displayInline, children: [action1,action2,action3,action4])
            
            return menu
        }
        
        return contextMenu
    }
    
    func collectionView(_ collectionView: UICollectionView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        // preview 要有完整的布局约束，否则旋转屏幕后有显示问题
        let preview = UITargetedPreview(view: self.contextMenuPreview)
        return preview
    }
    
    func collectionView(_ collectionView: UICollectionView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        let preview = UITargetedPreview(view: self.contextMenuPreview)
        return preview
    }
    
    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        print("ContextMenu:点击预览")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        print("ContextMenu:将要展示")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        print("ContextMenu:将要隐藏")
    }
    
}

extension PersonalFavoritesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat.minimum(UIScreen.ScreenWidth(), UIScreen.ScreenHeight())
        //92:140
        let itemWidth = (width - 50) / 4
        let itemHeight = itemWidth * 140 / 92
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

