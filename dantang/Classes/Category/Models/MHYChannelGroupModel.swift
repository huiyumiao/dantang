//
//  MHYChannelGroupModel.swift
//  dantang
//
//  Created by 苗慧宇 on 07/08/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit
import SwiftyJSON

class MHYChannelModel: NSObject {
    
    var group_id: Int?
    var icon_url: String?
    var name: String?
    var id: Int?
    var items_count: Int?
    var order: Int?
    var status: Int?
    
    init(dict: [String: AnyObject]) {
        super.init()

        group_id    = dict["group_id"] as? Int
        icon_url    = dict["icon_url"] as? String
        name        = dict["name"] as? String
        id          = dict["id"] as? Int
        items_count = dict["items_count"] as? Int
        order       = dict["order"] as? Int
        status      = dict["status"] as? Int
    }
}


class MHYChannelGroupModel: NSObject {

    var id: Int?
    var name: String?
    var order: Int?
    var status: Int?
    var channels: [MHYChannelModel]?
    
    init(dict: [String: AnyObject]) {
        super.init()

        id     = dict["id"] as? Int
        name   = dict["name"] as? String
        order  = dict["order"] as? Int
        status = dict["status"] as? Int
    }
    
    convenience init(json: JSON) {
        
        self.init(dict: json.dictionaryObject! as [String: AnyObject])
        
        var channels = [MHYChannelModel]()
        if let items = json["channels"].arrayObject {
            for item in items {
                let channel = MHYChannelModel(dict: item as! [String: AnyObject])
                channels.append(channel)
            }
        }
        self.channels = channels
    }
}
