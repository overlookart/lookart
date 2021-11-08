//
//  DevelopeActivity.swift
//  LookArt
//
//  Created by CaiGou on 2021/11/8.
//

import UIKit

class DevelopeActivity: UIActivity {
    override class var activityCategory: UIActivity.Category{
        return .action
    }
    
    override var activityType: UIActivity.ActivityType? {
        return .lookartDevelop
    }
    
    override var activityImage: UIImage? {
        return UIImage(systemName: "hammer")
    }
    
    override var activityTitle: String? {
        return "开发"
    }
    
    public var finishHandler : (() -> Void)?
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    override func activityDidFinish(_ completed: Bool) {
        if let finish = self.finishHandler {
            finish()
        }
    }
    
}
