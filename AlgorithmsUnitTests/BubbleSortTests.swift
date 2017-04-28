//
//  BubbleSortTests.swift
//  Algorithms
//
//  Created by Richard Ash on 4/26/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import XCTest

class BubbleSortTests: XCTestCase, SortingTestable {
  
  // MARK: - Constant Properties
  
  let size = 100_000
  
  // MARK: - Properties
  
  lazy var performanceArray: [Int] = {
    return self.generateRandomArray(of: self.size)
  }()
  
  // MARK: - Test Methods
  
  func testBubbleSort1() {
    var array = [1, 3, 5, 6, 7, 8, 3, 4, 6, 2]
    var arrayForEfficient = array
    let sortedArray = [1, 2, 3, 3, 4, 5, 6, 6, 7, 8]
    
    bubbleSort(&array)
    bubbleSortEfficient(&arrayForEfficient)
    
    XCTAssertEqual(sortedArray, arrayForEfficient)
    XCTAssertEqual(sortedArray, array)
  }
  
  func testPerformanceBubbleSort() {
    var array = performanceArray
    
    self.measure {
      bubbleSort(&array)
    }
  }
  
  func testPerformanceBubbleSortEfficient() {
    var array = performanceArray
    
    self.measure {
      bubbleSortEfficient(&array)
    }
  }
}
