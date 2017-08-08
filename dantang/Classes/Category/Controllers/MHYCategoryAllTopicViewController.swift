//
//  MHYCategoryAllTopicViewController.swift
//  dantang
//
//  Created by 苗慧宇 on 08/08/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

class MHYCategoryAllTopicViewController: UITableViewController {
    
    var topicModels = [MHYTopicModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "全部专题"
        
        tableView.rowHeight = MHYHomeCell.rowHeight()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        let nib = UINib(nibName: String(describing: MHYHomeCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: homeCellID)
        
        loadAllTopic()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAllTopic() {
        MHYNetworkTool.sharedNetworkTool.loadCategoryCollectionsInfo(limit: 20) { (topics) in
            self.topicModels = topics
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCellID, for: indexPath) as! MHYHomeCell
        cell.selectionStyle = .none
        cell.topicItem = topicModels[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let topicListVC = MHYTopicListViewController().initWith(id: topicModels[indexPath.row].id!, type: .ViewControllerTypeTopic)
        self.navigationController?.pushViewController(topicListVC, animated: true)
    }
}
