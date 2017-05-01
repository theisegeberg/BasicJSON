//
//  JSONRepresentable.swift
//  BasicJSON
//
//  Created by Theis Egeberg on 01/05/2017.
//  Copyright © 2017 Theis Egeberg. All rights reserved.
//

import Foundation

public protocol JSONRepresentable {
    func jsonValue<T>() -> T
    func asBool() -> Bool
    func asString() -> String
    func asDouble() -> Double
    func asFloat() -> Float
    func asInt() -> Int
    func asPureJSON() -> PureJSON
    func asPureJSONArray() -> [PureJSON]
}

extension JSONRepresentable {

    public func asBool() -> Bool {
        if let convertible = self as? Convertible {
            return convertible.boolConverted
        }
        return false
    }

    public func asString() -> String {
        if let convertible = self as? Convertible {
            return convertible.stringConverted
        }
        return ""
    }

    public func asFloat() -> Float {
        if let convertible = self as? Convertible {
            return Float(convertible.doubleConverted)
        }
        return 0.0
    }

    public func asDouble() -> Double {
        if let convertible = self as? Convertible {
            return convertible.doubleConverted
        }
        return 0.0
    }

    public func asInt() -> Int {
        if let convertible = self as? Convertible {
            return convertible.intConverted
        }
        return 0
    }

    public func asPureJSON() -> PureJSON {
        if let rawSelf = self as? RawJSON {
            return PureJSON(raw:rawSelf)
        }
        return PureJSON()
    }

    public func asPureJSONArray() -> [PureJSON] {
        if let rawList = self as? [RawJSON] {
            return rawList.map({ (rawJSON) -> PureJSON in
                return PureJSON(raw:rawJSON)
            })
        }
        return [PureJSON]()
    }

    public func jsonValue<T>() -> T {
        if let selfRef = self as? T {
            return selfRef
        }
        if let boolValue = self.asBool() as? T {
            return boolValue
        }
        if let intValue = self.asInt() as? T {
            return intValue
        }
        if let floatValue = self.asFloat() as? T {
            return floatValue
        }
        if let doubleValue = self.asDouble() as? T {
            return doubleValue
        }

        if let jsonValue = self.asPureJSON() as? T {
            return jsonValue
        }

        if let jsonValue = self.asPureJSONArray() as? T {
            return jsonValue
        }

        if let stringValue = self.asString() as? T {
            return stringValue
        }
        fatalError("Something couldn't get converted")
    }
}

extension String:JSONRepresentable {}
extension Bool:JSONRepresentable {}
extension Double:JSONRepresentable {}
extension Float:JSONRepresentable {}
extension Int:JSONRepresentable {}
extension JSON:JSONRepresentable {}
extension NSString:JSONRepresentable {}
extension Dictionary:JSONRepresentable {}
extension Array:JSONRepresentable {}
extension NSDictionary:JSONRepresentable {}
extension NSNumber:JSONRepresentable {}
