//
//  SearchBar.swift
//  LookArt
//
//  Created by CaiGou on 2021/6/24.
//

import UIKit

class SearchBar: UIToolbar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    // 网页域名
    private var webHost: String = ""
    // 是否折叠
    private var isFold: Bool = false
    // 圆角矩形背景视图
    let rectView: UIView = {
        let textfield = UIView(frame: CGRect.zero);
        textfield.backgroundColor = UIColor.systemGray5
        textfield.cornerRadius = 8
        return textfield
    }()
    let textLab: UILabel = {
        let lab = UILabel(text: "fdse", style: .body)
        return lab
    }()
    //刷新停止按钮
    let refreshOrStopBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage.init(systemName: "arrow.clockwise")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .normal)
        btn.setImage(UIImage.init(systemName: "xmark")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .selected)
        return btn
    }()
    // 进度条
    let progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.progress = 0
        return progress
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUI(){
        self.isTranslucent = true;
        self.barStyle = .default;
        
        self.setShadowImage(UIImage.init(color: UIColor.systemRed, size: CGSize(width: 1, height: 1)), forToolbarPosition: .any)
        
        self.addSubview(self.rectView)
        self.rectView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
            make.height.equalTo(36)
        }
        self.rectView.addSubview(self.refreshOrStopBtn)
        self.refreshOrStopBtn.snp.makeConstraints { make in
            make.top.equalTo(self.rectView).offset(5)
            make.right.equalTo(self.rectView).offset(-5)
            make.bottom.equalTo(self.rectView).offset(-5)
            make.width.equalTo(self.rectView.snp.height).offset(-10)
        }
        self.addSubview(self.textLab)
        self.textLab.snp.makeConstraints { make in
            make.center.equalTo(self.rectView)
        }
        self.addSubview(self.progressBar)
        self.progressBar.snp.makeConstraints { make in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(2)
        }
    }
    
    /// 设置进度条的值
    /// - Parameter progress: 网页加载的进度
    func setProgress(progress: Float) {
        self.progressBar.setProgress(progress, animated: true)
        if progress >= 1 {
            UIView.animate(withDuration: 0.3, delay: 0.3, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.progressBar.alpha = 0.0
            }) { (complet) in
                self.progressBar.setProgress(0.0, animated: false)
            }
        }
    }
    
    /// 更新搜索 bar 的高度
    /// - Parameter height: 高度
    func updateHeight(height: CGFloat) {
        var mrg: CGFloat = 8/3.0 * height;
        mrg = mrg <= 10 ? 10 : mrg
        var h: CGFloat = 36 - (16/30.0 * height);
        h = h <= 20 ? 20 : h
        self.rectView.snp.updateConstraints { make in
            make.left.equalTo(mrg)
            make.right.equalTo(-mrg)
            make.bottom.equalTo(-10)
            make.height.equalTo(h)
        }
        self.rectView.alpha = 1/30*(30-height);
    }
    
    
    func updateHost(host: String?) {
//        self.webHost = host;
        self.textLab.text = host;
    }
}
