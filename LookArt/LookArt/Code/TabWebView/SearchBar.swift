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
    
    let searchTextField: UIView = {
        let textfield = UIView(frame: CGRect.zero);
        textfield.backgroundColor = UIColor.systemGray5
        textfield.cornerRadius = 8
        return textfield
    }()
    let textLab: UILabel = {
        let lab = UILabel(text: "fdse", style: .body)
        return lab
    }()
    // 进度条
    private let progressBar: UIProgressView = {
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
        backgroundColor = UIColor.white
        self.isTranslucent = true;
        self.barStyle = .default;
        
        self.addSubview(self.searchTextField)
        self.searchTextField.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
            make.height.equalTo(36)
        }
        searchTextField.addSubview(self.textLab)
        self.textLab.snp.makeConstraints { make in
            make.center.equalTo(self.searchTextField)
        }
        self.addSubview(self.progressBar)
        self.progressBar.snp.makeConstraints { make in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(2)
        }
    }
    
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
    
    func updateHeight(height: CGFloat) {
        var mrg: CGFloat = 8/3.0 * height;
        mrg = mrg <= 10 ? 10 : mrg
        var h: CGFloat = 36 - (16/30.0 * height);
        h = h <= 20 ? 20 : h
        self.searchTextField.snp.updateConstraints { make in
            make.left.equalTo(mrg)
            make.right.equalTo(-mrg)
            make.bottom.equalTo(-10)
            make.height.equalTo(h)
        }
        
        self.searchTextField.alpha = 1/30*(30-height);
    }
}
