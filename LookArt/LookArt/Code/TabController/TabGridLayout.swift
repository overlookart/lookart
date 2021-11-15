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
        //垂直方向行间距
        minimumLineSpacing = 20
        //垂直方向列间距
        minimumInteritemSpacing = 10
        
        let w = (UIScreen.ScreenWidth() - 30) / 2.0
        let h = w / 9.0 * 16
        itemSize = CGSize(width: w, height: h)
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func prepare() {
        super.prepare()
        print("准备栅格布局")
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        print("栅格->重新检查布局信息")
    }
}
