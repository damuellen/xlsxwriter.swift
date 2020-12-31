//
//  Format.swift
//  Created by Daniel Müllenborn on 31.12.20.
//

import Cxlsxwriter

/// Struct to represent the formatting properties of an Excel format.
public struct Format {
  
  let lxw_format: UnsafeMutablePointer<lxw_format>
  
  init(_ lxw_format: UnsafeMutablePointer<lxw_format>) {
    self.lxw_format = lxw_format
  }
  /// Turn on bold for the format font.
  public func set_bold() {
    format_set_bold(lxw_format)
  }
  /// Set the cell border style.
  public func set_border(style: Border) {
    format_set_border(lxw_format, style.rawValue)
  }
  /// Set the cell top border style.
  public func set_top(style: Border) {
    format_set_top(lxw_format, style.rawValue)
  }
  /// Set the cell bottom border style.
  public func set_bottom(style: Border) {
    format_set_bottom(lxw_format, style.rawValue)
  }
  /// Set the cell left border style.
  public func set_left(style: Border) {
    format_set_left(lxw_format, style.rawValue)
  }
  /// Set the cell right border style.
  public func set_right(style: Border) {
    format_set_right(lxw_format, style.rawValue)
  }
  /// Set the alignment for data in the cell.
  public func set(alignment: Alignment) {
    format_set_align(lxw_format, alignment.rawValue)
  }
  /// Set the number format for a cell.
  public func set(num_format: String) {
    num_format.withCString { format_set_num_format(lxw_format, $0) }
  }
  /// Set the Excel built-in number format for a cell.
  public func set(num_format index: Int) {
    format_set_num_format_index(lxw_format, UInt8(index))
  }
}
