//
//  TabWebView.swift
//  LookArt
//
//  Created by xzh on 2021/2/12.
//

import UIKit

class TabWebView: BaseWebView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    init(config: WebConfig) {
        super.init(frame: CGRect.zero, configuration: config)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
