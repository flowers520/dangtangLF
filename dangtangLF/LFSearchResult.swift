

import UIKit

class LFSearchResult: NSObject {
    var favorites_count: Int?
    var likes_count: Int?
    var id: Int?
    var price: String?
    var liked: Bool?
    var cover_image_url: String?
    var describle: String?
    var name: String?
    
    init(dict: [String: AnyObject]){
        id = dict["id"] as? Int
        name = dict["name"] as? String
        favorites_count = dict["favorites_count"] as? Int
        price = dict["price"] as? String
        liked = dict["liked"] as? Bool
        likes_count = dict["likes_count"] as? Int
        cover_image_url = dict["cover_image_url"] as? String
        describle = dict["describle"] as? String
        
        
    }
    

}
