//
//  Enumerations.swift
//  Created by Daniel Müllenborn on 31.12.20.
//

import Foundation

public enum Value: ExpressibleByFloatLiteral, ExpressibleByStringLiteral {
  case url(URL)
  case blank
  case comment(String)
  case number(Double)
  case string(String)
  case boolean(Bool)
  case formula(String)
  case datetime(Date)
  public init(floatLiteral value: Double) { self = .number(value) }
  public init(stringLiteral value: String) { self = .string(value) }
}

public enum Axes { case X, Y }

public enum Trendline_type: UInt8 {
  case linear
  case log
  case poly
  case power
  case exp
  case average
}

/// Cell border styles for use with format.set_border()
public enum Border: UInt8 {
  case noBorder
  case thin
  case medium
  case dashed
  case dotted
  case thick
  case double
  case hair
  case medium_dashed
  case dash_dot
  case medium_dash_dot
  case dash_dot_dot
  case medium_dash_dot_dot
  case slant_dash_dot
}

/// Alignment values for format.set(alignment:)
public enum HorizontalAlignment: UInt8 {
  case none = 0
  case left
  case center
  case right
  case fill
  case justify
  case center_across
  case distributed

}

/// Alignment values for format.set(alignment:)
public enum VerticalAlignment: UInt8 {
  case top = 8
  case bottom
  case center
  case justify
  case distributed
}

/// The Excel paper format type.
public enum PaperType: UInt8 {
  case PrinterDefault = 0  // Printer default
  case Letter  // 8 1/2 x 11 in
  case LetterSmall  // 8 1/2 x 11 in
  case Tabloid  // 11 x 17 in
  case Ledger  // 17 x 11 in
  case Legal  // 8 1/2 x 14 in
  case Statement  // 5 1/2 x 8 1/2 in
  case Executive  // 7 1/4 x 10 1/2 in
  case A3  // 297 x 420 mm
  case A4  // 210 x 297 mm
  case A4Small  // 210 x 297 mm
  case A5  // 148 x 210 mm
  case B4  // 250 x 354 mm
  case B5  // 182 x 257 mm
  case Folio  // 8 1/2 x 13 in
  case Quarto  // 215 x 275 mm
  case unnamed1  // 10x14 in
  case unnamed2  // 11x17 in
  case Note  // 8 1/2 x 11 in
  case Envelope_9  // 3 7/8 x 8 7/8
  case Envelope_10  // 4 1/8 x 9 1/2
  case Envelope_11  // 4 1/2 x 10 3/8
  case Envelope_12  // 4 3/4 x 11
  case Envelope_14  // 5 x 11 1/2
  case C_size_sheet  // ---
  case D_size_sheet  // ---
  case E_size_sheet  // ---
  case Envelope_DL  // 110 x 220 mm
  case Envelope_C3  // 324 x 458 mm
  case Envelope_C4  // 229 x 324 mm
  case Envelope_C5  // 162 x 229 mm
  case Envelope_C6  // 114 x 162 mm
  case Envelope_C65  // 114 x 229 mm
  case Envelope_B4  // 250 x 353 mm
  case Envelope_B5  // 176 x 250 mm
  case Envelope_B6  // 176 x 125 mm
  case Envelope  // 110 x 230 mm
  case Monarch  // 3.875 x 7.5 in
  case EnvelopeInch  // 3 5/8 x 6 1/2 in
  case Fanfold  // 14 7/8 x 11 in
  case German_Std_Fanfold  // 8 1/2 x 12 in
  case German_Legal_Fanfold  // 8 1/2 x 13 in
}

/// Available chart types.
public enum Chart_type: UInt8 {
  case none
  case area
  case area_stacked
  case area_percentage_stacked
  case bar
  case bar_stacked
  case bar_percentage_stacked
  case column
  case column_stacked
  case column_percentage_stacked
  case doughnut
  case line
  case line_stacked
  case line_percentage_stacked
  case pie
  case scatter
  case scatter_straight
  case scatter_straight_with_markers
  case scatter_smooth
  case scatter_smooth_with_markers
  case radar
  case radar_with_markers
  case radar_filled
}

public enum Legend_position: UInt8 {
  case none = 0
  case right
  case left
  case top
  case bottom
  case top_right
  case overlay_right
  case overlay_left
  case overlay_top_right
}

public enum TotalFunction: UInt8, ExpressibleByIntegerLiteral {
  case none = 0
  /** Use the average function as the table total. */
  case average = 101
  /** Use the count numbers function as the table total. */
  case nums = 102
  /** Use the count function as the table total. */
  case count = 103
  /** Use the max function as the table total. */
  case max = 104
  /** Use the min function as the table total. */
  case min = 105
  /** Use the standard deviation function as the table total. */
  case std_dev = 107
  /** Use the sum function as the table total. */
  case sum = 109

  public init(integerLiteral value: Int) {
    if let function = TotalFunction(rawValue: UInt8(value)) {
      self = function
    } else {
      self = .none
    }
  }
}
