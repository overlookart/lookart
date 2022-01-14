//
//  SettingDetailViewController.swift
//  LookArt
//
//  Created by xzh on 2021/12/28.
//

import UIKit
import RxSwift
import RxCocoa
class SettingDetailViewController: BaseViewController {
    var type: SettingType = .Theme
    let settingDetailVM = SettingDetailVM()
    let disposeBag = DisposeBag()
    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainTableView.allowsSelection = true
        mainTableView.allowsMultipleSelection = false
        mainTableView.delegate = self
        mainTableView.register(nibWithCellClass: SettingDetailCell.self)
        settingDetailVM.bindDataSource(view: mainTableView, disposeBag: disposeBag)
        switch type {
            case .Theme:
                settingDetailVM.datasource.append(contentsOf: LookArtData.themeList())
            case .Engine:
                settingDetailVM.datasource.append(contentsOf: LookArtData.engineList())
        }
        settingDetailVM.updateDataSource()
        mainTableView.rx.modelSelected(SettingDetailData.self).subscribe(onNext: {data in
            LookArtData.saveSettingData(data: data)
        }).disposed(by: disposeBag)
        mainTableView.rx.willDisplayCell.subscribe(onNext: {event in
            //1.更新选中状态
            if let cell = event.cell as? SettingDetailCell {
                if cell.isDefaultSelected() {
                    self.mainTableView.selectRow(at: event.indexPath, animated: true, scrollPosition: .none)
                }
            }
        }).disposed(by: disposeBag)
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


extension SettingDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
