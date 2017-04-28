//
//  Queue.swift
//  Algorithms
//
//  Created by Richard Ash on 4/25/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

struct Queue<T> {
  
  private var list = LinkedList<T>()
  
  func enqueue(_ element: T) {
    list.add(element)
  }
  
  func dequeue() -> T? {
    return list.removeNode(at: 0)?.value
  }
  
  func peek() -> T? {
    return list.node(at: 0)?.value
  }
}
