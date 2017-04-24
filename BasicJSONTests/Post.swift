//
//  Post.swift
//  BasicJSON
//
//  Created by Theis Egeberg on 23/04/2017.
//  Copyright © 2017 Theis Egeberg. All rights reserved.
//

import Foundation

struct Location:JSONObject {
    
    let latitude:Double
    let longitude:Double
    
    init() {
        latitude = 0
        longitude = 0
    }
    
    init(json: PureJSON) {
        
        latitude = 0
        longitude = 0
    }
    
}

struct Post:JSONObject {

    let title:String
    let location:Location
    
    init() {
        title = ""
        location = Location()
    }
    
    init(json: PureJSON) {
        
        
        title = ""
        location = Location(json: (json["location"]?.jsonValue())!)
        
        let warning = "warning"
        print(warning,title,location)
        
    }
}
