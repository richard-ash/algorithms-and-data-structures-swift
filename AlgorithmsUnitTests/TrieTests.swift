//
//  TrieTests.swift
//  Algorithms
//
//  Created by Richard Ash on 5/19/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import XCTest

class TrieTests: XCTestCase {
  
  var trie: Trie!
  
  override func setUp() {
    super.setUp()
    trie = Trie()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testSearchTrie() {
    // given, when
    trie.insert("Hello")
    trie.insert("Hi")
    trie.insert("Worlds")
    trie.insert("help")
    
    
    // then
    XCTAssert(trie.contains("Help"))
    XCTAssert(trie.contains("world"))
  }
  
  func testSearchLong() {
    // given, when
    trie.insert("superfragaliscalifornication")
    
    // then
    XCTAssert(trie.contains("super"))
  }
  
}
