//
//  ManachersAlgorithm.swift
//  Algorithms
//
//  Created by Richard Ash on 4/18/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

func longestPalindrome(_ s: String) -> String {
  
  var T: [Character] = [Character("$"), Character("#")]
  var count = 0
  for character in s.characters {
    count += 1
    T.append(contentsOf: [character, Character("#")])
  }
  
  guard count > 1 else { return s }
  if count == 2 {
    if s[s.startIndex] == s[s.index(before: s.endIndex)] {
      return s
    } else {
      return String(s[s.startIndex])
    }
  }
  
  let n = 2*count + 2
  
  
  var P = Array(repeating: 0, count: n)
  var maxP = 0
  var maxPIndex = 0
  
  var C = 0, R = 0
  
  for i in 1..<n-1 {
    let mirror = 2 * C - i
    
    if i < R {
      P[i] = min(R-i, P[mirror])
      
      if maxP < P[i] {
        maxP = P[i]
        maxPIndex = i
      }
    }
    
    while T[T.index(T.startIndex, offsetBy: i + (1 + P[i]))] == T[T.index(T.startIndex, offsetBy: i - (1 + P[i]))] {
      P[i] += 1
      
      if maxP < P[i] {
        maxP = P[i]
        maxPIndex = i
      }
      
      if i + P[i] > R {
        C = i
        R = i + P[i]
      }
    }
  }
  
//  print(P)
//  print(maxP)
//  print(maxPIndex)
//  print(T)
  
  let length = maxP
  let start = maxPIndex - length
  let end = maxPIndex + length
  
  return Array(T[start..<end]).reduce("", { $0 + String($1) }).replacingOccurrences(of: "#", with: "")
}
