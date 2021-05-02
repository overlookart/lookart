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
        self.imgView.backgroundColor = UIColor.random
        self.contentView.backgroundColor = UIColor.random
        self.contentView.shadowColor = UIColor.black
        self.contentView.shadowOpacity = 0.5
        self.contentView.shadowOffset = CGSize(width: 0, height: 0)
    }

}
