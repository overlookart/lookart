//
//  TabController.swift
//  LookArt
//
//  Created by xzh on 2021/3/19.
//

import UIKit
import RxSwift
import CollectionViewPagingLayout
class TabController: UIViewController {
    let tabControllerVM = TabControllerVM()
    let disposeBag = DisposeBag()
    private var currectWeb: TabModel!
    @IBAction func addTabAction(_ sender: Any) {
        addTab()
    }
    
    @IBAction func completeAction(_ sender: Any) {
        self.present(currectWeb.webNavigationVC, animated: true, completion: nil)
    }
    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
//    private var webs: [WebNavigationController] = []
    
    
    /// 切换 layout 按钮事件
    /// - Parameter sender: <#sender description#>
    @IBAction func layoutAction(_ sender: Any) {
        if let btn: UIButton = sender as? UIButton {
            btn.isSelected = !btn.isSelected
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.clear
        self.backgroundImage()
        registerCellClasses()
        tabControllerVM.bindDataSource(view: collectionView, disposeBag: disposeBag)
        let layout = CollectionViewPagingLayout()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.isPagingEnabled = true
        // Do any additional setup after loading the view.
        if let firstweb = tabControllerVM.datasource.first{
            currectWeb = firstweb
        }
        
        collectionView.rx.modelSelected(TabModel.self).subscribe(onNext:{ model in
            self.currectWeb = model
            self.present(model.webNavigationVC, animated: true, completion: nil)
            debugPrint("CollectionView Rx modelSelected")
        }).disposed(by: disposeBag)
        
        collectionView.rx.itemSelected.subscribe(onNext: {indexPath in
            debugPrint("CollectionView Rx itemSelected")
        }).disposed(by: disposeBag)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }

    private func registerCellClasses() {
        self.collectionView.register(nibWithCellClass: TabCell.self)
    }
    
    /// 添加一个新的标签 并且打开该标签
    private func addTab() {
        let newTabModel = TabModel(title: "起始页", image: UIImage(color: UIColor.random, size: CGSize(width: 1, height: 1)), webNavigationVC: WebNavigationController())
        tabControllerVM.addModel(newTabModel)
        if let layout = self.collectionView.collectionViewLayout as? CollectionViewPagingLayout {
            layout.setCurrentPage(self.tabControllerVM.datasource.count - 1)
        }
//        collectionView.performBatchUpdates {
//            tabControllerVM.addModel(newTabModel)
//        } completion: { isFinish in
            
//        }

        currectWeb = newTabModel
//        present(currectWeb.webRoot, animated: true)
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

//MARK: - tool bar btn action
extension TabController {
    func backgroundImage(){
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x:0, y:0);
        layer.endPoint = CGPoint(x:1, y:1);
        layer.frame = self.bgImgView.frame
        layer.colors = [UIColor.random.cgColor, UIColor.random.cgColor,UIColor.random.cgColor]
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.isOpaque, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        layer.render(in: context)
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        self.bgImgView.image = img
    }
}


extension TabController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50*indexPath.item, height: 50*indexPath.item)
    }
}
