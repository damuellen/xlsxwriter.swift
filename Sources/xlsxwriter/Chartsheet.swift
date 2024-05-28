//
//  Chartsheet.swift
//  Created by Daniel Müllenborn on 31.12.20.
//

import libxlsxwriter

/// Struct to represent an Excel chartsheet.
public struct Chartsheet {
  var lxw_chartsheet: UnsafeMutablePointer<lxw_chartsheet>
  init(_ lxw_chartsheet: UnsafeMutablePointer<lxw_chartsheet>) {
    self.lxw_chartsheet = lxw_chartsheet
  }
  /// Insert a chart object into a chartsheet
  @discardableResult public func set(chart: Chart) -> Chartsheet {
    chartsheet_set_chart(lxw_chartsheet, chart.lxw_chart)
    return self
  }
  /// Set a chartsheet tab as selected.
  @discardableResult public func select() -> Chartsheet {
    chartsheet_select(lxw_chartsheet)
    return self
  }
  /// Hide the current chartsheet.
  @discardableResult public func hide() -> Chartsheet {
    chartsheet_hide(lxw_chartsheet)
    return self
  }
  /// Make a chartsheet the active, i.e., visible chartsheet.
  @discardableResult public func activate() -> Chartsheet {
    chartsheet_activate(lxw_chartsheet)
    return self
  }
  /// Protect elements of a chartsheet from modification.
  @discardableResult public func protect(password: String) -> Chartsheet {
    password.withCString { chartsheet_protect(lxw_chartsheet, $0, nil) }
    return self
  }
  /// Set the paper type for printing.
  @discardableResult public func paper(type: PaperType) -> Chartsheet {
    chartsheet_set_paper(lxw_chartsheet, type.rawValue)
    return self
  }
  /// Set the chartsheet zoom factor.
  @discardableResult public func zoom(scale: Int) -> Chartsheet {
    chartsheet_set_zoom(lxw_chartsheet, UInt16(scale))
    return self
  }
  /// Set the page orientation as landscape.
  @discardableResult public func landscape() -> Chartsheet {
    chartsheet_set_landscape(lxw_chartsheet)
    return self
  }
  /// Set the page orientation as portrait.
  @discardableResult public func portrait() -> Chartsheet {
    chartsheet_set_portrait(lxw_chartsheet)
    return self
  }
  /// Set the printed page footer caption.
  @discardableResult public func set(footer: String) -> Chartsheet {
    let _ = footer.withCString { chartsheet_set_footer(lxw_chartsheet, $0) }
    return self
  }
  /// Set the printed page header caption.
  @discardableResult public func set(header: String) -> Chartsheet {
    let _ = header.withCString { chartsheet_set_header(lxw_chartsheet, $0) }
    return self
  }
}
