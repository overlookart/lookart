//
//  ViewController.swift
//  LookArt
//
//  Created by xzh on 2021/2/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        WebServer.share.startServer()
        
        let btn = UIButton(frame: CGRect.zero)
        btn.setTitle("webServer", for: .normal)
        btn.setTitleColor(UIColor.random, for: .normal)
        
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.size.equalTo(CGSize(width: 100, height: 60))
        }
        
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
    }

    @objc private func btnAction() {
        self.present(WebController(), animated: true, completion: nil)
    }
}

