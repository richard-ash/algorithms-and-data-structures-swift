//
//  LinkedList.swift
//  Algorithms
//
//  Created by Richard Ash on 3/22/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

class LinkedList<T> {
  
  // MARK: - Objects
  
  class Node {
    var next: Node?
    var value: T
    
    init(_ value: T) {
      self.value = value
    }
  }
  
  // MARK: - Properties
  
  var head: Node?
  var tail: Node?
  var count = 0
  
  // MARK: - Methods
  
  func add(_ value: T) {
    let node = Node(value)
    if var head = head {
      while let next = head.next {
        head = next
      }
      head.next = node
      tail = node
      count += 1
    } else {
      head = node
      tail = node
      count = 1
    }
  }
  
  func removeAll() {
    head = nil
  }
  
  func node(at index: Int) -> Node? {
    guard indexIsValid(index) else { return nil }
    
    var currentNode = head!
    
    for _ in 0..<index {
      currentNode = currentNode.next!
    }
    
    return currentNode
  }
  
  @discardableResult func removeNode(at index: Int) -> Node? {
    guard let node = self.node(at: index) else { return nil }
    let previous   = self.node(at: index-1)
    let next       = self.node(at: index+1)
    
    if let previous = previous, let next = next {
      previous.next = next
    } else if let previous = previous {
      previous.next = nil
      tail = previous
    } else if let next = next {
      head = next
    } else {
      head = nil
    }
    
    count -= 1
    return node
  }
  
  // MARK: - Private Methods
  
  private func indexIsValid(_ index: Int) -> Bool {
    return index >= 0 && index < count
  }
}


extension LinkedList: CustomStringConvertible {
  var description: String {
    var descriptions: [String] = []
    
    if var head = head {
      descriptions.append("\(head.value)")
      while let next = head.next {
        descriptions.append("\(next.value)")
        head = next
      }
      return descriptions.joined(separator: " ~> ")
    } else {
      return "[~>]"
    }    
  }
}


//indirect enum LinkedListNode<T> {
//  case value(element: T, next: LinkedListNode<T>)
//  case end
//}
//
//extension LinkedListNode: Sequence {
//  func makeIterator() -> LinkedListIterator<T> {
//    return LinkedListIterator<T>(current: self)
//  }
//}
//
//struct LinkedListIterator<T>: IteratorProtocol {
//  var current: LinkedListNode<T>
//  
//  mutating func next() -> T? {
//    switch current {
//    case let .value(element, next):
//      current = next
//      return element
//    case .end:
//      return nil
//    }
//  }
//}
