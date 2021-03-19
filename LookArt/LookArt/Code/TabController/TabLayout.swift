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
    
    private var tabCount: Int {
        guard let view = collectionView, let dataSource = view.dataSource else { return 0 }
        return min(6, dataSource.collectionView(view, numberOfItemsInSection: 0))
    }
    
    override var collectionViewContentSize: CGSize {
        guard let view = collectionView, let dataSource = view.dataSource else { return .zero }
        let itemCount = dataSource.collectionView(view, numberOfItemsInSection: 0)
        if itemCount < 1 {
            return .zero
        }
        if itemCount == 1 {
            return view.size
        }
        return CGSize(width: view.width, height: CGFloat(itemCount) * (view.height / CGFloat(tabCount)))
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        print("rect:\(rect)")
        let firstVisibleItem = self.screenVisibleItem
        let lastVisibleItem = min(firstVisibleItem + tabCount, itemsCount - 1)
        if lastVisibleItem < firstVisibleItem {
            let indexPath = IndexPath(item: lastVisibleItem, section: 0)
            guard let cellAttributes = layoutAttributesForItem(at: indexPath) else { return nil }
            return [cellAttributes]
        }
        var attributes = [UICollectionViewLayoutAttributes]()
        (firstVisibleItem ... lastVisibleItem).forEach { index in
            let indexPath = IndexPath(item: index, section: 0)
            guard let cellAttributes = layoutAttributesForItem(at: indexPath) else { return }
            attributes.append(cellAttributes)
        }
        return attributes
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        print("layoutAttributesForItem")
        let collectionBounds = self.collectionBounds
        let collectionOffset = self.collectionOffset
        
        let attributes = TabLayoutAttributes(forCellWith: indexPath)
        attributes.frame = frameForItem(at: indexPath)
        
        let tilt = ((collectionOffset.y - attributes.frame.minY) / collectionBounds.height)
        var perspective = CATransform3DIdentity
        perspective.m34 = -1/1000
        
        let rotation = CATransform3DRotate(perspective, (tilt * variationAngle) - defaultAngle, 1.0, 0.0, 0.0)
        let translation = CATransform3DMakeTranslation(0.0, collectionBounds.height / -2, 0.0)
        attributes.transform3D = CATransform3DConcat(rotation, translation)
        attributes.anchorPoint = CGPoint(x: 0.5, y: 0.0)
//        attributes
        return attributes
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}

extension TabLayout {
    /// Item的数量
    var itemsCount: Int {
        guard let view = collectionView, let dataSource = view.dataSource else { return 0 }
        return dataSource.collectionView(view, numberOfItemsInSection: 0)
    }
    
    /// 屏幕显示Item的数量
    var screenVisibleItem: Int {
        guard let view = collectionView else { return 0 }
        return max(Int(view.contentOffset.y / (view.height / CGFloat(tabCount))), 0)
    }
    
    var collectionBounds: CGRect {
        return collectionView?.bounds ?? .zero
    }
    
    var collectionOffset: CGPoint {
        return collectionView?.contentOffset ?? .zero
    }
    
    func sectionInset(for section: Int) -> UIEdgeInsets {
//        guard let view = collectionView, let insets = (view.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(view, layout: self, insetForSectionAt: section) else { return collectionView?.contentInset ?? .zero }
        let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return insets
    }
    
    func frameForItem(at indexPath: IndexPath) -> CGRect {
        let insets = sectionInset(for: indexPath.section)
        return CGRect(x: insets.left, y: CGFloat(indexPath.item) * (collectionBounds.height / CGFloat(tabCount)) + insets.top, width: collectionBounds.width - (insets.left + insets.right), height: collectionBounds.height - (insets.top + insets.bottom))
    }
    
    
}
