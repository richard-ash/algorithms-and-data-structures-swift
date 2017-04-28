//
//  MaximumSubarrayTests.swift
//  Algorithms
//
//  Created by Richard Ash on 4/27/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import XCTest

class MaximumSubarrayTests: XCTestCase {

  func testMaxSubarray() {
    let array = [100, 113, 110, 85, 105, 102, 86, 63, 81, 101, 94, 106, 101, 79, 94, 90, 97]
    
    let maxSubarray = findMaximumSubarray(array)
    
    XCTAssertEqual(maxSubarray.low, 7)
    XCTAssertEqual(maxSubarray.high, 10)
    XCTAssertEqual(maxSubarray.sum, 43)
  }
  
  func testFindMaxSubarrayCrossing() {
    let array = [-23, 18, 20, -7, 12, -5]
    let maxSubarrayCrossing = findMaxCrossingSubarray(array, low: 0, mid: 2, high: 5)
    
    XCTAssertEqual(maxSubarrayCrossing.low, 1)
    XCTAssertEqual(maxSubarrayCrossing.high, 4)
    XCTAssertEqual(maxSubarrayCrossing.sum, 43)
  }
  
}
