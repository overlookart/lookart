//
//  UIWindow_Extension.swift
//  LookArt
//
//  Created by xzh on 2021/7/24.
//

import Foundation
extension UIWindow {
    static func currentViewController() -> UIViewController? {
        var window: UIWindow?
        if #available(iOS 13, *) {
            var isfind = false
            for scene in UIApplication.shared.connectedScenes {
                if let wScene: UIWindowScene = scene as? UIWindowScene {
                    if isfind {
                        break
                    }
                    for win in wScene.windows {
                        if win.isKeyWindow {
                            window = win
                            isfind = true
                            break
                        }
                    }
                }
            }
        }else{
            window = UIApplication.shared.delegate?.window ?? nil
        }
        var topViewController = window?.rootViewController
        while true {
            if let vc = topViewController?.presentedViewController {
                topViewController = vc
            }else if let nav: UINavigationController = topViewController as? UINavigationController, let vc = nav.topViewController {
                topViewController = vc
            }else if let tab: UITabBarController = topViewController as? UITabBarController, let vc = tab.selectedViewController {
                topViewController = vc
            }else{
                break
            }
        }
        return topViewController
    }
}
