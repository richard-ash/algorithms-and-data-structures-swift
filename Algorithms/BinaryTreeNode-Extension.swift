//
//  BinaryTreeNode-Extension.swift
//  Algorithms
//
//  Created by Richard Ash on 6/21/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

// MARK: - Remove Node Methods

extension BinaryTree.Node {
  func remove(_ value: Int) -> BinaryTree.Node? {
    size -= 1
    switch self.value.compare(to: value) {
    case .orderedAscending:
      return right?.remove(value)
    case .orderedDescending:
      return left?.remove(value)
    case .orderedSame:
      if let nextSmallest = self.nextSmallest() {
        
        rewireNode(nextSmallest, parent: parent, left: left, right: right)
        
//        nextSmallest.parent = parent
//        nextSmallest.left = left
//        nextSmallest.right = right
        
        parent?.rewireChild(with: value, to: nextSmallest)
      } else if let nextLargest = self.nextLargest() {
        
        rewireNode(nextLargest, parent: parent, left: left, right: right)
        
        nextLargest.parent = parent
        nextLargest.left = left
        nextLargest.right = right
        
        parent?.rewireChild(with: value, to: nextLargest)
      } else {
        parent?.rewireChild(with: value, to: nil)
      }
      
      return self
    }
  }
  
  func rewireChild(with value: Int?, to node: BinaryTree.Node?) {
    if left?.value == value {
      left = node
    } else if right?.value == value {
      right = node
    }
  }
  
  func rewireNode(_ node: BinaryTree.Node, parent: BinaryTree.Node?, left: BinaryTree.Node?, right: BinaryTree.Node?) {
    node.parent = parent
    node.left = left
    node.right = right
  }
  
  func maximum(from node: BinaryTree.Node?) -> BinaryTree.Node? {
    var current = node
    while let right = node?.right {
      current = right
    }
    return current
  }
  
  func minimum(from node: BinaryTree.Node?) -> BinaryTree.Node? {
    var current = node
    while let left = node?.left {
      current = left
    }
    return current
  }
  
  private func nextSmallest() -> BinaryTree.Node? {
    return maximum(from: left)
  }
  
  private func nextLargest() -> BinaryTree.Node? {
    return minimum(from: right)
  }
}
