//
//  JSON.swift
//  BasicJSON
//
//  Created by Theis Egeberg on 01/05/2017.
//  Copyright © 2017 Theis Egeberg. All rights reserved.
//

import Foundation

public enum JSON {
    case nothing
    case object(RawJSON)
    case list([RawJSON])

    public static func buildObject<T: JSONObject>(rawJSON: RawJSON) -> T {
        return T(json:PureJSON(raw: rawJSON))
    }

    public static func buildList<T: JSONObject>(rawJSON: [RawJSON]) -> [T] {
        return rawJSON.map({ (rawElement) -> T in
            return T(json:PureJSON(raw: rawElement))
        })
    }

    static func purify(raw: RawJSON) -> PureJSONValue {
        var retDict = [String: JSONRepresentable]()
        raw.forEach { (key, value) in
            if let jsonRepresentable = value as? JSONRepresentable {
                retDict[key] = jsonRepresentable
            }
            if let jsonRepresentable = value as? [JSONRepresentable] {
                retDict[key] = jsonRepresentable
            }
        }
        return retDict
    }

}
