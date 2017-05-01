//
//  Convertible.swift
//  BasicJSON
//
//  Created by Theis Egeberg on 01/05/2017.
//  Copyright © 2017 Theis Egeberg. All rights reserved.
//

import Foundation

protocol Convertible {
    var stringConverted: String { get }
    var doubleConverted: Double { get }
    var intConverted: Int { get }
    var boolConverted: Bool { get }
}

extension Convertible {
    var stringConverted: String { return "" }
    var doubleConverted: Double { return 0 }
    var intConverted: Int { return 0 }
    var boolConverted: Bool { return false }
}

extension NSString:Convertible {
    var stringConverted: String {
        return String(self)
    }
    var intConverted: Int {
        return self.integerValue
    }
    var doubleConverted: Double {
        return self.doubleValue
    }
    var boolConverted: Bool {
        return self.boolValue
    }
}

extension NSNumber:Convertible {
    var doubleConverted: Double {
        return Double(self)
    }
    var intConverted: Int {
        return Int(self)
    }
    var boolConverted: Bool {
        return Bool(self)
    }
}
