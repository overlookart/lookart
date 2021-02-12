//
//  FileManager_Extension.swift
//  DaoSample
//
//  Created by MoYing on 2020/11/25.
//

import Foundation
extension FileManager {
    private func urlForDirectory(directory: SearchPathDirectory) -> URL? {
        return self.urls(for: directory, in: SearchPathDomainMask.userDomainMask).last
        
    }
    
    private func pathForDirectory(directory: SearchPathDirectory) -> String? {
        return NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first
    }
    
    /// Document目录url
    var documentsURL: URL? {
        return self.urlForDirectory(directory: .documentDirectory)
    }
    /// Document目录
    var documentsPath: String? {
        return self.pathForDirectory(directory: .documentDirectory)
    }
    /// library目录url
    var libraryURL: URL? {
        return self.urlForDirectory(directory: .libraryDirectory)
    }
    /// library
    var libraryPath: String? {
        return self.pathForDirectory(directory: .libraryDirectory)
    }
    /// caches目录url
    var cachesURL: URL? {
        return self.urlForDirectory(directory: .cachesDirectory)
    }
    /// caches目录
    var cachesPath: String? {
        return self.pathForDirectory(directory: .cachesDirectory)
    }
}
