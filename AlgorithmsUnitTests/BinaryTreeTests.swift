//
//  BinarySearchTreeTests.swift
//  Algorithms
//
//  Created by Richard Ash on 6/21/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import XCTest

class BinarySearchTreeTests: XCTestCase {
  
  var binarySearchTree: BinarySearchTree!
  
  override func setUp() {
    super.setUp()
    binarySearchTree = BinarySearchTree()
  }
  
  // MARK: - Test Methods
  
  func testRootIsInitiallyNil() {
    XCTAssertNil(binarySearchTree.root)
  }
  
  func testUnbalancedInsert() {
    binarySearchTree.insert(10)
    binarySearchTree.insert(15)
    binarySearchTree.insert(20)
    
    XCTAssertEqual(binarySearchTree.size, 3)
    XCTAssertEqual(binarySearchTree.root?.value, 10)
    XCTAssertEqual(binarySearchTree.root?.right?.value, 15)
    XCTAssertEqual(binarySearchTree.root?.right?.right?.value, 20)
  }
  
  func testBalancedInsert() {
    binarySearchTree.insert(15)
    binarySearchTree.insert(10)
    binarySearchTree.insert(20)
    
    XCTAssertEqual(binarySearchTree.size, 3)
    XCTAssertEqual(binarySearchTree.root?.value, 15)
    XCTAssertEqual(binarySearchTree.root?.right?.value, 20)
    XCTAssertEqual(binarySearchTree.root?.left?.value, 10)
  }
  
  func testFindReturnsNilWhenNodeDoesntExist() {
    binarySearchTree.insert(15)
    binarySearchTree.insert(10)
    binarySearchTree.insert(20)
    
    let found = binarySearchTree.find(1)
    XCTAssertNil(found)
  }
  
  func testFindReturnsNode() {
    binarySearchTree.insert(10)
    binarySearchTree.insert(15)
    binarySearchTree.insert(20)
    
    let found = binarySearchTree.find(20)
    XCTAssertEqual(found?.value, 20)
  }
  
  func testRemoveReturnsNilWhenNodeDoesntExist() {
    binarySearchTree.insert([10, 15, 20])
    
    let removed = binarySearchTree.remove(1)
    XCTAssertNil(removed)
  }
  
  func testRemovedRemovesNode() {
    binarySearchTree.insert(10)
    binarySearchTree.insert(15)
    binarySearchTree.insert(20)
    binarySearchTree.insert(25)
    binarySearchTree.insert(5)
    
    let removed = binarySearchTree.remove(5)
    XCTAssertEqual(removed?.value, 5)
    XCTAssertEqual(binarySearchTree.size, 4)
  }
  
  func testRemoveWithMultiplePotentialRemoves() {
    binarySearchTree.insert(10, 15, 20, 25, 20, 20, 20)
    
    let removed = binarySearchTree.remove(20)
    XCTAssertEqual(removed?.value, 20)
    XCTAssertEqual(binarySearchTree.size, 6)
  }
}
