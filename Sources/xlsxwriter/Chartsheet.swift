//
//  Chartsheet.swift
//  Created by Daniel Müllenborn on 31.12.20.
//

import Cxlsxwriter

/// Struct to represent an Excel chartsheet.
public struct Chartsheet {
  
  let lxw_chartsheet: UnsafeMutablePointer<lxw_chartsheet>
  
  init(_ lxw_chartsheet: UnsafeMutablePointer<lxw_chartsheet>) {
    self.lxw_chartsheet = lxw_chartsheet
  }
  /// Insert a chart object into a chartsheet
  public func set(chart: Chart) {
    chartsheet_set_chart(lxw_chartsheet, chart.lxw_chart)
  }
  /// Set a chartsheet tab as selected.
  public func select() {
    chartsheet_select(lxw_chartsheet)
  }
  /// Hide the current chartsheet.
  public func hide() {
    chartsheet_hide(lxw_chartsheet)
  }
  /// Make a chartsheet the active, i.e., visible chartsheet.
  public func activate() {
    chartsheet_activate(lxw_chartsheet)
  }
  /// Protect elements of a chartsheet from modification.
  public func protect(password: String) {
    password.withCString { chartsheet_protect(lxw_chartsheet, $0, nil) }
  }
  /// Set the paper type for printing.
  public func set_paper(type: PaperType) {
    chartsheet_set_paper(lxw_chartsheet, type.rawValue)
  }
  /// Set the chartsheet zoom factor.
  public func set_zoom(scale: Int) {
    chartsheet_set_zoom(lxw_chartsheet, UInt16(scale))
  }
  /// Set the page orientation as landscape.
  public func set_landscape() {
    chartsheet_set_landscape(lxw_chartsheet)
  }
  /// Set the page orientation as portrait.
  public func set_portrait() {
    chartsheet_set_portrait(lxw_chartsheet)
  }
  /// Set the printed page footer caption.
  public func set(footer: String) {
    footer.withCString { chartsheet_set_footer(lxw_chartsheet, $0) }
  }
  /// Set the printed page header caption.
  public func set(header: String) {
    header.withCString { chartsheet_set_header(lxw_chartsheet, $0)}
  }
}
