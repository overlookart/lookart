//
//  SearchResultsController.swift
//  LookArt
//
//  Created by CaiGou on 2021/12/8.
//

import UIKit
import RxSwift
class WebSearchResultsController: BaseViewController {
    let disposeBag = DisposeBag()
    let searchResultVM = WebSearchResultVM()
    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainTableView.register(nibWithCellClass: WebSearchResultCell.self, at: nil)
        searchResultVM.bindDataSource(view: mainTableView, disposeBag: disposeBag)
        mainTableView.delegate = self
//        mainTableView.rx
        
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

extension WebSearchResultsController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension WebSearchResultsController: UISearchResultsUpdating {
    
    /// 更新搜索结果
    /// - Parameter searchController: 搜索控制器
    func updateSearchResults(for searchController: UISearchController) {
        let data =  RealmController.share.fetchHistory()
        searchResultVM.datasource.removeAll()
        for history in data {
            if let website = history.website {
                let web = WebSiteModel(title: website.title, url: website.urlStr, favicon: website.favicon)
                searchResultVM.datasource.append(web);
            }
        }
        searchResultVM.updateDataSource()
    }
}
