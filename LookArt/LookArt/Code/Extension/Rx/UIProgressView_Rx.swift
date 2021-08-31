//
//  UIProgressView_Rx.swift
//  LookArt
//
//  Created by CaiGou on 2021/8/30.
//

import UIKit
import RxCocoa
import RxSwift
extension Reactive where Base: UIProgressView {
    /// 绑定进度值
    var progress: Binder<Float>{
        return Binder(self.base) { progressView, progress in
            print("加载进度:\(progress)")
            progressView.setProgress(progress, animated: true)
            if progress >= 1 {
                UIView.animate(withDuration: 0.3, delay: 0.3, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    progressView.alpha = 0.0
                }) { (complet) in
                    progressView.alpha = 1.0
                    progressView.setProgress(0.0, animated: false)
                }
            }
        }
    }
}

