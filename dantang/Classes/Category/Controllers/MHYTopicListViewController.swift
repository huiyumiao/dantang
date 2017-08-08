//
//  MHYTopicListViewController.swift
//  dantang
//
//  Created by 苗慧宇 on 07/08/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

enum ViewControllerType {
    case ViewControllerTypeTopic
    case ViewControllerTypeChannel
}

class MHYTopicListViewController: UITableViewController {
    
    var id = Int()
    
    var items = [MHYPostModel]()
    
    func initWith(id: Int, type: ViewControllerType) -> MHYTopicListViewController {
        self.id = id
        if type == .ViewControllerTypeTopic {
            loadTopicList()
        } else {
            loadChannelItems()
        }
        
        return self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        tableView.rowHeight = MHYHomeCell.rowHeight()
        tableView.separatorStyle = .none
        let nib = UINib(nibName: String(describing: MHYHomeCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: homeCellID)
    }
    

    fileprivate func loadTopicList() {
        weak var weakSelf = self
        MHYNetworkTool.sharedNetworkTool.loadTopicData(id: id) { (topicList) in
            weakSelf?.title = topicList.title
            weakSelf?.items = topicList.posts!
            weakSelf?.tableView.reloadData()
        }
    }
    
    fileprivate func loadChannelItems() {
        weak var weakSelf = self
        MHYNetworkTool.sharedNetworkTool.loadChannelitems(id: id) { (channelItems) in
            weakSelf?.items = channelItems
            weakSelf?.tableView.reloadData()
        }
    }

}

// MARK: - UITableView Delegates & DataSources
extension MHYTopicListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCellID, for: indexPath) as! MHYHomeCell
        cell.postItem = items[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = MHYDetailViewController()
        detailVC.topicItem = items[indexPath.row]
        detailVC.title = "攻略详情"
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
