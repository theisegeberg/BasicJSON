//
//  Data+JSONDecodable.swift
//  BasicJSON
//
//  Created by Theis Egeberg on 01/05/2017.
//  Copyright © 2017 Theis Egeberg. All rights reserved.
//

import Foundation

extension Data:JSONDecodable {
    public func JSON() throws -> JSON {
        let json = try JSONSerialization.jsonObject(with: self)

        if let json = self.decode(anything:json) {
            return json
        }

        if let string = String(data: self, encoding: .utf8) {
            throw JSONError.dataDecodingError(stringDecoded: string)
        }
        throw JSONError.dataDecodingErrorUndecipherable
    }

}
