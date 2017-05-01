//
//  JSONDecodable.swift
//  BasicJSON
//
//  Created by Theis Egeberg on 01/05/2017.
//  Copyright © 2017 Theis Egeberg. All rights reserved.
//

import Foundation

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
