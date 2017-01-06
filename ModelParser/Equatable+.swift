//
//  Equatable+.swift
//  ModelParser
//
//  Created by Peter Livesey on 1/6/17.
//  Copyright © 2017 Peter Livesey. All rights reserved.
//

import Foundation

/**
 This allows us to compare optional arrays for equality.
 */
public func ==<T>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case (nil, nil):
        return true
    case (.some(let rhs), .some(let lhs)):
        return lhs == rhs
    default:
        return false
    }
}
