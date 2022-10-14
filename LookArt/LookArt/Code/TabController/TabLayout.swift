//
//  TabLayout.swift
//  LookArt
//
//  Created by xzh on 2021/2/28.
//

import UIKit

class TabLayout: UICollectionViewFlowLayout {

    var defaultAngle: CGFloat = CGFloat.pi * 0.2
    
    var variationAngle: CGFloat = CGFloat.pi * 0.2
    
    
    /// 1度的旋转值
    var RotateAngle: CGFloat = CGFloat.pi / 360.0
    
    private var tabCount: Int {
        guard let view = collectionView, let dataSource = view.dataSource else { return 0 }
        return min(6, dataSource.collectionView(view, numberOfItemsInSection: 0))
    }
    
    /// 当第一次加载布局或者布局失效的时候,会调用该方法,我们要在这里实现具体的布局计算
    override func prepare() {
        super.prepare()
        debugPrint("准备折页布局")
        self.scrollDirection = .vertical
        print("有几组分区",self.sectionCount)
        print("item Size",self.itemSize)
        self.itemSize = CGSize(width: UIScreen.ScreenWidth(), height: 300)
        
        for sectionIndex in 0 ..< self.sectionCount {
            let sectionInset = sectionInset(for: sectionIndex)
            let sectionMinimumLineSpacing = sectionMinimumLineSpacing(for: sectionIndex)
            let minimumInteritemSpacing = minimumInteritemSpacing(for: sectionIndex)
            
        }
        
        
    }
    
    /// 父类需要根据返回的contentsize大小,控制uicollectionview的显示
    override var collectionViewContentSize: CGSize {
        let size = super.collectionViewContentSize;
        if self.scrollDirection == .horizontal {
            //水平-->重新计算宽度
        }else{
            //垂直-->重新计算高度
        }
        for section in 0 ..< self.sectionCount {
            let itemcount = numberOfItems(in: section)
        }
        guard let view = collectionView, let dataSource = view.dataSource else { return .zero }
        let itemCount = dataSource.collectionView(view, numberOfItemsInSection: 0)
        
        
        
//        return CGSize(width: view.width, height: CGFloat(itemCount) * (view.height / CGFloat(tabCount)))
        print("Layout Content Size",size)
        return size;
    }
    
    
    /// 这个方法比较关键,
    /// 我们需要将计算法的UICollectionViewLayoutAttributes数组返回给显示的rect,
    /// 系统会根据属性数组来计算cell的复用和布局的显示.
    /// - Parameter rect: <#rect description#>
    /// - Returns: 属性数组
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let controllerView = self.collectionView, let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        //
        print("准备好的item",attributes.count)
        
        // 滑动偏移 到 collectionView 原点的位置
        let center = CGPoint(x: controllerView.contentOffset.x + controllerView.width / 2, y: controllerView.contentOffset.y + controllerView.height / 2)
        
        for attribute in attributes {
//            var perspective = CATransform3DIdentity
//            perspective.m34 = 1/1000
//            //延x轴旋转
//            let rotation = CATransform3DRotate(perspective, RotateAngle*90, 2, 0, 0.0)
//            attribute.transform3D = CATransform3DConcat(rotation, CATransform3DMakeTranslation(0, -10, 0))
            //获取cell中心 到 View 中心位置 距离的绝对值。
            let distance = CGPoint(x: abs(attribute.center.x - center.x), y: abs(attribute.center.y - center.y))
            
            let aprtScale = CGPoint(x: distance.x / controllerView.width, y: distance.y / controllerView.height / 2)
            
            let scale = CGPoint(x: abs(cos(aprtScale.x * CGFloat(Double.pi/4))), y: abs(cos(aprtScale.y * CGFloat(Double.pi/4))))
            
            attribute.transform = CGAffineTransform(scaleX: scale.x, y: scale.y)
        }
        
        return attributes
    }
    
    /// 计算每个item的布局属性,我们将要调用该方法去计算每个item的布局,
    /// 在增加,刷新item的时候,该方法也会调用,
    /// 如果我们需要实现自定义的动画效果,需要在计算中做些调整
    /// - Parameter indexPath: 下标索引
    /// - Returns: 布局属性
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        print("layoutAttributesForItem",indexPath.row)
        let collectionBounds = self.collectionBounds
        let collectionOffset = self.collectionOffset
        
        let attributes = TabLayoutAttributes(forCellWith: indexPath)
        attributes.frame = frameForItem(at: indexPath)
        
        let tilt = ((collectionOffset.y - attributes.frame.minY) / collectionBounds.height)
        var perspective = CATransform3DIdentity
        perspective.m34 = -2/1000

        let rotation = CATransform3DRotate(perspective, (tilt * variationAngle) - defaultAngle, 1.0, 0.0, 0.0)
        let translation = CATransform3DMakeTranslation(0.0, collectionBounds.height / -2, 0.0)
        attributes.transform3D = CATransform3DConcat(rotation, translation)
        return attributes
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    //此方法用来表示 执行的Action和操作的indexPath
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        
    }
    
    //一般用来做insetItem的动画的
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
    }
    
    // 一般用来做deleteItem的动画的
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
    }
    
}

extension TabLayout {
    /// Item的数量
    var itemsCount: Int {
        guard let view = collectionView, let dataSource = view.dataSource else { return 0 }
        return dataSource.collectionView(view, numberOfItemsInSection: 0)
    }
    
    /// 分组的数量
    var sectionCount: Int {
        guard let view = collectionView else {return 0}
        return view.numberOfSections
    }
    
    /// 屏幕显示Item的数量
    var screenVisibleItem: Int {
        guard let view = collectionView else { return 0 }
        return max(Int(view.contentOffset.y / (view.height / CGFloat(tabCount))), 0)
    }
    
    /// collection view bounds
    var collectionBounds: CGRect {
        return collectionView?.bounds ?? .zero
    }
    
    /// collection view contentOffset
    var collectionOffset: CGPoint {
        return collectionView?.contentOffset ?? .zero
    }
    
    /// 获取分组的上 下 左 右 边距
    /// - Parameter section: 分组下标
    /// - Returns: 边距
    func sectionInset(for section: Int) -> UIEdgeInsets {
        guard let view = collectionView, let insets = (view.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(view, layout: self, insetForSectionAt: section) else { return .zero }
        return insets
    }
    
    /// 分组的最小(竖直行间距，水平列间距)
    /// - Parameter section: 分组下标
    /// - Returns: 最小间距
    func sectionMinimumLineSpacing(for section: Int) -> CGFloat {
        guard let view = collectionView, let space = (view.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(view, layout: self, minimumLineSpacingForSectionAt: section) else {return 0}
        return space
    }
    
    /// 分组的最小(水平行间距，竖直列间距)
    /// - Parameter section: 分组下标
    /// - Returns: 最小间距
    func minimumInteritemSpacing(for section: Int) -> CGFloat {
        guard let view = collectionView, let space = (view.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(view, layout: self, minimumInteritemSpacingForSectionAt: section) else { return 0 }
        return space
    }
    
    /// 分组中 item 的数量
    /// - Parameter section: 分组下标
    /// - Returns: 数量
    func numberOfItems(in section: Int) -> Int {
        guard let view = collectionView, let number = view.dataSource?.collectionView(view, numberOfItemsInSection: section) else { return 0 }
        return number
    }
    
    /// item 的大小
    /// - Parameter indexPath: 下标
    /// - Returns: size
    func sizeForItem(at indexPath: IndexPath) -> CGSize {
        guard let view = collectionView, let size = (view.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(view, layout: self, sizeForItemAt: indexPath) else { return CGSize.zero}
        return size
    }
    
    func sectionColum(for section: Int) -> Int {
        return 0;
    }
    
    func frameForItem(at indexPath: IndexPath) -> CGRect {
        let insets = sectionInset(for: indexPath.section)
        return CGRect(x: insets.left,
                      y: CGFloat(indexPath.item) * (collectionBounds.height / CGFloat(tabCount)) + insets.top,
                      width: collectionBounds.width - (insets.left + insets.right),
                      height: collectionBounds.height - (insets.top + insets.bottom))
    }
    
    
}
