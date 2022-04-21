//
//  CheckConnection.swift
//  JingCaiTianTian
//
//  Created by CaiGou on 2022/3/23.
//

import Foundation
import Reachability
struct CheckConnection {
    private static let  reachability = try! Reachability()
    /// 开始网络检测
    public static func startCheck() {
        CheckConnection.reachability.whenReachable = { R in
            self.actionConnectionState(R.connection)
        }
        
        self.reachability.whenUnreachable = { R in
            self.actionConnectionState(R.connection)
        }
        do {
            try self.reachability.startNotifier()
        } catch  {
            print("Unable to start notifier")
        }
        
    }
    
    
    /// 停止网络检测
    public static func stopCheck() {
        CheckConnection.reachability.stopNotifier()
    }
    
    static func actionConnectionState(_ state: Reachability.Connection) {
        
        switch state {
            case .wifi:
                print("")
            case .cellular:
                print("")
            case .unavailable:
                print("")
            case .none:
                print("")
        }
        print(state.description)
        
    }
}
