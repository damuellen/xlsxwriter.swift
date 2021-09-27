//
//  Worksheet.swift
//  Created by Daniel Müllenborn on 31.12.20.
//

import Cxlsxwriter
import Foundation

/// Struct to represent an Excel worksheet.
public struct Worksheet {

  let lxw_worksheet: UnsafeMutablePointer<lxw_worksheet>

  var name: String {
    String(cString: lxw_worksheet.pointee.name)
  }

  init(_ lxw_worksheet: UnsafeMutablePointer<lxw_worksheet>) {
    self.lxw_worksheet = lxw_worksheet
  }
  /// Insert a chart object into a worksheet.
  public func insert(chart: Chart, _ pos: (row: Int, col: Int)) -> Worksheet {
    let r = UInt32(pos.row), c = UInt16(pos.col)
    worksheet_insert_chart(lxw_worksheet, r, c, chart.lxw_chart)
    return self
  }

  /// Insert a chart object into a worksheet, with options.
  public func insert(chart: Chart, _ pos: (row: Int, col: Int), scale: (x: Double, y: Double)) -> Worksheet {
    let r = UInt32(pos.row), c = UInt16(pos.col)
    var o = lxw_chart_options(
      x_offset: 0, y_offset: 0, x_scale: scale.x, y_scale: scale.y, object_position: 2, description: nil, decorative: 0
    )
    worksheet_insert_chart_opt(lxw_worksheet, r, c, chart.lxw_chart, &o)
    return self
  }

  /// Write a column of data starting from (row, col).
  @discardableResult
  public func write(column values: [Value], _ cell: Cell, format: Format? = nil) -> Worksheet {
    var r = cell.row
    let c = cell.col
    for value in values {
      write(value, .init(r, c), format: format)
      r += 1
    }
    return self
  }

  /// Write a row of data starting from (row, col).
  @discardableResult
  public func write(row values: [Value], _ cell: Cell, format: Format? = nil) -> Worksheet {
    let r = cell.row
    var c = cell.col
    for value in values {
      write(value, .init(r, c), format: format)
      c += 1
    }
    return self
  }

  /// Write a row of Double values starting from (row, col).
  @discardableResult
  public func write(_ numbers: [Double], row: Int, col: Int = 0, format: Format? = nil) -> Worksheet {
    let f = format?.lxw_format
    let r = UInt32(row)
    var c = UInt16(col)
    for number in numbers {
      worksheet_write_number(lxw_worksheet, r, c, number, f)
      c += 1
    }
    return self
  }

  /// Write a row of String values starting from (row, col).
  @discardableResult
  public func write(_ strings: [String], row: Int, col: Int = 0, format: Format? = nil) -> Worksheet {
    let f = format?.lxw_format
    let r = UInt32(row)
    var c = UInt16(col)
    for string in strings {
      let _ = string.withCString { worksheet_write_string(lxw_worksheet, r, c, $0, f) }
      c += 1
    }
    return self
  }

  /// Write data to a worksheet cell by calling the appropriate
  /// worksheet_write_*() method based on the type of data being passed.
  @discardableResult
  public func write(_ value: Value, _ cell: Cell, format: Format? = nil) -> Worksheet {
    let r = cell.row, c = cell.col, f = format?.lxw_format
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
      let num = (datetime.timeIntervalSince1970 / 86400) + 25569
      worksheet_write_number(lxw_worksheet, r, c, num, f)
    }
    if error.rawValue != 0 {
      fatalError(String(cString: lxw_strerror(error)))
    }
    return self
  }
  /// Set a worksheet tab as selected.
  @discardableResult
  public func select() -> Worksheet {
    worksheet_select(lxw_worksheet)
    return self
  }
  /// Hide the current worksheet.
  @discardableResult
  public func hide() -> Worksheet {
    worksheet_hide(lxw_worksheet)
    return self
  }
  /// Make a worksheet the active, i.e., visible worksheet.
  @discardableResult
  public func activate() -> Worksheet {
    worksheet_activate(lxw_worksheet)
    return self
  }
  /// Hide zero values in worksheet cells.
  @discardableResult
  public func hide_zero() -> Worksheet {
    worksheet_hide_zero(lxw_worksheet)
    return self
  }
  /// Set the paper type for printing.
  @discardableResult
  public func paper(type: PaperType) -> Worksheet {
    worksheet_set_paper(lxw_worksheet, type.rawValue)
    return self
  }
  /// Set the properties for one or more columns of cells.
  @discardableResult
  public func column(_ cols: Cols, width: Double, format: Format? = nil) -> Worksheet {
    let first = cols.col, last = cols.col2, f = format?.lxw_format
    worksheet_set_column(lxw_worksheet, first, last, width, f)
    return self
  }
    /// Set the properties for one or more columns of cells.
  @discardableResult
  public func hide_columns(_ col: Int, width: Double = 8.43) -> Worksheet {
    let first = UInt16(col)
    let cols: Cols = "A:XFD"
    let last = cols.col2
    var o = lxw_row_col_options(hidden: 1, level: 0, collapsed: 0)
    worksheet_set_column_opt(lxw_worksheet, first, last, width, nil, &o)
    return self
  }
  /// Set the color of the worksheet tab.
  @discardableResult
  public func tab(color: Color) -> Worksheet {
    worksheet_set_tab_color(lxw_worksheet, color.rawValue)
    return self
  }
  /// Set the default row properties.
  @discardableResult
  public func set_default(row_height: Double, hide_unused_rows: Bool = true) -> Worksheet {
    let hide: UInt8 = hide_unused_rows ? 1 : 0
    worksheet_set_default_row(lxw_worksheet, row_height, hide)
    return self
  }
  /// Set the print area for a worksheet.
  @discardableResult
  public func print_area(range: Range) -> Worksheet {
    let _ = worksheet_print_area(lxw_worksheet,
      range.row, range.col, range.row2, range.col2
    )
    return self
  }
  /// Set the autofilter area in the worksheet.
  @discardableResult
  public func autofilter(range: Range) -> Worksheet {
    let _ = worksheet_autofilter(lxw_worksheet,
     range.row, range.col, range.row2, range.col2
    )
    return self
  }
  /// Set the option to display or hide gridlines on the screen and the printed page.
  @discardableResult
  public func gridline(screen: Bool, print: Bool = false) -> Worksheet {
    worksheet_gridlines(lxw_worksheet, UInt8((print ? 2 : 0) + (screen ? 1 : 0)))
    return self
  }
    /// Set a table in the worksheet.
  @discardableResult
  public func table(range: Range) -> Worksheet {
    var options = lxw_table_options()
    options.style_type = UInt8(LXW_TABLE_STYLE_TYPE_LIGHT.rawValue)
    options.style_type_number = 8
    options.total_row = 1
  
    worksheet_add_table(lxw_worksheet, range.row, range.col, range.row2, range.col2, &options)
    return self
  }
}

fileprivate func makeCString(from str: String) -> UnsafeMutablePointer<CChar> {
  let count = str.utf8.count + 1
  let result = UnsafeMutablePointer<CChar>.allocate(capacity: count)
  str.withCString { result.initialize(from: $0, count: count) }
  return result
}