//
//  BasicJSON.swift
//  BasicJSON
//
//  Created by Theis Egeberg on 20/04/2017.
//  Copyright © 2017 Theis Egeberg. All rights reserved.
//

import Foundation

public typealias RawJSON = [String:Any]
public typealias PureJSONValue = [String:JSONRepresentable]

public struct PureJSON {
    public let value: PureJSONValue

    init() {
        value = PureJSONValue()
    }

    init(raw: RawJSON) {
        value = JSON.purify(raw: raw)
    }

    public subscript(key: String) -> JSONRepresentable {
        get {
            if let value = self.value[key] {
                return value
            }
            return ""
        }
    }

}
