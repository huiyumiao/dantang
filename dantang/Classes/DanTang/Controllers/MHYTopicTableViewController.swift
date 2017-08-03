//
//  MHYTopicTableViewController.swift
//  dantang
//
//  Created by 苗慧宇 on 02/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit
import SVProgressHUD

let homeCellID = "homeCellID"

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
            sleep(2)
            self.tableView.mj_header.endRefreshing()
        }
        
        
        gifHeader?.setImages([UIImage.init(named: "tableview_loading")!], duration: 3.0, for: .refreshing)
        gifHeader?.setImages([UIImage.init(named: "arrow_index_down_8x4_")!], duration: 2.0, for: .idle)
        gifHeader?.setImages([UIImage.init(named: "arrow_index_up_8x4_")!], duration: 2.0, for: .pulling)
        tableView.mj_header = gifHeader
        
        // 获取首页数据
        refreshControl?.beginRefreshing()
        loadHomeData()
    }
    
    // MARK: - 获取首页数据
    func loadHomeData() {
        weak var weakSelf = self
        MHYNetworkTool.sharedNetworkTool.loadHomeInfo(id: type) { (homeItems) in
            weakSelf!.items = homeItems
            weakSelf!.tableView.reloadData()
            weakSelf!.refreshControl?.endRefreshing()
        }
    }
    
    func setupTableView() {
        tableView.rowHeight = 160
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
        homeCell.selectionStyle = .none
        homeCell.homeItem = items[indexPath.row]
        homeCell.delegate = self

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
