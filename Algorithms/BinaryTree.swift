//
//  BinaryTree.swift
//  Algorithms
//
//  Created by Richard Ash on 5/22/17.
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

class BinaryTree {
  
  class Node {
    
    // MARK: - Properties
    
    let value: Int
    var parent: Node?
    var left: Node?
    var right: Node?
    
    // MARK: - Private Proerties
    
    private var size: Int
    
    // MARK: - Initialization
    
    init(value: Int) {
      self.value = value
      self.size = 1
    }
    
    // MARK: -  Methods
    
    func nodeSize() -> Int {
      return self.size
    }
    
    func find(_ value: Int) -> Node? {
      switch self.value.compare(to: value) {
      case .orderedAscending:
        return right?.find(value)
      case .orderedDescending:
        return left?.find(value)
      case .orderedSame:
        return self
      }
    }
    
    func insert(_ value: Int) {
      switch self.value.compare(to: value) {
      case .orderedAscending:
        if let right = right {
          right.insert(value)
        } else {
          right = Node(value: value)
          right?.parent = self
        }
      case .orderedDescending, .orderedSame:
        if let left = left {
          left.insert(value)
        } else {
          left = Node(value: value)
          left?.parent = self
        }
      }
      size += 1
    }
    
    func remove(_ value: Int) -> Node? {
      size -= 1
      switch self.value.compare(to: value) {
      case .orderedAscending:
        return right?.remove(value)
      case .orderedDescending:
        return left?.remove(value)
      case .orderedSame:
        if let nextSmallest = self.nextSmallest() {
          nextSmallest.parent = parent
          nextSmallest.left = left
          nextSmallest.right = right
          
          parent?.rewire(from: value, to: nextSmallest)
        } else if let nextLargest = self.nextLargest() {
          nextLargest.parent = parent
          nextLargest.left = left
          nextLargest.right = right
          
          parent?.rewire(from: value, to: nextLargest)
        } else {
          parent?.rewire(from: value, to: nil)
        }
        
        return self
      }
    }
    
    func rewire(from value: Int, to other: Node?) {
      if left?.value == value {
        left = other
      } else if right?.value == value {
        right = other
      }
    }
    
    func maximum(from node: Node?) -> Node? {
      var current = node
      while let right = node?.right {
        current = right
      }
      return current
    }
    
    func minimum(from node: Node?) -> Node? {
      var current = node
      while let left = node?.left {
        current = left
      }
      return current
    }
    
    func nextSmallest() -> Node? {
      return maximum(from: left)
    }
    
    func nextLargest() -> Node? {
      return minimum(from: right)
    }
  }
  
  // MARK: - Properties
  
  var root: Node?
  var size = 0
  
  // MARK: - Methods
  
  func insert(_ value: Int) {
    if let root = root {
      root.insert(value)
    } else {
      root = Node(value: value)
    }
    size += 1
  }
  
  func remove(_ value: Int) -> Node? {
    return root?.remove(value)
  }
  
  func find(_ value: Int) -> Node? {
    return root?.find(value)
  }
}
