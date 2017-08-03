//
//  MHYActionSheet.swift
//  dantang
//
//  Created by 苗慧宇 on 07/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

class MHYActionSheet: UIView {

    class func show() {
        let actionSheet = MHYActionSheet()
        actionSheet.frame = UIScreen.main.bounds
        actionSheet.backgroundColor = MHYColor(r: 0, g: 0, b: 0, a: 0.6)
        
        let window = UIApplication.shared.keyWindow
        window?.addSubview(actionSheet)
    }

}
