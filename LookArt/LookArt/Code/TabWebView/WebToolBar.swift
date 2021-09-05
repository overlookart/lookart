//
//  WebToolBar.swift
//  LookArt
//
//  Created by CaiGou on 2021/9/3.
//

import UIKit
import RxSwift
import RxCocoa
class WebToolBar: UIToolbar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    /// 后退
    private(set) var backBtnItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: nil, action: nil)
    /// 前进
    private(set) var forwardBtnItem = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .plain, target: nil, action: nil)
    
    private(set) var actionBtnItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: nil, action: nil)
    /// 书签
    private(set) var bookmarkBtnItem = UIBarButtonItem(image: UIImage(systemName: "book"), style: .plain, target: nil, action: nil)
    /// 标签
    private(set) var tabmarkBtnItem = UIBarButtonItem(image: UIImage(systemName: "square.on.square"), style: .plain, target: nil, action: nil)
    
    private var allItems: [UIBarButtonItem]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("创建 工具栏",self);
//        self.setItems(items, animated: false)
        self.allItems = [self.backBtnItem, createFlexibleSpaceItem(), self.forwardBtnItem, createFlexibleSpaceItem(), self.actionBtnItem, createFlexibleSpaceItem(), self.bookmarkBtnItem, createFlexibleSpaceItem(), self.tabmarkBtnItem]
        self.backBtnItem.isEnabled = false
        self.forwardBtnItem.isEnabled = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 创建填充item之间的item
    /// - Returns: item
    private func createFlexibleSpaceItem() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
    override var items: [UIBarButtonItem]? {
        get{
            return self.allItems
        }
        set{
            super.items = newValue
        }
    }
}

extension Reactive  where Base: WebToolBar {
    var canBack: Binder<Bool> {
        return Binder(self.base) { webtoolBar, canback in
            print(canback)
            webtoolBar.backBtnItem.isEnabled = canback
        }
    }
    
    var canForward: Binder<Bool> {
        return Binder(self.base) { webtoolBar, canforward in
            webtoolBar.forwardBtnItem.isEnabled = canforward
        }
    }
}
