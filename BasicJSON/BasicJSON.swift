//
//  BasicJSON.swift
//  BasicJSON
//
//  Created by Theis Egeberg on 20/04/2017.
//  Copyright © 2017 Theis Egeberg. All rights reserved.
//

import Foundation

public enum JSONError:LocalizedError {
    case dataDecodingErrorUndecipherable
    case dataDecodingError(stringDecoded:String)
    case wrongBaseTypeForBuilding(expectedType:String)
    
    
    public var errorDescription: String? {
        switch self {
        case .dataDecodingErrorUndecipherable:
            return "Error decoding data, undecipherable"
        case .dataDecodingError(stringDecoded: let decoded):
            return "Error decoding data \(decoded)"
        case .wrongBaseTypeForBuilding(expectedType: let type):
            return "Wrong base type for building objects. Expected: \(type)"
        }
    }
}

public typealias RawJSON = [String:Any]
public typealias PureJSONValue = [String:JSONRepresentable]



public struct PureJSON {
    let value:PureJSONValue
    
    init() {
        value = PureJSONValue()
    }
    
    init(raw:RawJSON) {
        value = JSON.purify(raw: raw)
    }
    
    subscript(key: String) -> JSONRepresentable {
        get {
            if let value = self.value[key] {
                return value
            }
            return ""
        }
    }
    
    
}





protocol Convertible {
    var stringConverted:String { get }
    var doubleConverted:Double { get }
    var intConverted:Int { get }
    
}

extension Convertible {
    var stringConverted:String { return "" }
    var doubleConverted:Double { return 0 }
    var intConverted:Int { return 0 }
    var boolConverted:Bool { return false }
}

extension NSString:Convertible {
    var stringConverted: String {
        return String(self)
    }
}

extension NSNumber:Convertible {
    var doubleConverted:Double {
        return Double(self)
    }
    var intConverted:Int {
        return Int(self)
    }
    var boolConverted:Bool {
        return Bool(self)
    }
}







public protocol JSONRepresentable {
    func jsonValue<T>() -> T
}

extension JSONRepresentable {
    public func jsonValue<T>() -> T {
        if let selfRef = self as? T {
            return selfRef
        }
        if let boolValue = false as? T {
            if let convertible = self as? Convertible {
                return convertible.boolConverted as! T
            }
            return boolValue
        }
        if let intValue = 0 as? T {
            if let convertible = self as? Convertible {
                return convertible.intConverted as! T
            }
            return intValue
        }
        if let floatValue = Float(0.0) as? T {
            return floatValue
        }
        if let doubleValue = Double(0.0) as? T {
            if let convertible = self as? Convertible {
                return convertible.doubleConverted as! T
            }
            return doubleValue
        }
        
        if let jsonValue = PureJSON() as? T {
            if let rawSelf = self as? RawJSON {
                return PureJSON(raw:rawSelf) as! T
            }
            return jsonValue
        }
        
        if let jsonValue = [PureJSON]() as? T {
            if let rawList = self as? [RawJSON] {
                return rawList.map({ (rawJSON) -> PureJSON in
                    return PureJSON(raw:rawJSON)
                }) as! T
            }
            return jsonValue
        }
        
        if let stringValue = "" as? T {
            if let convertible = self as? Convertible {
                return convertible.stringConverted as! T
            }
            return stringValue
        }
        return self as! T
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





public enum JSON {
    case nothing
    case object(RawJSON)
    case list([RawJSON])
    
    func buildObject<T:JSONObject>() throws -> T {
        switch self {
        case .object(let rawJSON):
            return T(json:PureJSON(raw: rawJSON))
        default:
            throw JSONError.wrongBaseTypeForBuilding(expectedType: ".object")
        }
    }
    
    func buildList<T:JSONObject>() throws -> [T] {
        switch self {
        case .list(let list):
            let mappedList = list.map({ (rawJSON) -> T in
                return T(json:PureJSON(raw: rawJSON))
            })
            return mappedList
        default:
            throw JSONError.wrongBaseTypeForBuilding(expectedType: ".list")
        }
    }
    
    static func purify(raw:RawJSON) -> PureJSONValue {
        var retDict = [String:JSONRepresentable]()
        raw.forEach { (key,value) in
            if let jsonRepresentable = value as? JSONRepresentable {
                retDict[key] = jsonRepresentable
            }
        }
        return retDict
    }
    
}


public protocol JSONObject {
    init()
    init(json:PureJSON)
}


public protocol JSONDecodable {
    func JSON() throws -> JSON
}


extension JSONDecodable {
    func decode(anything:Any) -> JSON? {
        if let json = anything as? RawJSON {
            return .object(json)
        }
        if let json = anything as? [RawJSON] {
            return .list(json)
        }
        return nil
    }
}



extension Data:JSONDecodable {
    public func JSON() throws -> JSON {
        let json = try! JSONSerialization.jsonObject(with: self)
        
        if let json = self.decode(anything:json) {
            return json
        }
        
        if let string = String(data: self, encoding: .utf8) {
            throw JSONError.dataDecodingError(stringDecoded: string)
        }
        throw JSONError.dataDecodingErrorUndecipherable
    }
    
}









