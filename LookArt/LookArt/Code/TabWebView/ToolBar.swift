//
//  ToolBar.swift
//  LookArt
//
//  Created by xzh on 2021/2/14.
//

import UIKit

class ToolBar: UIToolbar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    private(set) var backBtnItem: UIBarButtonItem!
    private(set) var forwardBtnItem: UIBarButtonItem!
    private(set) var actionBtnItem: UIBarButtonItem!
    private(set) var bookmarkBtnItem: UIBarButtonItem!
    private(set) var tabmarkBtnItem: UIBarButtonItem!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupItems() {
        self.backBtnItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: nil, action: nil)
        let item2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.forwardBtnItem = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .done, target: nil, action: nil)
        let item4 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.actionBtnItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: nil, action: nil)
        let item6 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.bookmarkBtnItem = UIBarButtonItem(image: UIImage(systemName: "book"), style: .done, target: nil, action: nil)
        let item8 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.tabmarkBtnItem = UIBarButtonItem(image: UIImage(systemName: "square.on.square"), style: .done, target: nil, action: nil)
        self.items = [self.backBtnItem,item2,self.forwardBtnItem,item4,self.actionBtnItem,item6,self.bookmarkBtnItem,item8,self.tabmarkBtnItem]
    }
}
