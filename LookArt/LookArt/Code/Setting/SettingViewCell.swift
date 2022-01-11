//
//  SettingViewCell.swift
//  LookArt
//
//  Created by xzh on 2021/7/24.
//

import UIKit

class SettingViewCell: BaseTableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func setup() {
//        self.separatorInset
    }
}
