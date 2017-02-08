

import UIKit

class LFChannel: NSObject {
    var editable: Bool?
    var id: Int?
    var name: String?
    
    init(dict:[String: AnyObject]){
        id = dict["id"] as? Int
        name = dict["name"] as? String
        editable = dict["editable"] as? Bool
    }
}
