//
//  MergeSortTests.swift
//  Algorithms
//
//  Created by Richard Ash on 4/26/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import XCTest

class MergeSortTests: XCTestCase, SortingTestable {
  
  // MARK: - Constant Properties
  
  let size = 1_000_000
  
  // MARK: - Properties
  
  lazy var performanceArray: [Int] = {
    return self.generateRandomArray(of: self.size)
  }()

  // MARK: - Test Methods
  
  func testPerformanceSorted() {
    var array = performanceArray
    
    self.measure {
      array.sort()
    }
  }
  
  func testMergeSort1() {
    var array = [1, 3, 5, 6, 7, 8, 3, 4, 6, 2]
    let sortedArray = [1, 2, 3, 3, 4, 5, 6, 6, 7, 8]
    
    mergeSort(&array)
    
    XCTAssertEqual(sortedArray, array)
  }
  
  func testPerformanceMergeSort() {
    var array = performanceArray
    
    self.measure {
      mergeSort(&array)
    }
  }  
}
