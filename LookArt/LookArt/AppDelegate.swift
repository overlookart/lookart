//
//  AppDelegate.swift
//  LookArt
//
//  Created by xzh on 2021/2/10.
//

import UIKit
import CoreData
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// CoreData 持久存储容器
    private(set) lazy var persistentContainer: PersistentContainer = {
        let container = PersistentContainer(name: "AppDataStore")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
            debugPrint("加载存储",description.url?.absoluteString)
        }
        container.deleteStore(name: "WebSiteModel")
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppLog("APP 启动", color: UIColor.random)
        AppDebug.enable()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        AppLog("创建一个新的 scene")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

