//
//  Multipliable.swift
//  Algorithms
//
//  Created by Richard Ash on 4/24/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

public protocol Multipliable {
  static func *(lhs: Self, rhs: Self) -> Self
}

extension Int: Multipliable {}

extension Double: Multipliable {}

extension Float: Multipliable {}
