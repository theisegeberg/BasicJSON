//
//  BasicJSON.swift
//  BasicJSON
//
//  Created by Theis Egeberg on 20/04/2017.
//  Copyright © 2017 Theis Egeberg. All rights reserved.
//

import Foundation

public enum JSONError:Error {
    case unknown(String)
}

public typealias rawJSON = [String:Any]

public class JSONWrapper {
    
}

public enum JSON {
    case nothing
    case object(rawJSON)
    case list([rawJSON])
    
    func buildObject<T:JSONObject>() -> T? {
        switch self {
        case .object(let object):
            return T(json:object)
        default:
            break
        }
        return nil
    }
    
    func buildList<T:JSONObject>() -> [T]? {
        switch self {
        case .list(let list):
            let mappedList = list.map({ (json) -> T in
                return T(json:json)
            })
            return mappedList
        default:
            break
        }
        return nil
    }
}

public protocol JSONDecodable {
    func JSON() throws -> JSON
}

public protocol JSONObject {
    init()
    init(json:[String:Any])
}



extension JSONDecodable {
    func decode(anything:Any) -> JSON? {
        if let json = anything as? rawJSON {
            return .object(json)
        }
        if let json = anything as? [rawJSON] {
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
            throw JSONError.unknown("Couldn't decode data to object:\n\(string))")
        }
        throw JSONError.unknown("Couldn't even decode data to a string")
    }
    
}









