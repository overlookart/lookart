//
//  TabWebView.swift
//  LookArt
//
//  Created by xzh on 2021/2/12.
//

import UIKit

class TabWebView: BaseWebView {

    /// 开始拖动时的offset
    private(set) var scrollBeginDragOffset: CGPoint = CGPoint.zero
    /// 当前的offset
    private(set) var scrollContentOffset: CGPoint = CGPoint.zero
    /// 滑动代理
    var scrollDelegates: (DidScroll:(() -> Void)?, BeginDragging:(() -> Void)?, WillEndDragging:((CGPoint) -> Void)?, EndDragging:(() -> Void)?, BeginDecelerating:(() -> Void)?, EndDecelerating:(() -> Void)?)?
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

extension TabWebView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollContentOffset = scrollView.contentOffset
        if let didScroll = self.scrollDelegates?.DidScroll {
            didScroll()
        }
    }
    
    /// 开始滑动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollBeginDragOffset = scrollView.contentOffset
        if let beginDragging = self.scrollDelegates?.BeginDragging {
            beginDragging()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        print("将要结束拖拽")
        if let willEndDragging = self.scrollDelegates?.WillEndDragging {
            willEndDragging(velocity)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        print("结束拖拽")
        if let endDragging = self.scrollDelegates?.EndDragging {
            endDragging()
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        print("开始减速")
        if let beginDecelerating = self.scrollDelegates?.BeginDecelerating {
            beginDecelerating()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("停止减速")
        if let endDecelerating = self.scrollDelegates?.EndDecelerating {
            endDecelerating()
        }
    }
}
