//
//  SettingDetailCell.swift
//  LookArt
//
//  Created by CaiGou on 2021/12/31.
//

import UIKit

class SettingDetailCell: BaseTableViewCell {

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
        
    }
}
