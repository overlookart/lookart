//
//  TabController.swift
//  LookArt
//
//  Created by xzh on 2021/3/19.
//

import UIKit
import RxSwift
class TabController: UIViewController {
    let tabControllerVM = TabControllerVM()
    let disposeBag = DisposeBag()
    private var currectWeb: TabModel!
    @IBAction func addTabAction(_ sender: Any) {
        addTab()
    }
    @IBAction func completeAction(_ sender: Any) {
        self.present(currectWeb.webRoot, animated: true, completion: nil)
    }
    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
//    private var webs: [WebNavigationController] = []
    
    @IBAction func layoutAction(_ sender: Any) {
        if let btn: UIButton = sender as? UIButton {
            btn.isSelected = !btn.isSelected
            if btn.isSelected {
                collectionView.setCollectionViewLayout(TabGridLayout(), animated: true)
            }else{
                collectionView.setCollectionViewLayout(TabLayout(), animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.backgroundColor = UIColor.random
        collectionView.backgroundColor = UIColor.clear
        self.backgroundImage()
        registerCellClasses()
        tabControllerVM.bindDataSource(view: collectionView, disposeBag: disposeBag)
        self.collectionView.setCollectionViewLayout(TabGridLayout(), animated: false)
        // Do any additional setup after loading the view.
        if let firstweb = tabControllerVM.dataSource.first{
            currectWeb = firstweb
        }
//        collectionView.delegate = self
        collectionView.rx.modelSelected(TabModel.self).subscribe(onNext:{ model in
            self.present(model.webRoot, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }

    private func registerCellClasses() {
        self.collectionView.register(nibWithCellClass: TabCell.self)
    }
    
    private func addTab() {
        tabControllerVM.addData()
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
