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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        loadCollections()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib.init(nibName: String(describing: MHYCategoryTopicsCellTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TopicCollectionsCell)
        tableView.rowHeight = MHYCategoryTopicsCellTableViewCell.rowHeight()
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

}

extension MHYCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableView dataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let topicsCell = tableView.dequeueReusableCell(withIdentifier: TopicCollectionsCell, for: indexPath) as! MHYCategoryTopicsCellTableViewCell
        topicsCell.topicCollections = collections
        
        return topicsCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
