//
//  BinarySearchTree.swift
//  Algorithms
//
//  Created by Richard Ash on 5/22/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

class BinarySearchTree {
  
  class Node {
    
    // MARK: - Properties
    
    let value: Int
    
    weak var parent: Node?
    var left: Node?
    var right: Node?
    var size = 1
    
    // MARK: - Initialization
    
    init(value: Int) {
      self.value = value
    }
    
    // MARK: -  Methods
    
    func nodeSize() -> Int {
      return self.size
    }
  }
  
  // MARK: - Properties
  
  var root: Node?
  
  var size: Int {
    return root?.nodeSize() ?? 0
  }
  
  // MARK: - Methods
  
  func insert(_ values: Int...) {
    insert(values)
  }
  
  func insert(_ array: [Int]) {
    for element in array {
      insert(element)
    }
  }
  
  func insert(_ value: Int) {
    root = BinarySearchTree.insertValue(value, at: root)
  }
  
  func remove(_ value: Int) -> Node? {
    return root?.remove(value)
  }
  
  func find(_ value: Int) -> Node? {
    return root?.find(value)
  }
  
  // MARK: - Static Methods
  
  static func insertValue(_ value: Int, at node: BinarySearchTree.Node?) -> BinarySearchTree.Node {
    if let node = node {
      node.insert(value)
      return node
    } else {
      let newNode = BinarySearchTree.Node(value: value)
      node?.parent = newNode
      return newNode
    }
  }
}

// Mark: - Traversal Methods

extension BinarySearchTree {
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
