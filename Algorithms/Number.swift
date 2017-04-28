//
//  Number.swift
//  Algorithms
//
//  Created by Richard Ash on 3/28/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

public protocol Number: Multipliable, Addable, Comparable, Equatable, HasMax {
  static var zero: Self { get }
}

extension Int: Number {
  public static var zero: Int { return 0 }
}

extension Double: Number {
  public static var zero: Double { return 0.0 }
}

extension Float: Number {
  public static var zero: Float { return 0.0 }
}

extension Array where Element: Number {
  public func dot(_ b: Array) -> Element {
    let a = self
    assert(a.count == b.count, "fatal error: can only take the dot product of arrays of the same length")
    let c = a.indices.map{ a[$0] * b[$0] }
    return c.reduce(Element.zero, { $0 + $1 })
  }
  
  public static func *(lhs: Element, rhs: Array) -> Array {
    return rhs.map({ (element) -> Element in
      return lhs * element
    })
  }
}
