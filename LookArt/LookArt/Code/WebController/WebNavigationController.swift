//
//  WebNavigationController.swift
//  LookArt
//
//  Created by xzh on 2021/3/23.
//

import UIKit
import RxSwift
import RxCocoa
class WebNavigationController: BaseNavigationController {
    
    var webController: WebController
    private(set) var backBtnItem: UIBarButtonItem!
    private(set) var forwardBtnItem: UIBarButtonItem!
    private(set) var actionBtnItem: UIBarButtonItem!
    private(set) var bookmarkBtnItem: UIBarButtonItem!
    private(set) var tabmarkBtnItem: UIBarButtonItem!
    
    init() {
        self.webController = WebController()
        super.init(rootViewController: self.webController)
        self.backBtnItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: nil, action: nil)
        
        let item2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.forwardBtnItem = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .plain, target: nil, action: nil)
        let item4 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.actionBtnItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: nil, action: nil)
        let item6 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.bookmarkBtnItem = UIBarButtonItem(image: UIImage(systemName: "book"), style: .plain, target: nil, action: nil)
        let item8 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.tabmarkBtnItem = UIBarButtonItem(image: UIImage(systemName: "square.on.square"), style: .plain, target: self, action: #selector(tabMarkBtnAction))
        self.toolbarItems = [self.backBtnItem,item2,self.forwardBtnItem,item4,self.actionBtnItem,item6,self.bookmarkBtnItem,item8,self.tabmarkBtnItem]
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc private func tabMarkBtnAction() {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    func setToolBar(webController: WebController) {
        webController.setToolbarItems(self.toolbarItems, animated: true)
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
