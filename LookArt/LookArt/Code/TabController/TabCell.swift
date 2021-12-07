//
//  TabCell.swift
//  LookArt
//
//  Created by xzh on 2021/2/28.
//

import UIKit

class TabCell: UICollectionViewCell {

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
//        if let attributes = layoutAttributes as? TabLayoutAttributes {
//            self.layer.anchorPoint = attributes.anchorPoint
//        }else{
//            self.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        }
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        closeAction?()
    }
    

}
