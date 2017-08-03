//
//  UITableView+EmptyData.swift
//  DanTang
//
//  Created by 苗慧宇 on 02/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

public extension UITableView {
    func tableView(message: String, image: String, cellCount: Int) {
//        if cellCount == 0 {
//            // 没有数据，显示图片
//            let button = MHYVerticalButton()
//            button.setTitleColor(MHYColor(r: 200, g: 200, b: 200, a: 1.0), for: .normal)
//            button.setTitle(message, for: .normal)
//            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
//            button.setImage(UIImage(named: image), for: .normal)
//            button.addTarget(self, action: #selector(emptyButtonClick), for: .touchUpInside)
//            button.imageView?.sizeToFit()
//            backgroundView = button
//            separatorStyle = .none
//        } else {
//            backgroundView = nil
//            separatorStyle = .singleLine
//        }
    }
    
    func emptyButtonClick() {
        print("---")
    }
}
