//
//  BubbleSort.swift
//  Algorithms
//
//  Created by Richard Ash on 4/3/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

func bubbleSort<T: Comparable>(_ array: inout [T]) {
  for i in 0..<array.count {
    for j in 1..<array.count-i {
      if array[j-1] > array[j] {
        swap(&array[j-1], &array[j])
      }
    }
  }
}

func bubbleSortEfficient<T: Comparable>(_ array: inout [T]) {
  array.withUnsafeMutableBufferPointer { buffer in
    for n in buffer.startIndex..<buffer.endIndex {
      for i in 1..<(buffer.count - n) {
        if buffer[i - 1] > buffer[i] {
          swap(&buffer[i - 1], &buffer[i])
        }
      }
    }
  }
}
