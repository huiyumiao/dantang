//
//  MHYTopicModel.swift
//  dantang
//
//  Created by 苗慧宇 on 04/08/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

class MHYTopicModel: NSObject {
    
    var banner_image_url: String?
    var cover_image_url: String?
    var title: String?
    var subtitle: String?
    var id: Int?
    var status: Int?
    var posts_count: Int?
    var created_at: Int?
    var updated_at: Int?
    
    init(dict: [String: AnyObject]) {
        super.init()

        banner_image_url = dict["banner_image_url"] as? String
        cover_image_url  = dict["cover_image_url"] as? String
        title            = dict["title"] as? String
        subtitle         = dict["subtitle"] as? String
        id               = dict["id"] as? Int
        status           = dict["status"] as? Int
        posts_count      = dict["posts_count"] as? Int
        created_at       = dict["created_at"] as? Int
        updated_at       = dict["updated_at"] as? Int
    }

}
