//
//  BinarySearchTreeNode-Extension.swift
//  Algorithms
//
//  Created by Richard Ash on 6/21/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

// MARK: - Remove Node Methods

extension BinarySearchTree.Node {
  func remove(_ value: Int) -> BinarySearchTree.Node? {
    size -= 1
    switch self.value.compare(to: value) {
    case .orderedAscending:
      return right?.remove(value)
    case .orderedDescending:
      return left?.remove(value)
    case .orderedSame:
      rewireSelfForRemoval()
      return self
    }
  }
  
  func rewireChild(with value: Int?, to node: BinarySearchTree.Node?) {
    if left?.value == value {
      rewireNode(self, parent: parent, left: node, right: right)
    } else if right?.value == value {
      rewireNode(self, parent: parent, left: left, right: node)
    }
  }
  
  func rewireNode(_ node: BinarySearchTree.Node, parent: BinarySearchTree.Node?, left: BinarySearchTree.Node?, right: BinarySearchTree.Node?) {
    node.parent = parent
    node.left = left
    node.right = right
  }
  
  func maximum(from node: BinarySearchTree.Node?) -> BinarySearchTree.Node? {
    guard let right = node?.right else { return node }
    return maximum(from: right)
  }
  
  func minimum(from node: BinarySearchTree.Node?) -> BinarySearchTree.Node? {
    guard let left = node?.left else { return node }
    return minimum(from: left)
  }
  
  private func nextSmallest() -> BinarySearchTree.Node? {
    return maximum(from: left)
  }
  
  private func nextLargest() -> BinarySearchTree.Node? {
    return minimum(from: right)
  }
  
  private func rewireSelfForRemoval() {
    if let nextSmallest = self.nextSmallest() {
      rewireNode(nextSmallest, parent: parent, left: left, right: right)
      parent?.rewireChild(with: value, to: nextSmallest)
    } else if let nextLargest = self.nextLargest() {
      rewireNode(nextLargest, parent: parent, left: left, right: right)
      parent?.rewireChild(with: value, to: nextLargest)
    } else {
      parent?.rewireChild(with: value, to: nil)
    }
  }
}

// MARK: - Find Methods

extension BinarySearchTree.Node {
  func find(_ value: Int) -> BinarySearchTree.Node? {
    switch self.value.compare(to: value) {
    case .orderedAscending:  return right?.find(value)
    case .orderedDescending: return left?.find(value)
    case .orderedSame:       return self
    }
  }
}

// MARK: - Insert Methods

extension BinarySearchTree.Node {
  func insert(_ value: Int) {
    switch self.value.compare(to: value) {
    case .orderedAscending:
      right = BinarySearchTree.insertValue(value, at: right)
    case .orderedDescending, .orderedSame:
      left = BinarySearchTree.insertValue(value, at: left)
    }
    size += 1
  }
}
