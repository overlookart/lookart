//
//  AppDebug.swift
//  LookArt
//
//  Created by CaiGou on 2022/3/31.
//

import Foundation
#if DEBUG
import CocoaDebug
#endif

struct AppDebug {
    static func enable() {
        #if DEBUG
        CocoaDebug.enable()
        #endif
    }
}

public func AppLog<T>(file: String = #file, function: String = #function, line: Int = #line, _ message: T, color: UIColor = .white){
    #if DEBUG
    Swift.print(message)
    _SwiftLogHelper.shared.handleLog(file: file, function: function, line: line, message: message, color: color)
    #endif
}
