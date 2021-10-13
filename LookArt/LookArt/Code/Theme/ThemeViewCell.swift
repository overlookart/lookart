//
//  ThemeViewCell.swift
//  LookArt
//
//  Created by CaiGou on 2021/10/11.
//

import UIKit

class ThemeViewCell: UITableViewCell {
    @IBOutlet weak var titleLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //右侧附件类型
        //    .none 啥也没有
        //    .checkmark 蓝色对勾
        //    .disclosureIndicator 灰色右箭头
        //    .detailDisclosureButton 蓝色圆圈i + 灰色右箭头
        //    .detailButton 蓝色圆圈i
//        self.accessoryType = .checkmark
    }
    
    /// 设置选中状态
    /// - Parameters:
    ///   - selected: 选中状态
    ///   - animated: 是否有动画
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.accessoryType = .checkmark
        }else{
            self.accessoryType = .none
        }
        // Configure the view for the selected state
    }
    
}
