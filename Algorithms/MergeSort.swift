//
//  MergeSort.swift
//  Algorithms
//
//  Created by Richard Ash on 4/24/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

func mergeSort<T: Number>(_ array: inout [T], p: Int = 0, r: Int? = nil) {
  let r = r ?? array.count - 1
  
  if p < r {
    let q = (p+r)/2
    mergeSort(&array, p: p, r: q)
    mergeSort(&array, p: q+1, r: r)
    merge(&array, p: p, q: q, r: r)
  }
}

private func merge<T: Number>(_ array: inout [T], p: Int, q: Int, r: Int) {
  let m = q - p + 1
  let n = r - q
  
  var left  = Array(repeating: T.zero, count: m+1) // Array(array[p...q])
  var right = Array(repeating: T.zero, count: n+1) // Array(array[q+1...r])
  
  for i in 0..<m {
    left[i] = array[p + i]
  }
  
  for j in 0..<n {
    right[j] = array[q + j + 1]
  }
  
  left[m]  = T.max
  right[n] = T.max
  
  var i = 0, j = 0
  
  for k in p...r {
    if left[i] <= right[j] {
      array[k] = left[i]
      i += 1
    } else {
      array[k] = right[j]
      j += 1
    }
  }
}
