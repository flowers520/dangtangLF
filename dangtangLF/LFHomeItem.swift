//
//  LFHomeItem.swift
//  dangtangLF
//
//  Created by jim on 17/1/15.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFHomeItem: NSObject {
    var content_url: String?
    var cover_image_url:String?
    var created_at:Int?
    var id: Int?
    var liked_count:Int?
    var share_msg:String?
    var published_at:Int?
    var short_title:String?
    var status:Int?
    var type:String?
    var title:String?
    var template:String?
    var update_at:Int?
    var url:String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        content_url = dict["content_url"] as? String
        cover_image_url = dict["cover_image_url"] as? String
        created_at = dict["created_at"] as? Int
        id = dict["id"] as? Int
        liked_count = dict["liked_count"] as? Int
        share_msg = dict["share_msg"] as? String
        published_at = dict["published_at"] as? Int
        short_title = dict["short_title"] as? String
        status = dict["status"] as? Int
        type = dict["type"] as? String
        title = dict["title"] as? String
        template = dict["template"] as? String
        update_at = dict["update_at"] as? Int
        url = dict["url"] as? String
    }
}
