//
//  LFChannel.swift
//  dangtangLF
//
//  Created by jim on 17/1/15.
//  Copyright © 2017年 jim. All rights reserved.
//

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
