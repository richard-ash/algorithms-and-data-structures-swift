//
//  InsertionSort.swift
//  Algorithms
//
//  Created by Richard Ash on 3/28/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

func insertionSort<T: Comparable>(_ array: inout [T]) {
  for (i, element) in array.enumerated() {
    var j = i - 1
    while j >= 0 && array[j] > element {
      array[j+1] = array[j]
      j -= 1
    }
    array[j + 1] = element
  }
}

func insertionSortEfficient<T: Comparable>(_ array: inout [T]) {
  array.withUnsafeMutableBufferPointer { buffer in
    for i in buffer.startIndex..<buffer.endIndex {
      let element = buffer[i]
      var j = i - 1
      while j > 0 && buffer[j] > element {
        buffer[j+1] = buffer[j]
        j -= 1
      }
      buffer[j+1] = element
    }
  }  
}
