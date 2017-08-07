//
//  MHYCategoryViewController.swift
//  dantang
//
//  Created by 苗慧宇 on 02/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

class MHYCategoryViewController: MHYBaseViewController {
    
    var collections = [MHYTopicModel]()
    var channelGroups = [MHYChannelGroupModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        loadCollections()
        loadChannelGroups()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        let topicNib = UINib(nibName: String(describing: MHYCategoryTopicsCellTableViewCell.self), bundle: nil)
        tableView.register(topicNib, forCellReuseIdentifier: TopicCollectionsCell)
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    func loadCollections() {
        MHYNetworkTool.sharedNetworkTool.loadCategoryCollectionsInfo { (topicCollections) in
            self.collections = topicCollections
            self.tableView.reloadData()
        }
    }
    
    func loadChannelGroups() {
        MHYNetworkTool.sharedNetworkTool.loadChannelGroups { (channelGroups) in
            self.channelGroups = channelGroups
            self.tableView.reloadData()
        }
    }

}

extension MHYCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let topicsCell = tableView.dequeueReusableCell(withIdentifier: TopicCollectionsCell, for: indexPath) as! MHYCategoryTopicsCellTableViewCell
            topicsCell.topicCollections = collections
            
            topicsCell.topicListCloser = { id in
                let topicListVC = MHYTopicListViewController().initWith(topicId: id)
                self.navigationController?.pushViewController(topicListVC, animated: true)
            }
            
            return topicsCell
            
        } else {
            var channelCell = tableView.dequeueReusableCell(withIdentifier: ChannelGroupCell) as? MHYChannelGroupCell
            if channelCell == nil {
                channelCell = MHYChannelGroupCell(style: .default, reuseIdentifier: ChannelGroupCell)
            }
            channelCell?.channelGroup = channelGroups[indexPath.row - 1]
            
            return channelCell!
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelGroups.count + (collections.count > 0 ? 1 : 0)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return MHYCategoryTopicsCellTableViewCell.rowHeight()
        } else {
            let count = channelGroups[indexPath.row - 1].channels?.count
            
            return MHYChannelGroupCell.rowBaseHeight() +  MHYChannelGroupCell.extraBaseHeight() * CGFloat(floor(Float(count! / 5)))
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
