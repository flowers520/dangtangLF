

import UIKit

class LFCollectionPost: NSObject {
    var cover_image_url: String?
    var id: Int?
    var published_at: Int?
    var created_at: Int?
    var content_url: String?
    var url: String?
    var share_msg: String?
    var title: String?
    var updated_at: Int?
    var short_title: String?
    var liked: Bool?
    var likes_count: Int?
    var status: Int?
    
    init(dict: [String: AnyObject]) {
        super.init()
        cover_image_url = dict["cover_image_url"] as? String
        id = dict["id"] as? Int
        published_at = dict["published_at"] as? Int
        created_at = dict["created_at"] as? Int
        content_url = dict["content_url"] as? String
        url = dict["url"] as? String
        share_msg = dict["url"] as? String
        title = dict["title"] as? String
        updated_at = dict["update_at"] as? Int
        short_title = dict["short_title"] as? String
        liked = dict["liked"] as? Bool
        likes_count = dict["likes_count"] as? Int
        status = dict["status"] as? Int
        
    }
}
