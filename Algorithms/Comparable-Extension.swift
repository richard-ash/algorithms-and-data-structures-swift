//
//  Comparable-Extension.swift
//  Algorithms
//
//  Created by Richard Ash on 6/21/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

extension Comparable where Self: Equatable {
  func compare(to other: Self) -> ComparisonResult {
    if self < other {
      return .orderedAscending
    } else if self > other {
      return .orderedDescending
    } else {
      return .orderedSame
    }
  }
}
