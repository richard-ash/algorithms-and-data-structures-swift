//
//  Matrix.swift
//  Algorithms
//
//  Created by Richard Ash on 3/22/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation

public struct Matrix<Element: Number> {
  
  // MARK: - Objects
  
  public enum IndexType {
    case row, column
  }
  
  public struct Size: Equatable {
    let rows, columns: Int
    
    public static func ==(lhs: Size, rhs: Size) -> Bool {
      return lhs.columns == rhs.columns && lhs.rows == rhs.rows
    }
  }
  
  public struct Index: Comparable {
    let i, j: Int
    
    public static func <(lhs: Index, rhs: Index) -> Bool {
      return lhs.i < rhs.i || lhs.j < rhs.j
    }
    
    public static func ==(lhs: Index, rhs: Index) -> Bool {
      return lhs.i == rhs.i && lhs.j == rhs.j
    }
  }
  
  // MARK: - Properties
  
  let size: Size
  var grid: [Element]
  
  var isSquare: Bool {
    return rows == columns
  }
  
  var rows: Int {
    return size.rows
  }
  
  var columns: Int {
    return size.columns
  }
  
  // MARK: - Initialization
  
  public init(rows: Int, columns: Int, initialValue: Element = Element.zero) {
    self.size = Size(rows: rows, columns: columns)
    self.grid = Array(repeating: initialValue, count: rows * columns)
  }
  
  public init(size: Int, initialValue: Element = Element.zero) {
    self.init(rows: size, columns: size, initialValue: initialValue)
  }
  
  public init(rows: Int, columns: Int, valueForIndex: (Index) -> Element) {
    self.init(rows: rows, columns: columns)
    
    self.grid = self.indices.map(valueForIndex)
  }
  
  public init(size: Int, valueForIndex: (Index) -> Element) {
    self.init(rows: size, columns: size, valueForIndex: valueForIndex)
  }
  
  // MARK: - Subscript

  public subscript(type: IndexType, value: Int) -> [Element] {
    get {
      switch type {
      case .row:    return getRow(number: value)
      case .column: return getColumn(number: value)
      }
    } set {
      switch type {
      case .row:
        precondition(newValue.count == columns, "fatal error: the length of the row is greater than the number of columns")
        for (column, element) in newValue.enumerated() {
          grid[(value * columns) + column] = element
        }
      case .column:
        precondition(newValue.count == rows, "fatal error: the length of the column is greater than the number of rows")
        for (row, element) in newValue.enumerated() {
          grid[(row * columns) + value] = element
        }
      }
    }
  }
  
  public subscript(row: Int, column: Int) -> Element {
    get {
      let index = Index(i: row, j: column)
      return self[index]
    } set {
      let index = Index(i: row, j: column)
      self[index] = newValue
    }
  }
  
  // MARK: - Public Methods
  
  public func forEach(_ index: (Index) throws -> Void) rethrows {
    for row in 0..<rows {
      for column in 0..<columns {
        try index(Index(i: row, j: column))
      }
    }
  }
  
  // MARK: - Private Methods
  
  fileprivate func indexIsValid(_ index: Index) -> Bool {
    return (0..<size.rows).contains(index.i) && (0..<size.columns).contains(index.j)
  }
  
  fileprivate func indexOutOfRange(_ index: Index) -> String {
    return "Fatal Error: Index out of Range - \(index)"
  }
  
  fileprivate func getRow(number i: Int) -> [Element] {
    let index = Index(i: i, j: 0)
    precondition(indexIsValid(index), indexOutOfRange(index))
    return Array(grid[(i * columns)..<(i * columns) + columns])
  }
  
  fileprivate func getColumn(number j: Int) -> [Element] {
    let index = Index(i: 0, j: j)
    precondition(indexIsValid(index), indexOutOfRange(index))
    
    let column = (0..<rows).map { (currentRow) -> Element in
      let currentColumnIndex = currentRow * columns + j
      return grid[currentColumnIndex]
    }
    return column
  }
}

// MARK: - Matrix Multiplication Function

extension Matrix {
  public func matrixMultiply(by B: Matrix) -> Matrix {
    let A = self
    precondition(A.columns == B.rows, "Two matricies can only be matrix mulitiplied if one has dimensions mxn & the other has dimensions nxp where m, n, p are in R")
    
    let C = Matrix(rows: A.rows, columns: B.columns) { (index) -> Element in
      A[.row, index.i].dot(B[.column, index.j])
    }
    
    return C
  }
}

// MARK: - Strassen Multiplication

extension Matrix {
  public func strassenMatrixMultiply(by B: Matrix) -> Matrix {
    let A = self
    precondition(A.columns == B.rows, "Two matricies can only be matrix mulitiplied if one has dimensions mxn & the other has dimensions nxp where m, n, p are in R")
    
    let n = Swift.max(A.rows, A.columns, B.rows, B.columns)
    let m = nextPowerOfTwo(after: n)
    
    var APrep = Matrix(size: m)
    var BPrep = Matrix(size: m)
    
    A.forEach { (index) in
      APrep[index] = A[index]
    }
    
    B.forEach { (index) in
      BPrep[index] = B[index]
    }
    
    let CPrep = APrep.strassenR(by: BPrep)
    let C = Matrix(rows: A.rows, columns: B.columns) { (index) -> Element in
      return CPrep[index]
    }
    
    return C
  }
  
  private func strassenR(by B: Matrix) -> Matrix {
    let A = self
    precondition(A.isSquare && B.isSquare, "This function requires square matricies!")
    guard A.rows > 1 && B.rows > 1 else { return A * B }
    
    let n    = A.rows
    let nBy2 = n / 2
    
    /*
     Assume submatricies are allocated as follows
     
     matrix A = |a b|,    matrix B = |e f|
                |c d|		             |g h|
     */
    
    var a = Matrix(size: nBy2)
    var b = Matrix(size: nBy2)
    var c = Matrix(size: nBy2)
    var d = Matrix(size: nBy2)
    var e = Matrix(size: nBy2)
    var f = Matrix(size: nBy2)
    var g = Matrix(size: nBy2)
    var h = Matrix(size: nBy2)
    
    for i in 0..<nBy2 {
      for j in 0..<nBy2 {
        a[i,j] = A[i,j]
        b[i,j] = A[i, j+nBy2]
        c[i,j] = A[i+nBy2, j]
        d[i,j] = A[i+nBy2, j+nBy2]
        e[i,j] = B[i,j]
        f[i,j] = B[i, j+nBy2]
        g[i,j] = B[i+nBy2, j]
        h[i,j] = B[i+nBy2, j+nBy2]
      }
    }
    
    let p1 = a.strassenR(by: f-h)       // a * (f - h)
    let p2 = (a+b).strassenR(by: h)     // (a + b) * h
    let p3 = (c+d).strassenR(by: e)     // (c + d) * e
    let p4 = d.strassenR(by: g-e)       // d * (g - e)
    let p5 = (a+d).strassenR(by: e+h)   // (a + d) * (e + h)
    let p6 = (b-d).strassenR(by: g+h)   // (b - d) * (g + h)
    let p7 = (a-c).strassenR(by: e+f)   // (a - c) * (e + f)
    
    let c11 = p5 + p4 - p2 + p6         // p5 + p4 - p2 + p6
    let c12 = p1 + p2                   // p1 + p2
    let c21 = p3 + p4                   // p3 + p4
    let c22 = p1 + p5 - p3 - p7         // p1 + p5 - p3 - p7
    
    var C = Matrix(size: n)
    for i in 0..<nBy2 {
      for j in 0..<nBy2 {
        C[i, j]           = c11[i,j]
        C[i, j+nBy2]      = c12[i,j]
        C[i+nBy2, j]      = c21[i,j]
        C[i+nBy2, j+nBy2] = c22[i,j]
      }
    }
    
    return C
  }
  
  private func nextPowerOfTwo(after n: Int) -> Int {
    return Int(pow(2, ceil(log2(Double(n)))))
  }
}

// Term-by-term Matrix Math

extension Matrix: Addable {
  public static func +(lhs: Matrix, rhs: Matrix) -> Matrix {
    precondition(lhs.size == rhs.size, "To term-by-term add matricies they need to be the same size!")
    let rows = lhs.rows
    let columns = lhs.columns
    
    return Matrix(rows: rows, columns: columns, valueForIndex: { (index) -> Element in
      return lhs[index] + rhs[index]
    })
  }
  
  public static func -(lhs: Matrix, rhs: Matrix) -> Matrix {
    precondition(lhs.size == rhs.size, "To term-by-term subtract matricies they need to be the same size!")
    let rows = lhs.rows
    let columns = lhs.columns
    
    return Matrix(rows: rows, columns: columns, valueForIndex: { (index) -> Element in
      return lhs[index] - rhs[index]
    })
  }
}

extension Matrix: Multipliable {
  public static func *(lhs: Matrix, rhs: Matrix) -> Matrix {
    precondition(lhs.size == rhs.size, "To term-by-term multiply matricies they need to be the same size!")
    let rows = lhs.rows
    let columns = lhs.columns
    
    return Matrix(rows: rows, columns: columns, valueForIndex: { (index) -> Element in
      return lhs[index] * rhs[index]
    })
  }
}

// MARK: - Collection Conformance

extension Matrix: RandomAccessCollection, MutableCollection {
  
  public var startIndex: Index {
    return Index(i: 0, j: 0)
  }
  
  public var endIndex: Index {
    return Index(i: rows, j: 0)
  }
  
  public func index(after i: Index) -> Index {
    if i.j + 1 < size.columns {
      return Index(i: i.i, j: i.j + 1)
    } else {
      return Index(i: i.i + 1, j: 0)
    }
  }
  
  public func index(before i: Index) -> Index {
    if i.j > 0 {
      return Index(i: i.i, j: i.j - 1)
    } else {
      return Index(i: i.i - 1, j: size.columns - 1)
    }
  }
  
  public subscript(index: Index) -> Element {
    get {
      precondition(indexIsValid(index), indexOutOfRange(index))
      return grid[(index.i * columns) + index.j]
    } set {
      precondition(indexIsValid(index), indexOutOfRange(index))
      grid[(index.i * columns) + index.j] = newValue
    }
  }
}

// MARK: - Custom String Convertible

extension Matrix: CustomStringConvertible {
  public var description: String {
    var returnString = ""
    
    for i in 0..<rows {
      let row = self.getRow(number: i).map{ String(describing: $0) }.joined(separator: ", ")
      returnString += "| "
      returnString.append(row)
      returnString += " |\n"
    }
    
    return returnString
  }
}
