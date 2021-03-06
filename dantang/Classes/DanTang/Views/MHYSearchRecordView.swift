//
//  MHYSearchRecordView.swift
//  dantang
//
//  Created by 苗慧宇 on 05/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

class MHYSearchRecordView: UIView {

    // 关键字
    var words = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 搜索界面数据获取热搜关键词
        weak var weakSelf = self
        MHYNetworkTool.sharedNetworkTool.loadHotWords { (hot_words) in
            weakSelf!.words = hot_words
            weakSelf!.setupUI()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setupUI() {
        
        // 大家都在搜
        let topView = UIView()
        addSubview(topView)
        let hotLabel = setupLabel(title: "大家都在搜")
        hotLabel.frame = CGRect(x: 10, y: 20, width: 200, height: 20)
        topView.addSubview(hotLabel)
        
        // 历史纪录
        let bottomView = UIView()
        
        addSubview(bottomView)
    }
    
    func setupLabel(title: String) -> UILabel {
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = MHYColor(r: 0, g: 0, b: 0, a: 0.6)
        return label
    }
}
