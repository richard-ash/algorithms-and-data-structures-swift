//
//  Trie.swift
//  Algorithms
//
//  Created by Richard Ash on 5/19/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

class Trie {
  
  // MARK: - Objects
  
  class Node {
    var value: Character
    var children: [Node] = []
    
    init(value: Character) {
      self.value = value
    }
  }
  
  // MARK: - Properties
  
  var root: Node?
  
  // MARK: - Initialization
  
  init() {
    self.root = Node(value: Character("!"))
  }
  
  // MARK: - Methods
  
  func contains(_ word: String) -> Bool {
    var currentNode = root
    
    for character in word.lowercased().characters {
      if let index = currentNode?.children.index(where: { $0.value == character }) {
        currentNode = currentNode?.children[index]
      } else {
        return false
      }
    }
    
    return true
  }
  
  func insert(_ word: String) {
    var currentNode = root
    
    for character in word.lowercased().characters {
      if let index = currentNode?.children.index(where: { $0.value == character }) {
        currentNode = currentNode?.children[index]
      } else {
        let newNode = Node(value: character)
        currentNode?.children.append(newNode)
        currentNode = newNode
      }
    }
  }
}
