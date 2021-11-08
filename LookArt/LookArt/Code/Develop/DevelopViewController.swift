//
//  DevelopViewController.swift
//  LookArt
//
//  Created by CaiGou on 2021/11/8.
//

import UIKit

class DevelopViewController: BaseViewController {
    @IBOutlet weak var serverBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "开发者选项"
        // Do any additional setup after loading the view.
        
        self.serverBtn.setTitle("启动服务", for: .normal)
        self.serverBtn.setTitle("停止服务", for: .selected)
        self.serverBtn.isSelected = WebServer.share.server.isRunning
    }

    @IBAction func serverAction(_ sender: Any) {
        self.serverBtn.isSelected = !self.serverBtn.isSelected
        if self.serverBtn.isSelected {
            self.startServer()
        }else{
            self.stopServer()
        }
    }
    
    
    private func startServer() {
        WebServer.share.start()
    }
    
    private func stopServer() {
        WebServer.share.stop()
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
