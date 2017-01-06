//
//  DataConvertible.swift
//  ModelParser
//
//  Created by Peter Livesey on 1/6/17.
//  Copyright © 2017 Peter Livesey. All rights reserved.
//

import Foundation

/**
 This protocol is implemented by any type which we want to parse.
 This includes types like `String` and `Int` so these functions take `Any` as parameters.
 */
public protocol DataConvertible {
    /**
     Parses data into the current class and attempts to return an instance of the class.
     If a parsing error occurs, the error block will be called with a descriptive `String`.
     Even if a parsing error occurs, the function may attempt to return a 'best effort' representation of itself.
     For instance, it may choose to nil out optional fields.
     */
    static func parse(data: Any, error: (String) throws -> Void) rethrows -> Self?

    /**
     Converts the class back into a data representation.
     This is the opposite of `parse(...)`.
     */
    func dataRepresentation() -> Any
}
