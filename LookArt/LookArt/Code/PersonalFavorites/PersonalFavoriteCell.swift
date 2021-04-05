//
//  PersonalFavoriteCell.swift
//  LookArt
//
//  Created by xzh on 2021/4/5.
//

import UIKit

class PersonalFavoriteCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.backgroundColor = UIColor.random
        self.imgView.backgroundColor = UIColor.random
    }

}
