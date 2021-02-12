//
//  WebController.swift
//  LookArt
//
//  Created by xzh on 2021/2/12.
//

import UIKit
import SnapKit
class WebController: BaseViewController {

    
    let web: TabWebView = {
        let tabWebView = TabWebView(config: WebConfig())
        return tabWebView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(self.web)
        web.snp.makeConstraints { (make) in
            make.trailing.equalTo(0)
            make.leading.equalTo(0)
            make.top.equalTo(56)
            make.bottom.equalTo(49)
        }
        
        web.loadweb(urlStr: "http://172.20.10.2:8080/")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
