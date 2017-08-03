//
//  MHYChannel.swift
//  dantang
//
//  Created by 苗慧宇 on 02/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

class MHYChannel: NSObject {
    var editable: Bool?
    var id: Int?
    var name: String?
    
    init(dict: [String: AnyObject]) {
        editable = dict["editable"] as? Bool
        id = dict["id"] as? Int
        name = dict["name"] as? String
    }
}
