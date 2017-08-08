//
//  MHYTopicTableViewController.swift
//  dantang
//
//  Created by 苗慧宇 on 02/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit
import SVProgressHUD

class MHYTopicTableViewController: UITableViewController, MHYHomeCellDelegate {
    
    var type = Int()
    
    var items = [MHYHomeItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = MHYGlobalColor()
        
        setupTableView()
        
        
        // 添加刷新控件
//        refreshControl = UIRefreshControl()
//        refreshControl?.addTarget(self, action: #selector(loadHomeData), for: .valueChanged)
        
//        tableView.mj_header = MJRefreshHeader.init(refreshingBlock: { 
//            print("refreshing")
//            sleep(5)
//            self.tableView.mj_header.endRefreshing()
//        })
        
        let gifHeader = MJRefreshGifHeader.init { 
            print("refreshing")
//            sleep(2)
//            self.tableView.mj_header.endRefreshing()
            self.loadHomeData()
        }
        
        gifHeader?.setTitle("", for: .idle)
        gifHeader?.setTitle("", for: .pulling)
        gifHeader?.setTitle("", for: .refreshing)
        gifHeader?.setTitle("", for: .idle)
        gifHeader?.stateLabel.text = ""
        gifHeader?.lastUpdatedTimeText = { _ in return "" }
        gifHeader?.labelLeftInset = -10
        gifHeader?.setImages([#imageLiteral(resourceName: "tableview_loading_0"),
                              #imageLiteral(resourceName: "tableview_loading_1"),
                              #imageLiteral(resourceName: "tableview_loading_2"),
                              #imageLiteral(resourceName: "tableview_loading_3"),
                              #imageLiteral(resourceName: "tableview_loading_4"),
                              #imageLiteral(resourceName: "tableview_loading_5"),
                              #imageLiteral(resourceName: "tableview_loading_6"),
                              #imageLiteral(resourceName: "tableview_loading_7"),
                              #imageLiteral(resourceName: "tableview_loading_8"),
                              #imageLiteral(resourceName: "tableview_loading_9")], duration: 0.8, for: .refreshing)
        gifHeader?.setImages([#imageLiteral(resourceName: "tableview_pull_refresh")], duration: 2.0, for: .idle)
        gifHeader?.setImages([#imageLiteral(resourceName: "tableview_release_refresh")], duration: 2.0, for: .pulling)
        tableView.mj_header = gifHeader
        
        // 获取首页数据
//        refreshControl?.beginRefreshing()
        
        loadHomeData()
    }
    
    // MARK: - 获取首页数据
    func loadHomeData() {
        weak var weakSelf = self
        MHYNetworkTool.sharedNetworkTool.loadHomeInfo(id: type) { (homeItems) in
            weakSelf!.items = homeItems
            weakSelf!.tableView.reloadData()
            weakSelf?.tableView.mj_header.endRefreshing()
//            weakSelf!.refreshControl?.endRefreshing()
        }
    }
    
    func setupTableView() {
        tableView.rowHeight = MHYHomeCell.rowHeight()
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsetsMake(kTitlesViewH + kTitlesViewY, 0, tabBarController!.tabBar.height, 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        let nib = UINib(nibName: String(describing: MHYHomeCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: homeCellID)
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = MHYDetailViewController()
        detailVC.homeItem = items[indexPath.row]
        detailVC.title = "攻略详情"
        navigationController?.pushViewController(detailVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCell = tableView.dequeueReusableCell(withIdentifier: homeCellID, for: indexPath) as! MHYHomeCell
        homeCell.homeItem = items[indexPath.row]
        homeCell.delegate = self
        
        if #available(iOS 9.0, *) {
            registerForPreviewing(with: self, sourceView: homeCell)
        } else {
            // Fallback on earlier versions
        }

        return homeCell
    }

    // MARK: - YMHomeCellDelegate
    func homeCellDidClickedFavoriteButton(button: UIButton) {
        if !UserDefaults.standard.bool(forKey: isLogin) {
            SVProgressHUD.showInfo(withStatus: "还未登录。。。")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MHYTopicTableViewController:  UIViewControllerPreviewingDelegate{
    @available(iOS 9.0, *)
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
//        showDetailViewController(viewControllerToCommit, sender: self)
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }

    
    @available(iOS 9.0, *)
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let detailVC = MHYDetailViewController()
        let indexPath = self.tableView.indexPath(for: (previewingContext.sourceView) as! MHYHomeCell)! as NSIndexPath
        detailVC.homeItem = items[indexPath.row]
        detailVC.title = "攻略详情"

        return detailVC
    }
    
    @available(iOS 9.0, *)
    override var previewActionItems: [UIPreviewActionItem] {
        let action1 = UIPreviewAction(title: "Action One",
                                      style: .destructive,
                                      handler: { previewAction, viewController in
                                        print("Action One Selected")
        })
        
        let action2 = UIPreviewAction(title: "Action Two",
                                      style: .selected,
                                      handler: { previewAction, viewController in
                                        print("Action Two Selected")
        })
        
        let groupAction1 = UIPreviewAction(title: "Group Action One",
                                           style: .default,
                                           handler: { previewAction, viewController in
                                            print("Group Action One Selected")
        })
        
        let groupAction2 = UIPreviewAction(title: "Group Action Two",
                                           style: .default,
                                           handler: { previewAction, viewController in
                                            print("Group Action Two Selected")
        })
        
        let groupActions = UIPreviewActionGroup(title: "My Action Group...",
                                                style: .default,
                                                actions: [groupAction1, groupAction2])
        
        return [action1, action2, groupActions]
    }
    
}
