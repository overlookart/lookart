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
        collectionView.insertItems(at: [IndexPath(item: webs.count-1, section: 0)])
    }
    @IBAction func completeAction(_ sender: Any) {
        addChild(currectWeb)
        view.addSubview(currectWeb.view)
    }
    @IBOutlet weak var collectionView: UICollectionView!
    private var webs: [WebNavigationController] = []
    private var currectWeb: WebNavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.random
        registerCellClasses()
        addTab()
        self.collectionView.setCollectionViewLayout(TabLayout(), animated: false)
        // Do any additional setup after loading the view.
        if let firstweb = webs.first {
            addChild(firstweb)
            view.addSubview(firstweb.view)
            currectWeb = firstweb
        }
        
    }

    private func registerCellClasses() {
        self.collectionView.register(nibWithCellClass: TabCell.self)
    }
    
    private func addTab() {
        let nav = WebNavigationController()
        nav.modalPresentationStyle = .fullScreen
        self.webs.append(nav)
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
        return webs.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: TabCell.self, for: indexPath)
        cell.contentView.backgroundColor = UIColor.random
        cell.imgView.backgroundColor = UIColor.random
        cell.closeAction = {
            if let ide = collectionView.indexPath(for: cell) {
                self.webs.remove(at: ide.item)
                self.collectionView.deleteItems(at: [ide])
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currectWeb = webs[indexPath.row]
        addChild(currectWeb)
        view.addSubview(currectWeb.view)
    }
    
}

//MARK: - tool bar btn action
extension TabController {
    
}
