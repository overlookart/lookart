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
        
        
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let attributes = layoutAttributes as? TabLayoutAttributes else { return }
        self.layer.anchorPoint = attributes.anchorPoint
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        closeAction?()
    }
    

}
