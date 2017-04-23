//
//  Post.swift
//  BasicJSON
//
//  Created by Theis Egeberg on 23/04/2017.
//  Copyright © 2017 Theis Egeberg. All rights reserved.
//

import Foundation

struct Post:JSONObject {
    let title:String
    
    init() {
        title = ""
    }
    
    init(json: [String : Any]) {
        title = json["title"] as! String
    }
}
