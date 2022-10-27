//
//  TabCell.swift
//  LookArt
//
//  Created by xzh on 2021/2/28.
//

import UIKit
import CollectionViewPagingLayout
class TabCell: UICollectionViewCell{

    var closeAction: (() -> Void)?
    
    
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var closeBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.cornerRadius = 8
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        closeAction?()

    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return super.preferredLayoutAttributesFitting(layoutAttributes)
    }
}



// MARK: - CollectionViewPagingLayout
extension TabCell: ScaleTransformView{
    
    var selectableView: UIView? {
        return nil
    }
    
    var scalableView: UIView {
        return contentView
    }
    
    var scaleOptions: ScaleTransformViewOptions{
        return .layout(.coverFlow)
    }
}

