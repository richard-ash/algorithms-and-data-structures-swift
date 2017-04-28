//
//  MaximumSubarray.swift
//  Algorithms
//
//  Created by Richard Ash on 4/27/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

func findMaximumSubarray<T: Number>(_ array: [T]) -> (low: Int, high: Int, sum: T){
  guard array.count > 1 else {
    let sum = array.isEmpty ? T.zero: array[0]
    let high = array.isEmpty ? 0: 1
    return (0, high, sum)
  }
  
  var change = Array(repeating: T.zero, count: array.count-1)
  for i in 1..<array.count {
    change[i-1] = array[i] - array[i-1]
  }
  return findMaximumSubarrayR(change, low: 0, high: change.count - 1)
}

func findMaximumSubarrayR<T: Number>(_ array: [T], low: Int, high: Int) -> (low: Int, high: Int, sum: T){
  guard high != low else { return (low, high, array[low]) }
  
  let mid = (high+low)/2
  let (leftLow, leftHigh, leftSum)     = findMaximumSubarrayR(array, low: low, high: mid)
  let (rightLow, rightHigh, rightSum)  = findMaximumSubarrayR(array, low: mid+1, high: high)
  let (crossLow, crossHigh, crossSum)  = findMaxCrossingSubarray(array, low: low, mid: mid, high: high)
  
  if leftSum >= rightSum && leftSum >= crossSum {
    return (leftLow, leftHigh, leftSum)
  } else if rightSum >= leftSum && rightSum >= crossSum {
    return (rightLow, rightHigh, rightSum)
  } else {
    return (crossLow, crossHigh, crossSum)
  }
}

func findMaxCrossingSubarray<T: Number>(_ array: [T], low: Int, mid: Int, high: Int) -> (low: Int, high: Int, sum: T) {
  var leftSum = T.min
  var sum = T.zero
  var maxLeft = 0
  
  for i in low...mid {
    let index = mid - i
    sum = sum + array[index]
    
    if sum > leftSum {
      leftSum = sum
      maxLeft = index
    }
  }
  
  var rightSum = T.min
  sum = T.zero
  var maxRight = 0
  
  for j in mid+1...high {
    sum = sum + array[j]
    if sum > rightSum {
      rightSum = sum
      maxRight = j
    }
  }
  
  return (maxLeft, maxRight, leftSum + rightSum)
}
