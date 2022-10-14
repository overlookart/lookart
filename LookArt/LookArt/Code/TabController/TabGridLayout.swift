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
    
    private func defaultItemSettings(){
        //垂直方向行间距
        minimumLineSpacing = 20
        //垂直方向列间距
        minimumInteritemSpacing = 10
        
        /**
         预估 item 的大小, 默认为 zero
         当单元格动态调整其大小时 会提高 CollectionView 的性能
         当设置为  automaticSize，会使用 cell的 preferredLayoutAttributesFitting(_:)方法查询每个单元格的实际大小
         如果所有 itme 的大小相同 则使用 itemSize 设置大小
         */ //TabGridLayout.automaticSize
        estimatedItemSize = .zero
        
        /**
         滑动方向
         */
        scrollDirection = .vertical
        
        /**
         组头的默认大小
         默认为 zero
         collectionView(_:layout:referenceSizeForHeaderInSection:) 会覆盖其值
         */
        headerReferenceSize = .zero
        
        /**
         组脚的默认大小
         默认为 zero
         collectionView(_:layout:referenceSizeForFooterInSection:) 会覆盖其值
         */
        footerReferenceSize = .zero
        
        // 组头在滑动时是否显示
        sectionHeadersPinToVisibleBounds = true
        
        // 组脚在滑动时是否显示
        sectionFootersPinToVisibleBounds = true
        
        
        let w = (UIScreen.ScreenWidth() - 30) / 2.0
        let h = w / 3.0 * 4
        // 每个item的大小
        itemSize = CGSize(width: w, height: h)
        //每组的边距
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
