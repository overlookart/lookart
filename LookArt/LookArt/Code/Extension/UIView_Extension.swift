//
//  UIView_Extension.swift
//  DaoSample
//
//  Created by MoYing on 2020/11/14.
//

import Foundation
import UIKit


#if canImport(SwifterSwift)
import SwifterSwift
#endif

protocol NibLoadable {
    
}

extension NibLoadable where Self: UIView {
    static func loadFromNib(_ nibName : String? = nil) -> Self {
        print(nibName ?? "\(self)")
        

        #if canImport(SwifterSwift)
        return Self.loadFromNib(named: nibName ?? "\(self)", bundle: Bundle.main) as! Self
        #else
        return UINib(nibName: nibName ?? "\(self)", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as? UIView as! Self
        #endif
    }
}

extension UIView: NibLoadable {
    
}

//MARK: - Animation
extension UIView {
    func move(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
                self.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            }, completion: completion)
        }else{
            transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            completion?(true)
        }
    }
}
