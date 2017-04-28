//
//  HasMax.swift
//  Algorithms
//
//  Created by Richard Ash on 4/24/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

public protocol HasMax {
  static var max: Self { get }
  static var min: Self { get }
}

extension Int: HasMax {}

extension Double: HasMax {
  public static var min: Double { return -Double.infinity }
  public static var max: Double { return Double.infinity }
}

extension Float: HasMax {
  public static var max: Float { return Float.infinity }
  public static var min: Float { return -Float.infinity }
}
