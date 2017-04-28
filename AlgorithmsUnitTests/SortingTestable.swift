//
//  SortingTestable.swift
//  Algorithms
//
//  Created by Richard Ash on 4/26/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

protocol SortingTestable {
  func generateRandomArray(of size: Int) -> [Int]
}

extension SortingTestable {
  func generateRandomArray(of size: Int) -> [Int] {
    return Array(repeating: 0, count: size).map{ _ in Int(arc4random_uniform(UInt32(100))) }
  }
}
