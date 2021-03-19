//
//  TabLayoutAttributes.swift
//  LookArt
//
//  Created by xzh on 2021/3/8.
//

import UIKit

class TabLayoutAttributes: UICollectionViewLayoutAttributes {

    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let attribute = super.copy(with: zone) as! TabLayoutAttributes
        attribute.anchorPoint = self.anchorPoint
        return attribute
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? TabLayoutAttributes, object.anchorPoint == self.anchorPoint else { return false }
        
        return super.isEqual(object)
    }
}
