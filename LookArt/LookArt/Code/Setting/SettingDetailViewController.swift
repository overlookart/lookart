//
//  SettingDetailViewController.swift
//  LookArt
//
//  Created by xzh on 2021/12/28.
//

import UIKit
import RxSwift
class SettingDetailViewController: BaseViewController {
    var type: SettingType = .Theme
    let settingDetailVM = SettingDetailVM()
    let disposeBag = DisposeBag()
    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainTableView.register(nibWithCellClass: SettingDetailCell.self)
        settingDetailVM.bindDataSource(view: mainTableView, disposeBag: disposeBag)
        switch type {
            case .Theme:
                settingDetailVM.datasource.append(contentsOf: LookArtData.themeList())
            case .Engine:
                settingDetailVM.datasource.append(contentsOf: LookArtData.engineList())
        }
        settingDetailVM.updateDataSource()
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
