//
//  Post.swift
//  BasicJSON
//
//  Created by Theis Egeberg on 23/04/2017.
//  Copyright © 2017 Theis Egeberg. All rights reserved.
//

import Foundation

struct Location: JSONObject {

    let latitude: Double
    let longitude: Double

    init() {
        latitude = 0
        longitude = 0
    }

    init(json: PureJSON) {
        latitude = json["latitude"].jsonValue()
        longitude = json["longitude"].jsonValue()
    }

}

struct Post: JSONObject {

    let title: String
    let location: Location
    let userId: Int
    let body: String
    let show: Bool

    init() {
        title = ""
        location = Location()
        userId = 0
        body = ""
        show = false
    }

    init(json: PureJSON) {
        title = json["title"].jsonValue()
        location = json["location"].toObject()
        userId = json["userId"].jsonValue()
        body = json["body"].jsonValue()
        show = json["show"].jsonValue()
    }
}
