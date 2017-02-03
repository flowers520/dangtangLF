//
//  LFProductDetail.swift
//  dangtangLF
//
//  Created by jim on 17/2/1.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit

class LFProductDetail: NSObject {

    var describe:String?
    var liked: Bool?
    var url:String?
    var purchase_url: String?
    var image_urls: [String]?
    var comments_count: Int?
    var detail_html: String?
    var name: String?
    var id: Int?
    var price: String?
    
    init(dict: [String: AnyObject]) {
        describe = dict["describe"] as? String
        liked = dict["liked"] as? Bool
        url = dict["url"] as? String
        purchase_url = dict["purchase_url"] as? String
        image_urls = dict["image_urls"] as? [String]
        comments_count = dict["comments_count"] as? Int
        detail_html = dict["detail_html"] as? String
        name = dict["name"] as? String
        id = dict["id"] as? Int
        price = dict["price"] as? String
    }
}
