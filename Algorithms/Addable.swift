//
//  Addable.swift
//  Algorithms
//
//  Created by Richard Ash on 4/24/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

public protocol Addable {
  static func +(lhs: Self, rhs: Self) -> Self
  static func -(lhs: Self, rhs: Self) -> Self
}

extension Int: Addable {}

extension Double: Addable {}

extension Float: Addable {}
