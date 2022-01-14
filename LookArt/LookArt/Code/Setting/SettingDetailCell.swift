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
    var data: SettingDetailData?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .none
        }
        
        // Configure the view for the selected state
    }

    override func setup() {
        imgView.backgroundColor = UIColor.random
    }
    
    func setdata(data: SettingDetailData) {
        self.data = data
        self.titleLab.text = data.title
    }
    
    func isDefaultSelected() -> Bool {
        guard let settingdata = self.data else { return false }
        switch settingdata.type {
            case .Theme:
                if settingdata as! ThemeType == LookArtData.settingTheme() {
                    return true
                }else{
                    return false
                }
            case .Engine:
                if settingdata as! EngineType == LookArtData.settingEngine() {
                    return true
                }else{
                    return false
                }
        }
    }
}
