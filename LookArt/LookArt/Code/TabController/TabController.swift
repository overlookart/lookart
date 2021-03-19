//
//  TabController.swift
//  LookArt
//
//  Created by xzh on 2021/3/19.
//

import UIKit

class TabController: UIViewController {
    @IBAction func addTabAction(_ sender: Any) {
        addTab()
        collectionView.insertItems(at: [IndexPath(item: children.count-1, section: 0)])
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.random

        registerCellClasses()
        
        addTab()
        addTab()
        addTab()
        self.collectionView.setCollectionViewLayout(TabLayout(), animated: false)
        // Do any additional setup after loading the view.
    }

    private func registerCellClasses() {
        self.collectionView.register(nibWithCellClass: TabCell.self)
    }
    
    private func addTab() {
        let webc = WebController()
        let nav = UINavigationController(navigationBarClass: WebSearchBar.self, toolbarClass: ToolBar.self)
        nav.setViewControllers([webc], animated: false)
        nav.modalPresentationStyle = .fullScreen
        addChild(nav)
        
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





extension TabController: UICollectionViewDelegate {
    
}

extension TabController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return children.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: TabCell.self, for: indexPath)
        cell.contentView.backgroundColor = UIColor.random
        cell.imgView.backgroundColor = UIColor.random
        cell.closeAction = {
            if let ide = collectionView.indexPath(for: cell) {
                self.children[ide.item].removeFromParent()
                self.collectionView.deleteItems(at: [ide])
            }
            
        }
        return cell
    }
    
}

//MARK: - tool bar btn action
extension TabController {
    
}
