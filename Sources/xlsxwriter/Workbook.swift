//
//  Workbook.swift
//  Created by Daniel Müllenborn on 31.12.20.
//

import Cxlsxwriter

/// Struct to represent an Excel workbook.
public struct Workbook {

  let lxw_workbook: UnsafeMutablePointer<lxw_workbook>
  /// Create a new workbook object.
  public init(name: String) {
    self.lxw_workbook = name.withCString {
      workbook_new($0)
    }
  }
  /// Close the Workbook object and write the XLSX file.
  public func close() {
    print(String(cString: lxw_strerror(workbook_close(lxw_workbook))))
  }
  /// Add a new worksheet to the Excel workbook.
  public mutating func addWorksheet(name: String? = nil) -> Worksheet {
    let worksheet: UnsafeMutablePointer<lxw_worksheet>
    if let name = name {
      worksheet = name.withCString {
        workbook_add_worksheet(self.lxw_workbook, $0)
      }
    } else {
      worksheet = workbook_add_worksheet(self.lxw_workbook, nil)
    }
    return Worksheet(worksheet)
  }
  /// Add a new chartsheet to a workbook.
  public mutating func addChartsheet(name: String? = nil) -> Chartsheet {
    let chartsheet: UnsafeMutablePointer<lxw_chartsheet>
    if let name = name {
      chartsheet = name.withCString {
        workbook_add_chartsheet(self.lxw_workbook, $0)
      }
    } else {
      chartsheet = workbook_add_chartsheet(self.lxw_workbook, nil)
    }
    return Chartsheet(chartsheet)
  }
  /// Add a new format to the Excel workbook.
  public mutating func addFormat() -> Format {
    Format(workbook_add_format(lxw_workbook))
  }
  /// Create a new chart to be added to a worksheet
  public func add(chart: Chart_type) -> Chart {
    Chart(workbook_add_chart(lxw_workbook, chart.rawValue))
  }
  /// Get a worksheet object from its name.
  public subscript(worksheet name: String) -> Worksheet? {
    guard let ws = name.withCString({
      workbook_get_worksheet_by_name(lxw_workbook, $0)
    }) else { return nil }
    return Worksheet(ws)
  }
  /// Get a chartsheet object from its name.
  public subscript(chartsheet name: String) -> Chartsheet? {
    guard let cs = name.withCString({
      workbook_get_chartsheet_by_name(lxw_workbook, $0)
    }) else { return nil }
    return Chartsheet(cs)
  }
  /// Validate a worksheet or chartsheet name.
  func validate(sheet_name: String) {
    sheet_name.withCString {
      workbook_validate_sheet_name(lxw_workbook, $0)
    }
  }
}
