//
//  String_Extension.swift
//  DaoSample
//
//  Created by MoYing on 2020/11/14.
//

import Foundation
import CommonCrypto
extension String {
    /// md5 加密
    var md5:String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
    
    /// 交换字符
    /// - Parameters:
    ///   - index1: 字符下标1
    ///   - index2: 字符下标2
    /// - Returns: 交换结果String
    mutating func swapAt(_ index1: Int, _ index2: Int) -> String {
        var characters = Array(self)
        characters.swapAt(index1, index2)
         return String(characters)
    }
    
    
    /// 是否为urlstr
    var isUrlStr: Bool {
        if isEmpty { return false }
        var str = self
        if !(hasPrefix("http://") || hasPrefix("https://")) {
            str = "http://" + str
        }
        let urlRegex = "((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-#]*)?"
        let predicate = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        return predicate.evaluate(with: str)
        
    }
    
    /// 是否为中文字符
    var isZH_CNStr: Bool{
        let regex = "[\\u4e00-\\u9fa5]+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    
    
}
