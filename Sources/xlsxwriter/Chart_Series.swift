//
//  Chart_Series.swift
//  Created by Daniel Müllenborn on 31.12.20.
//

import Cxlsxwriter

/// Struct to represent an Excel chart.
public struct Chart {
  
  let lxw_chart: UnsafeMutablePointer<lxw_chart>
  
  init(_ lxw_chart: UnsafeMutablePointer<lxw_chart>) {
    self.lxw_chart = lxw_chart
  }
  /// Add a data series to a chart.
  @discardableResult
  public func add(series: String, name: String? = nil) -> Series {
    let series = series.withCString {
      Series(chart_add_series(lxw_chart, nil, $0))
    }
    if let name = name {
      series.set(name: name)
    }
    return series
  }
  /// Set the name caption of the x axis.
  public func set(x_axis name: String) {
    name.withCString {
      chart_axis_set_name(lxw_chart.pointee.x_axis, $0)
    }
  }
  /// Set the name caption of the y axis.
  public func set(y_axis name: String) {
    name.withCString {
      chart_axis_set_name(lxw_chart.pointee.y_axis, $0)
    }
  }
  /// Set the chart style type.
  public func set(style: Int) {
    chart_set_style(lxw_chart, UInt8(style))
  }
}

/// Struct to represent an Excel chart data series.
public struct Series {

  let lxw_chart_series: UnsafeMutablePointer<lxw_chart_series>
  
  init(_ lxw_chart_series: UnsafeMutablePointer<lxw_chart_series>) {
    self.lxw_chart_series = lxw_chart_series
  }
  /// Set the name of a chart series range.
  public func set(name: String) {
    name.withCString {
      chart_series_set_name(lxw_chart_series, $0)
    }
  }
  /// Smooth a line or scatter chart series.
  public func set(smooth: Bool) {
    let smooth: UInt8 = smooth ? 1 : 0
    chart_series_set_smooth(lxw_chart_series, smooth)
  }
}
