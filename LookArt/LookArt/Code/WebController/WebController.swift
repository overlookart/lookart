//
//  WebController.swift
//  LookArt
//
//  Created by xzh on 2021/2/12.
//

import UIKit
import SnapKit
import WebKit
class WebController: BaseViewController {
    let searchBar: WebSearchBar = {
        let search = WebSearchBar(frame: .zero)
        return search
        
    }()
    var toolbar: ToolBar?
    let web: TabWebView = {
        let tabWebView = TabWebView(config: WebConfig())
        return tabWebView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view.
        
        view.addSubview(self.web)
//        self.setNavigationBarVisible(Visible: false)
        self.setToolBarVisible(Visible: true)
        web.snp.makeConstraints { (make) in
            make.trailing.equalTo(0)
            make.leading.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        self.title = "URL"
//        self.searchBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
//        view.addSubview(self.searchBar)
//        searchBar.snp.makeConstraints { (make) in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.left.equalTo(0)
//            make.right.equalTo(0)
//            make.height.equalTo(56)
//        }
//        searchBar.layoutGuides
        

//        let item9 = UIBarButtonItem(image: UIImage(systemName: "square.on.square"), style: .done, target: nil, action: nil)
//        self.setToolbarItems([item9], animated: true)
        
        
        
        setToolBar()
 
        web.scrollDelegates = (DidScroll:{
            if self.web.scrollContentOffset.y < self.web.scrollBeginDragOffset.y {
                return
            }
            let adjustedOffsetY = self.web.scrollContentOffset.y + self.web.scrollView.contentInset.top - self.web.scrollBeginDragOffset.y
            let boundedOffset = min(max(adjustedOffsetY, 0), 56)
            self.updateSearchBar(height: boundedOffset)
            
        },BeginDragging:{
            
        },WillEndDragging:{ (velocity) in
            
        },EndDragging:{
            
        },BeginDecelerating:{
            
        },EndDecelerating:{
            
        })
        
        web.webObserves = (Title:{(title) in
            print("web title: \(title)")
        },Progress:{(progress) in
            print("web load progress: \(progress)")
        },CanGoBack:{(back) in
            print("web can go back: \(back)")
        },CanGoForward:{(forward) in
            print("web can go forward: \(forward)")
        })
        
//        web.loadweb(urlStr: "http://172.20.10.2:8080/")
//        web.loadweb(urlStr: "https://github.com/matteocrippa/awesome-swift")
        let h5Path = Bundle.main.path(forResource: "test_html", ofType: "html")
        web.loadFile(fileUrl: URL(fileURLWithPath: h5Path!))
    }

    
    private func setToolBar() {
        if let toolbar = self.navigationController?.toolbar as? ToolBar {
            toolbar.setupItems()
            self.setToolbarItems(toolbar.items, animated: true)
            toolbar.backBtnItem.isEnabled = false
        }
    }
    
    

    func updateSearchBar(height: CGFloat) {
//        let minHeight = min(height, 20)
//        let perc = height / 56
//        let f = self.navigationController?.navigationBar.frame
//        self.navigationController?.navigationBar.setNeedsDisplay(CGRect(x: f?.origin.x ?? 0, y: f?.origin.y ?? 0, width: f?.width ?? 0, height: minHeight))

        
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
