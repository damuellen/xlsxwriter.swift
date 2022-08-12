//
//  Cell_Range.swift
//
//
//  Created by Daniel Müllenborn on 02.01.21.
//

import Cxlsxwriter

public struct Cell: ExpressibleByStringLiteral, ExpressibleByArrayLiteral {
  let row: UInt32, col: UInt16
  public init(stringLiteral value: String) {
    (self.row, self.col) = value.withCString { (lxw_name_to_row($0), lxw_name_to_col($0)) }
  }
  public init(arrayLiteral elements: Int...) {
    precondition(elements.count == 2, "[row, col]")
    self.row = UInt32(elements[0])
    self.col = UInt16(elements[1])
  }
  init(_ row: UInt32, _ col: UInt16) {
    self.row = row
    self.col = col
  }
}

public struct Cols: ExpressibleByStringLiteral, ExpressibleByArrayLiteral {
  let col: UInt16, col2: UInt16
  public init(stringLiteral value: String) {
    (self.col, self.col2) = value.withCString { (lxw_name_to_col($0), lxw_name_to_col_2($0)) }
  }
  public init(arrayLiteral elements: Int...) {
    precondition(elements.count == 2, "[col, col2]")
    self.col = UInt16(elements[0])
    self.col2 = UInt16(elements[1])
  }
  init(_ col: UInt16, _ col2: UInt16) {
    self.col = col
    self.col2 = col2
  }
}

public struct Range: ExpressibleByStringLiteral, ExpressibleByArrayLiteral {
  let row: UInt32, col: UInt16
  let row2: UInt32, col2: UInt16
  public init(stringLiteral value: String) {
    (self.row, self.col, self.row2, self.col2) = value.withCString {
      (lxw_name_to_row($0), lxw_name_to_col($0), lxw_name_to_row_2($0), lxw_name_to_col_2($0))
    }
  }
  public init(arrayLiteral elements: Int...) {
    precondition(elements.count == 4, "[row, col, row2, col2]")
    self.row = UInt32(elements[0])
    self.col = UInt16(elements[1])
    self.row2 = UInt32(elements[2])
    self.col2 = UInt16(elements[3])
  }
}
