//
//  TabLayoutAttributes.swift
//  LookArt
//
//  Created by xzh on 2021/3/8.
//

import UIKit

class TabLayoutAttributes: UICollectionViewLayoutAttributes {
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let attribute = super.copy(with: zone) as! TabLayoutAttributes
        
        return attribute
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? TabLayoutAttributes else { return false }
        
        return super.isEqual(object)
    }
}
