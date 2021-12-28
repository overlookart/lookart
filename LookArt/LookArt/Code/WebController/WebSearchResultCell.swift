//
//  WebSearchResultCell.swift
//  LookArt
//
//  Created by CaiGou on 2021/12/24.
//

import UIKit

class WebSearchResultCell: BaseTableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var subTitleLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
