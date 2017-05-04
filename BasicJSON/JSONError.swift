//
//  JSONError.swift
//  BasicJSON
//
//  Created by Theis Egeberg on 01/05/2017.
//  Copyright © 2017 Theis Egeberg. All rights reserved.
//

import Foundation

public enum JSONError: LocalizedError {
    case dataDecodingErrorUndecipherable
    case dataDecodingError(stringDecoded:String)

    public var errorDescription: String? {
        switch self {
        case .dataDecodingErrorUndecipherable:
            return "Error decoding data, undecipherable"
        case .dataDecodingError(stringDecoded: let decoded):
            return "Error decoding data \(decoded)"
        }
    }
}
