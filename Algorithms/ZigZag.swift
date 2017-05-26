//
//  ZigZag.swift
//  Algorithms
//
//  Created by Richard Ash on 5/26/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

class ZigZag: Collection, MutableCollection {
  
  struct Index: Comparable {
    let i, j: Int
    
    static func ==(lhs: Index, rhs: Index) -> Bool {
      return lhs.i == rhs.i && lhs.j == rhs.j
    }
    
    static func <(lhs: Index, rhs: Index) -> Bool {
      return lhs.i < rhs.i || lhs.j < rhs.j
    }
  }
  
  private enum ZigZagState {
    case zig, zag
  }
  
  var array: [String]
  let rows: Int
  let columns: Int
  
  init?(rows: Int, string: String) {
    self.rows = rows
    
    let characters = string.characters.map{ String($0) }
    let charactersPerCycle = self.rows * 2 - 2
    guard characters.count > 1, charactersPerCycle > 0 else { return nil }
    
    let cycles = characters.count / charactersPerCycle
    let remainder = characters.count % charactersPerCycle != 0
    
    self.columns = cycles * (self.rows - 1) + (remainder ? 1 : 0)
    self.array = Array(repeating: " ", count: self.columns * self.rows)
    
    var index = startIndex
    for character in characters {
      self[index] = character
      index = self.index(after: index)
    }
  }
  
  private var state = ZigZagState.zig
  
  func index(after i: Index) -> Index {
    let index = i
    switch state {
    case .zig:
      
      if (index.i + 1) % rows == 0 {
        state = .zag
        return Index(i: index.i - 1, j: index.j + 1)
        
      } else {
        return Index(i: index.i + 1, j: index.j)
      }
    case .zag:
      if (index.i % rows == 0) {
        state = .zig
        return Index(i: index.i + 1, j: index.j)
      } else {
        return Index(i: index.i - 1, j: index.j + 1)
      }
    }
  }
  
  var startIndex: Index {
    return Index(i: 0, j: 0)
  }
  
  var endIndex: Index {
    return Index(i: rows, j: 0)
  }
  
  subscript(index: Index) -> String {
    get {
      return array[(index.i * columns) + index.j]
    } set {
      array[(index.i * columns) + index.j] = newValue
    }
  }
}

extension ZigZag: CustomStringConvertible {
  var description: String {
    var returnString = ""
    
    for i in 0..<rows {
      let row = self.getRow(number: i).map{ String(describing: $0) }.joined(separator: " ")
      returnString += "| "
      returnString.append(row)
      returnString += " |\n"
    }
    
    return returnString
  }
  
  private func getRow(number i: Int) -> [String] {
    return Array(array[(i * columns)..<(i * columns) + columns])
  }
  
  func convertedString() -> String {
    return (0..<rows).map(getRow).reduce("", { $0 + $1.joined() }).replacingOccurrences(of: " ", with: "")
  }
}
