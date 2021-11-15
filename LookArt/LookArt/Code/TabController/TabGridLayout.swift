//
//  TabGridLayout.swift
//  LookArt
//
//  Created by xzh on 2021/11/14.
//

import Foundation
class TabGridLayout: UICollectionViewFlowLayout {
    override func awakeFromNib() {
        super.awakeFromNib()
        defaultItemSettings()
    }
    override init() {
        super.init()
        defaultItemSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defaultItemSettings(){
        minimumLineSpacing = 20
        minimumInteritemSpacing = 20
        itemSize = CGSize(width: 150, height: 200)
        sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
    }
}
