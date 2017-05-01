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
}

extension JSONRepresentable {
    public func jsonValue<T>() -> T {
        if let selfRef = self as? T {
            return selfRef
        }
        if let boolValue = false as? T {
            if let convertible = self as? Convertible, let converted = convertible.boolConverted as? T {
                return converted
            }
            return boolValue
        }
        if let intValue = 0 as? T {
            if let convertible = self as? Convertible, let converted = convertible.intConverted as? T {
                return converted
            }
            return intValue
        }
        if let floatValue = Float(0.0) as? T {
            return floatValue
        }
        if let doubleValue = Double(0.0) as? T {
            if let convertible = self as? Convertible, let converted = convertible.doubleConverted as? T {
                return converted
            }
            return doubleValue
        }

        if let jsonValue = PureJSON() as? T {
            if let rawSelf = self as? RawJSON, let pureJSON = PureJSON(raw:rawSelf) as? T {
                return pureJSON
            }
            return jsonValue
        }

        if let jsonValue = [PureJSON]() as? T {
            if let rawList = self as? [RawJSON] {
                if let pureList =  rawList.map({ (rawJSON) -> PureJSON in
                    return PureJSON(raw:rawJSON)
                }) as? T {
                    return pureList
                }
            }
            return jsonValue
        }

        if let stringValue = "" as? T {
            if let convertible = self as? Convertible, let converted = convertible.stringConverted as? T {
                return converted
            }
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
