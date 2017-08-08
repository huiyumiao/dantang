//
//  MHYCategoryAllTopicsViewController.swift
//  dantang
//
//  Created by 苗慧宇 on 08/08/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

class MHYCategoryAllTopicsViewController: UITableViewController {
    
    var allTopics = [MHYTopicModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "全部专题"
        
        loadAllTopics()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.rowHeight = MHYHomeCell.rowHeight()
        
        let nib = UINib(nibName: String(describing: MHYHomeCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: homeCellID)
    }
    
    func loadAllTopics() {
        MHYNetworkTool.sharedNetworkTool.loadCategoryCollectionsInfo(limit: 20) { (topicCollections) in
            self.allTopics = topicCollections
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTopics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCellID, for: indexPath) as! MHYHomeCell
        cell.topicItem = allTopics[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let topicListVC = MHYTopicListViewController().initWith(id: allTopics[indexPath.row].id!, type: .ViewControllerTypeTopic)
        self.navigationController?.pushViewController(topicListVC, animated: true)
    }

}
