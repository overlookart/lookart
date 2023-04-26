//
//  LookArtActivityController.swift
//  LookArt
//
//  Created by xzh on 2021/7/24.
//

import UIKit

class LookArtActivityController: UIActivityViewController {
    
    private let setting = SettingActivity()
    private let develop = DevelopeActivity()
    
    init() {
        super.init(activityItems: [], applicationActivities: [setting,develop])
    }
    
    override init(activityItems: [Any], applicationActivities: [UIActivity]?) {
        super.init(activityItems: activityItems, applicationActivities: applicationActivities)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setting.finishHandler = {
            let setNav = BaseNavigationController(rootViewController: SettingViewController())
            UIWindow.currentViewController()?.present(setNav, animated: true, completion: nil)
        }
        
        develop.finishHandler = {
            let setNav = BaseNavigationController(rootViewController: DevelopViewController())
            UIWindow.currentViewController()?.present(setNav, animated: true, completion: nil)
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
