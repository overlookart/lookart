//
//  UITextField_Extension.swift
//  DaoSample
//
//  Created by MoYing on 2020/11/21.
//

import Foundation
import UIKit
extension UITextField {
    // 光标选中
    var cursorSelectRange: NSRange? {
        guard let selectedRange: UITextRange = self.selectedTextRange else { return nil }
        let beginning: UITextPosition = self.beginningOfDocument
        let selectionStart = selectedRange.start
        let selectionEnd = selectedRange.end
        let location = self.offset(from: beginning, to: selectionStart)
        let length = self.offset(from: selectionStart, to: selectionEnd)
        return NSRange(location: location, length: length)
    }
    
    // 拼音选中
    var zh_cnSelectRange: NSRange? {
        guard let makedRange = self.markedTextRange else { return nil }
        let beginning: UITextPosition = self.beginningOfDocument
        let selectionStart = makedRange.start
        let selectionEnd = makedRange.end
        let location = self.offset(from: beginning, to: selectionStart)
        let length = self.offset(from: selectionStart, to: selectionEnd)
        return NSRange(location: location, length: length)
    }
}
