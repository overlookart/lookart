//
//  LookArtActivityController.swift
//  LookArt
//
//  Created by xzh on 2021/7/24.
//

import UIKit

class LookArtActivityController: UIActivityViewController {
    
    private let setting = SettingActivity()
    
    init(activityItems: [Any]) {
        super.init(activityItems: activityItems, applicationActivities: [setting])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setting.finishHandler = {
            let setNav = BaseNavigationController(rootViewController: SettingViewController())
            UIWindow.currentViewController()?.present(setNav, animated: true, completion: nil)
            print("设置--完成")
            
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
