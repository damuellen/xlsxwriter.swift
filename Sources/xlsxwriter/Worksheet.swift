//
//  Worksheet.swift
//  Created by Daniel Müllenborn on 31.12.20.
//

import Cxlsxwriter

/// Struct to represent an Excel worksheet.
public struct Worksheet {
  
  let lxw_worksheet: UnsafeMutablePointer<lxw_worksheet>
  
  init(_ lxw_worksheet: UnsafeMutablePointer<lxw_worksheet>) {
    self.lxw_worksheet = lxw_worksheet
  }
  /// Insert a chart object into a worksheet.
  public func insert(chart: Chart, _ pos: (row: Int, col: Int)) {
    let r = UInt32(pos.row), c = UInt16(pos.col)
    worksheet_insert_chart(lxw_worksheet, r, c, chart.lxw_chart)
  }
  
  /// Write a column of data starting from (row, col).
  public func write(column values: [Value], _ pos: (row: Int, col: Int), format: Format? = nil) {
    var r = pos.row
    let c = pos.col
    for value in values {
      write(value, (r, c), format: format)
      r += 1
    }
  }
  
  /// Write a row of data starting from (row, col).
  public func write(row values: [Value], _ pos: (row: Int, col: Int), format: Format? = nil) {
    let r = pos.row
    var c = pos.col
    for value in values {
      write(value, (r, c), format: format)
      c += 1
    }
  }
  
  /// Write a row of data starting from (row, col).
  public func write(_ numbers: [Double], row: Int, format: Format? = nil) {
    let f = format?.lxw_format
    let r = UInt32(row)
    var c = UInt16(0)
    for number in numbers {
      worksheet_write_number(lxw_worksheet, r, c, number, f)
      c += 1
    }
  }
  
  /// Write data to a worksheet cell by calling the appropriate
  /// worksheet_write_*() method based on the type of data being passed.
  public func write(_ value: Value, _ pos: (row: Int, col: Int), format: Format? = nil) {
    let r = UInt32(pos.row), c = UInt16(pos.col), f = format?.lxw_format
    let error: lxw_error
    switch value {
    case .number(let number):
      error = worksheet_write_number(lxw_worksheet, r, c, number, f)
    case .string(let string):
      error = string.withCString { worksheet_write_string(lxw_worksheet, r, c, $0, f) }
    case .url(let url):
      error = url.path.withCString { worksheet_write_url(lxw_worksheet, r, c, $0, f) }
    case .blank:
      error = worksheet_write_blank(lxw_worksheet, r, c, f)
    case .comment(let comment):
      error = comment.withCString { worksheet_write_comment(lxw_worksheet, r, c, $0) }
    case .boolean(let boolean):
      error = worksheet_write_boolean(lxw_worksheet, r, c, Int32(boolean ? 1 : 0), f)
    case .formula(let formula):
      error = formula.withCString { worksheet_write_formula(lxw_worksheet, r, c, $0, f) }
    case .datetime(let datetime):
      error = lxw_error(rawValue: 0)
      print(datetime)
      break// worksheet_write_datetime(pointer, r, c, datetime, format)
    }
    print(String(cString: lxw_strerror(error)))
  }
  /// Set a worksheet tab as selected.
  public func select() {
    worksheet_select(lxw_worksheet)
  }
  /// Hide the current worksheet.
  public func hide() {
    worksheet_hide(lxw_worksheet)
  }
  /// Make a worksheet the active, i.e., visible worksheet.
  public func activate() {
    worksheet_activate(lxw_worksheet)
  }
  /// Hide zero values in worksheet cells.
  public func hide_zero() {
    worksheet_hide_zero(lxw_worksheet)
  }
  /// Set the paper type for printing.
  public func set_paper(type: PaperType) {
    worksheet_set_paper(lxw_worksheet, type.rawValue)
  }
  /// Set the properties for one or more columns of cells.
  public func set_column(first: Int, last: Int, width: Double, format: Format? = nil) {
    let first = UInt16(first), last = UInt16(last), f = format?.lxw_format
    worksheet_set_column(lxw_worksheet, first, last, width, f)
  }
  /// Set the color of the worksheet tab.
  public func set_tab_color(color: Color) {
    worksheet_set_tab_color(lxw_worksheet, color.rawValue)
  }
  /// Set the default row properties.
  public func set_default(row_height: Double, hide_unused_rows: Bool = true) {
    let hide: UInt8 = hide_unused_rows ? 1 : 0
    worksheet_set_default_row(lxw_worksheet, row_height, hide)
  }
  /// Set the print area for a worksheet.
  public func print_area(range: String) {
    range.withCString {
      let _ = worksheet_print_area(lxw_worksheet,
        lxw_name_to_row($0), lxw_name_to_col($0),
        lxw_name_to_row_2($0), lxw_name_to_col_2($0)
      )
    }
  }
}

public extension StringLiteralType {
  var cell: (row: Int, col: Int) {
    withCString { (Int(lxw_name_to_row($0)), Int(lxw_name_to_col($0))) }
  }
}
