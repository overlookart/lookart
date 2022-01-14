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
        self.tableView.delegate = self
        self.tableView.register(nibWithCellClass: SettingViewCell.self)
        settingMV.bindDataSource(view: self.tableView, disposeBag: self.disposeBag)
        self.tableView.rx.modelSelected(SettingDetailData.self).subscribe(onNext: {settingData in
            let settingDetailVC = SettingDetailViewController() 
            settingDetailVC.type = settingData.type
            self.navigationController?.pushViewController(settingDetailVC, animated: true)
        }).disposed(by: disposeBag)
        settingMV.updateDataSource()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 0)
        tableView.separatorInsetReference = .fromAutomaticInsets
        tableView.separatorStyle = .singleLine
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingMV.updateDataSource()
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

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
