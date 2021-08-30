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
            progressView.progress = progress
        }
    }
}

