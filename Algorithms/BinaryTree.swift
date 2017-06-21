//
//  BinaryTree.swift
//  Algorithms
//
//  Created by Richard Ash on 5/22/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

class BinaryTree {
  
  class Node {
    
    // MARK: - Properties
    
    let value: Int
    weak var parent: Node?
    var left: Node?
    var right: Node?
    
    // MARK: - Private Proerties
    
    var size: Int
    
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
  }
  
  // MARK: - Properties
  
  var root: Node?
  var size = 0
  
  // MARK: - Methods
  
  func insert(_ value: Int) {
    size += 1
    
    if let root = root {
      root.insert(value)
    } else {
      root = Node(value: value)
    }
  }
  
  func remove(_ value: Int) -> Node? {
    return root?.remove(value)
  }
  
  func find(_ value: Int) -> Node? {
    return root?.find(value)
  }
}

// Mark: - Traversal Methods

extension BinaryTree {
  func inOrderTraversalFromRoot(visit: (Node) -> Void) {
    inOrderTraversal(from: root, visit: visit)
  }
  
  func inOrderTraversal(from node: Node?, visit: (Node) -> Void) {
    guard let node = node else { return }
    inOrderTraversal(from: node.left, visit: visit)
    visit(node)
    inOrderTraversal(from: node.right, visit: visit)
  }
  
  func preOrderTraversalFromRoot(visit: (Node) -> Void) {
    preOrderTraversal(from: root, visit: visit)
  }
  
  func preOrderTraversal(from node: Node?, visit: (Node) -> Void) {
    guard let node = node else { return }
    visit(node)
    preOrderTraversal(from: node.left, visit: visit)
    preOrderTraversal(from: node.right, visit: visit)
  }
  
  func postOtderTraversalFromRoot(visit: (Node) -> Void) {
    postOrderTraversal(from: root, visit: visit)
  }
  
  func postOrderTraversal(from node: Node? , visit: (Node) -> Void) {
    guard let node = node else { return }
    postOrderTraversal(from: node.left, visit: visit)
    postOrderTraversal(from: node.right, visit: visit)
    visit(node)
  }
}
