//
//  MHYPostModel.swift
//  dantang
//
//  Created by 苗慧宇 on 04/08/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit
import SwiftyJSON

class MHYPostModel: NSObject {
    
    var content_url: String?
    var cover_image_url: String?
    var share_msg: String?
    var title: String?
    var short_title: String?
    var url: String?
    var id: Int?
    var likes_count: Int?
    var published_at: Int?
    var status: Int?
    var updated_at: Int?
    var created_at: Int?
    var liked: Bool?
    var label_ids: [AnyObject]?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        content_url     = dict["content_url"] as? String
        cover_image_url = dict["cover_image_url"] as? String
        share_msg       = dict["share_msg"] as? String
        title           = dict["title"] as? String
        short_title     = dict["short_title"] as? String
        url             = dict["url"] as? String
        id              = dict["id"] as? Int
        likes_count     = dict["likes_count"] as? Int
        published_at    = dict["published_at"] as? Int
        status          = dict["status"] as? Int
        updated_at      = dict["updated_at"] as? Int
        created_at      = dict["created_at"] as? Int
        liked           = dict["liked"] as? Bool
        label_ids       = dict["label_ids"] as? [AnyObject]

    }

}

class MHYPostListModel: NSObject {
    
    var banner_image_url: String?
    var cover_image_url: String?
    var subtitle: String?
    var title: String?
    var id: Int?
    var posts_count: Int?
    var created_at: Int?
    var updated_at: Int?
    var status: Int?
    var paging: AnyObject?
    var posts: [MHYPostModel]?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        banner_image_url = dict["banner_image_url"] as? String
        cover_image_url  = dict["cover_image_url"] as? String
        subtitle         = dict["subtitle"] as? String
        title            = dict["title"] as? String
        id               = dict["id"] as? Int
        posts_count      = dict["posts_count"] as? Int
        created_at       = dict["created_at"] as? Int
        status           = dict["status"] as? Int
        updated_at       = dict["updated_at"] as? Int
        paging           = dict["paging"]
        
    }

    convenience init?(json: JSON) {
        
        if let data = json["data"].dictionaryObject {
            self.init(dict: data as [String: AnyObject])
            
            if let data = json["data"].dictionary {
                var allPost = [MHYPostModel]()
                if let posts = data["posts"]?.arrayObject {
                    for item in posts {
                        let post = MHYPostModel(dict: item as! [String: AnyObject])
                        allPost.append(post)
                    }
                }
                posts = allPost
            }
        } else {
            return nil
        }
        
    }
}
