//
//  ActionActivity.swift
//  LookArt
//
//  Created by CaiGou on 2021/6/18.
//

import UIKit

class SettingActivity: UIActivity {

    override class var activityCategory: UIActivity.Category{
        return .action
    }
    
    override var activityTitle: String? {
        return "设置"
    }
    
    override var activityImage: UIImage?{
        return UIImage(systemName: "gear")
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        print("设置")
        
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
}
