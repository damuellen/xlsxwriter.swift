//
//  Chartsheet.swift
//  Created by Daniel Müllenborn on 31.12.20.
//

import Cxlsxwriter

/// Struct to represent an Excel chartsheet.
public final class Chartsheet {
  var lxw_chartsheet: lxw_chartsheet
  init(_ lxw_chartsheet: lxw_chartsheet) { self.lxw_chartsheet = lxw_chartsheet }
  /// Insert a chart object into a chartsheet
  @discardableResult public func set(chart: Chart) -> Chartsheet {
    _ = withUnsafeMutablePointer(to: &lxw_chartsheet) { cs in chartsheet_set_chart(cs, chart.lxw_chart) }
    return self
  }
  /// Set a chartsheet tab as selected.
  @discardableResult public func select() -> Chartsheet {
    withUnsafeMutablePointer(to: &lxw_chartsheet) { cs in chartsheet_select(cs) }
    return self
  }
  /// Hide the current chartsheet.
  @discardableResult public func hide() -> Chartsheet {
    withUnsafeMutablePointer(to: &lxw_chartsheet) { cs in chartsheet_hide(cs) }
    return self
  }
  /// Make a chartsheet the active, i.e., visible chartsheet.
  @discardableResult public func activate() -> Chartsheet {
    withUnsafeMutablePointer(to: &lxw_chartsheet) { cs in chartsheet_activate(cs) }
    return self
  }
  /// Protect elements of a chartsheet from modification.
  @discardableResult public func protect(password: String) -> Chartsheet {
    withUnsafeMutablePointer(to: &lxw_chartsheet) { cs in password.withCString { chartsheet_protect(cs, $0, nil) } }
    return self
  }
  /// Set the paper type for printing.
  @discardableResult public func paper(type: PaperType) -> Chartsheet {
    withUnsafeMutablePointer(to: &lxw_chartsheet) { cs in chartsheet_set_paper(cs, type.rawValue) }
    return self
  }
  /// Set the chartsheet zoom factor.
  @discardableResult public func zoom(scale: Int) -> Chartsheet {
    withUnsafeMutablePointer(to: &lxw_chartsheet) { cs in chartsheet_set_zoom(cs, UInt16(scale)) }
    return self
  }
  /// Set the page orientation as landscape.
  @discardableResult public func landscape() -> Chartsheet {
    withUnsafeMutablePointer(to: &lxw_chartsheet) { cs in chartsheet_set_landscape(cs) }
    return self
  }
  /// Set the page orientation as portrait.
  @discardableResult public func portrait() -> Chartsheet {
    withUnsafeMutablePointer(to: &lxw_chartsheet) { cs in chartsheet_set_portrait(cs) }
    return self
  }
  /// Set the printed page footer caption.
  @discardableResult public func set(footer: String) -> Chartsheet {
    withUnsafeMutablePointer(to: &lxw_chartsheet) { cs in let _ = footer.withCString { chartsheet_set_footer(cs, $0) } }
    return self
  }
  /// Set the printed page header caption.
  @discardableResult public func set(header: String) -> Chartsheet {
    withUnsafeMutablePointer(to: &lxw_chartsheet) { cs in let _ = header.withCString { chartsheet_set_header(cs, $0) } }
    return self
  }
}
