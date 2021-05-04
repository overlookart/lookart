//
//  ContextMenuPreview.swift
//  LookArt
//
//  Created by xzh on 2021/5/3.
//

import UIKit

class ContextMenuPreview: BaseView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func awakeFromNib() {
        super.awakeFromNib()
        self.cornerRadius = 14
    }
}
