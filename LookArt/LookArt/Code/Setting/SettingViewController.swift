//
//  SettingViewController.swift
//  LookArt
//
//  Created by xzh on 2021/7/24.
//

import UIKit
import PanModal
import RxSwift
class SettingViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    let settingMV = SettingVM()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        // Do any additional setup after loading the view.
        
        self.tableView.register(nibWithCellClass: SettingViewCell.self)
        settingMV.bindDataSource(view: self.tableView, disposeBag: self.disposeBag)
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

extension SettingViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight{
        return .contentHeight(300)
    }
}
