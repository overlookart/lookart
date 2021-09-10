//
//  BaseProgressView.swift
//  LookArt
//
//  Created by CaiGou on 2021/9/9.
//

import UIKit

class BaseProgressView: UIProgressView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)
        if progress >= 1 {
            UIView.animate(withDuration: 0.3, delay: 0.3, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.alpha = 0.0
            }) { (complet) in
                self.alpha = 1.0
                self.setProgress(0.0, animated: false)
            }
        }
    }
}
