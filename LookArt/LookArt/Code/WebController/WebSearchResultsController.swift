//
//  SearchResultsController.swift
//  LookArt
//
//  Created by CaiGou on 2021/12/8.
//

import UIKit

class WebSearchResultsController: BaseViewController {

    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension WebSearchResultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let data =  RealmController.share.fetchHistory()
        print("搜索结果",data)
    }
}
