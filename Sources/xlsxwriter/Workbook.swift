//
//  Workbook.swift
//  Created by Daniel Müllenborn on 31.12.20.
//

import libxlsxwriter

/// Struct to represent an Excel workbook.
public struct Workbook {
  var lxw_workbook: UnsafeMutablePointer<lxw_workbook>

  /// Create a new workbook object.
  public init(name: String) { self.lxw_workbook = name.withCString { workbook_new($0) } }
  /// Close the Workbook object and write the XLSX file.
  public func close() {
    let error = workbook_close(lxw_workbook)
    if error.rawValue != 0 { fatalError(String(cString: lxw_strerror(error))) }
  }
  /// Add a new worksheet to the Excel workbook.
  public func addWorksheet(name: String? = nil) -> Worksheet {
    let worksheet: UnsafeMutablePointer<lxw_worksheet>
    if let name = name {
      worksheet = name.withCString { workbook_add_worksheet(lxw_workbook, $0) }
    } else {
      worksheet = workbook_add_worksheet(lxw_workbook, nil)
    }
    return Worksheet(worksheet)
  }
  /// Add a new chartsheet to a workbook.
  public func addChartsheet(name: String? = nil) -> Chartsheet {
    let chartsheet: UnsafeMutablePointer<lxw_chartsheet>
    if let name = name {
      chartsheet = name.withCString { workbook_add_chartsheet(lxw_workbook, $0) }
    } else {
      chartsheet = workbook_add_chartsheet(lxw_workbook, nil)
    }
    return Chartsheet(chartsheet)
  }
  /// Add a new format to the Excel workbook.
  public func addFormat() -> Format { Format(workbook_add_format(lxw_workbook)) }
  /// Create a new chart to be added to a worksheet
  public func addChart(type: Chart_type) -> Chart {
    Chart(workbook_add_chart(lxw_workbook, type.rawValue))
  }
  /// Get a worksheet object from its name.
  public subscript(worksheet name: String) -> Worksheet? {
    guard let ws = name.withCString({ s in workbook_get_worksheet_by_name(lxw_workbook, s) }) else {
      return nil
    }
    return Worksheet(ws)
  }
  /// Get a chartsheet object from its name.
  public subscript(chartsheet name: String) -> Chartsheet? {
    guard let cs = name.withCString({ s in workbook_get_chartsheet_by_name(lxw_workbook, s) })
    else { return nil }
    return Chartsheet(cs)
  }
  /// Validate a worksheet or chartsheet name.
  func validate(sheet_name: String) {
    let _ = sheet_name.withCString { workbook_validate_sheet_name(lxw_workbook, $0) }
  }
}
