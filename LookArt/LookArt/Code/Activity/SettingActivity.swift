//
//  ActionActivity.swift
//  LookArt
//
//  Created by CaiGou on 2021/6/18.
//

import UIKit

class SettingActivity: UIActivity {
    // activity 分组
    override class var activityCategory: UIActivity.Category{
        return .action
    }
    // activity 类型
    override var activityType: UIActivity.ActivityType?{
        return .lookartSetting
    }
    // activity 图标
    override var activityImage: UIImage?{
        return UIImage(systemName: "gear")
    }
    // activity 标题
    override var activityTitle: String? {
        return "设置"
    }
    // activity 是否可用
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    // 回调
    public var finishHandler : (() -> Void)?
    // 准备 activity
    override func prepare(withActivityItems activityItems: [Any]) {
        print("设置")
    }
    //当活动完成时候调用
    override func activityDidFinish(_ completed: Bool) {
        if let finish = self.finishHandler {
            finish()
        }
    }
    
}
