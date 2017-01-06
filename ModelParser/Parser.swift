//
//  Parser.swift
//  ModelParser
//
//  Created by Peter Livesey on 1/6/17.
//  Copyright © 2017 Peter Livesey. All rights reserved.
//

import Foundation

/**
 This is a convenience class used by the model parsing to reduce the amount of generated code.
 */
public struct Parser {
    /**
     The dictionary we are going to parse.
     This is an NSDictionary because it makes parsing much faster than `[AnyHashable: Any]`.
     */
    public let dictionary: NSDictionary?

    public init(dictionary: NSDictionary?) {
        self.dictionary = dictionary
    }

    /**
     Attempts to fetch a value from the dictionary.
     If the key is missing it will return nil.
     Otherwise, it will attempt to parse the data value.
     */
    public func fetch<T: DataConvertible>(_ key: String, error: (String) throws -> Void) rethrows -> T? {
        guard let value = dictionary?[key] else  {
            return nil
        }
        return try T.parse(data: value, error: error)
    }

    /**
     Attempts to fetch a value from an array.
     If the key is missing it will call the error block and return an empty array.
     Otherwise, it will attempt to parse the array.
     */
    public func fetch<T: DataConvertible>(_ key: String, error: (String) throws -> Void) rethrows -> [T] {
        guard let fetched = dictionary?[key] else {
            try error("The key '\(key)' was not found.")
            return []
        }
        // NOTE: Do not use [Any] here. Casting to NSArray is much faster.
        if let fetchedArray = fetched as? NSArray {
            return try fetchedArray.flatMap { try T.parse(data: $0, error: error) }
        } else {
            try error("The key '\(key)' was the wrong type.")
            return []
        }
    }

    /**
     Attempts to fetch a value from an optional array.
     If the key is missing it will return nil.
     Otherwise, it will attempt to parse the array.
     */
    public func fetch<T: DataConvertible>(_ key: String, error: (String) throws -> Void) rethrows -> [T]? {
        let fetchedOptional = dictionary?[key]
        guard let fetched = fetchedOptional else {
            return nil
        }
        // NOTE: Do not use [Any] here. Casting to NSArray is much faster.
        if let fetchedArray = fetched as? NSArray {
            return try fetchedArray.flatMap { try T.parse(data: $0, error: error) }
        } else {
            try error("The key '\(key)' was the wrong type.")
            return nil
        }
    }
}

/**
 A parse error thrown when parsing models.
 */
public struct ParseError: Error {
    public let message: String
}
