//
//  MHYChannelGroupCell.swift
//  dantang
//
//  Created by 苗慧宇 on 07/08/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

let ChannelGroupCell = "MHYChannelGroupCell"

class MHYChannelGroupCell: UITableViewCell {
    
    
    var titleLabel = UILabel()
    
    var margin = CGFloat()
    var itemWidth = CGFloat()
    var itemHeight = CGFloat()
    
    static func rowBaseHeight() -> CGFloat {
        return 155
    }
    
    static func extraBaseHeight() -> CGFloat {
        return 112
    }


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 顶部10像素的间隔视图
        let topSeparatorView = UIView()
        topSeparatorView.backgroundColor = UIColor.groupTableViewBackground
        contentView.addSubview(topSeparatorView)
        topSeparatorView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(10)
        }
        // 顶部2条0.5像素的分割线
        let topSeparatorLine1 = UIView()
        topSeparatorLine1.backgroundColor = UIColor.lightGray
        topSeparatorView.addSubview(topSeparatorLine1)
        topSeparatorLine1.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(topSeparatorView)
            make.height.equalTo(0.5)
        }
        let topSeparatorLine2 = UIView()
        topSeparatorLine2.backgroundColor = UIColor.lightGray
        topSeparatorView.addSubview(topSeparatorLine2)
        topSeparatorLine2.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(topSeparatorView)
            make.height.equalTo(0.5)
        }
        
        //
        titleLabel = UILabel()
        titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topSeparatorView.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(10)
        }
        
        /// item.width = (screenWidth - x 方向所有间隔) / 4
        self.margin = 10
        self.itemWidth  = (SCREENW - margin * (2 + 3 * 2)) / 4
        self.itemHeight = itemWidth + 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var channelGroup: MHYChannelGroupModel? {
        didSet {
            titleLabel.text = channelGroup?.name
            for item in (channelGroup?.channels)!.enumerated() {
                subItem(channel: item.element, index: item.offset)
            }
        }
    }
    
    
    fileprivate func subItem(channel: MHYChannelModel, index: Int) {
        let container = UIView()
        contentView.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10 + CGFloat(floorf(Float(index / 4))) * (itemHeight + 2 * margin))
            make.left.equalTo(contentView).offset(margin + CGFloat(index % 4) * (itemWidth + 2 * margin))
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemHeight)
        }
        
        let imgView = UIImageView()
        imgView.backgroundColor = UIColor.groupTableViewBackground
        imgView.layer.cornerRadius = itemWidth / 2
        imgView.layer.masksToBounds = true
        imgView.kf.setImage(with: URL(string: channel.icon_url!), placeholder: nil, options: nil, progressBlock: nil) { (_, _, _, _) in
            
        }
        container.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(container)
            make.height.equalTo(itemWidth)
        }
        
        
        let titleLabel = UILabel()
        titleLabel.text = channel.name
        titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        titleLabel.textAlignment = .center
        container.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(5)
            make.centerX.equalTo(imgView)
        }
    }
}







