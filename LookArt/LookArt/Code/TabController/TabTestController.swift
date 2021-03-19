//
//  TabController.swift
//  LookArt
//
//  Created by xzh on 2021/2/27.
//

import UIKit

private let reuseIdentifier = "Cell"

class TabTestController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        collectionView.backgroundColor = UIColor.random
        // Register cell classes
        self.registerCellClasses()
        
        addTab()
        addTab()
        addTab()
        addTab()
        addTab()
        addTab()
        addTab()
        addTab()
        addTab()
        
        // Do any additional setup after loading the view.
        
        self.collectionView.setCollectionViewLayout(TabLayout(), animated: false)
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        children.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: TabCell.self, for: indexPath)
        cell.contentView.backgroundColor = UIColor.random
        // Configure the cell
//        cell.imgView.image = children[indexPath.item].view.screenshot
        cell.imgView.backgroundColor = UIColor.random
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.view.addSubview(children[indexPath.item].view)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
