//
//  JSONObject.swift
//  BasicJSON
//
//  Created by Theis Egeberg on 01/05/2017.
//  Copyright © 2017 Theis Egeberg. All rights reserved.
//

import Foundation

public protocol JSONObject {
    init()
    init(json: PureJSON)
}
