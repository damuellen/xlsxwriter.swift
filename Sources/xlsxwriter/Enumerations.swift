//
//  Enumerations.swift
//  Created by Daniel Müllenborn on 31.12.20.
//

import Foundation

public enum Value {
  case url(URL)
  case blank
  case comment(String)
  case number(Double)
  case string(String)
  case boolean(Bool)
  case formula(String)
  case datetime(String)
}

/// Cell border styles for use with format.set_border()
public enum Border: UInt8 {
 case NoBorder
 case Thin
 case Medium
 case Dashed
 case Dotted
 case Thick
 case Double
 case Hair
 case Medium_dashed
 case Dash_dot
 case Medium_dash_dot
 case Dash_dot_dot
 case Medium_dash_dot_dot
 case Slant_dash_dot
}

/// Alignment values for format.set(alignment:)
public enum Alignment: UInt8 {
  case None = 0
  case Left
  case Center
  case Right
  case Fill
  case Justify
  case Center_Across
  case DISTRIBUTED
  case VERTICAL_TOP
  case VERTICAL_BOTTOM
  case VERTICAL_CENTER
  case VERTICAL_JUSTIFY
  case VERTICAL_DISTRIBUTED
}

/// The Excel paper format type.
public enum PaperType: UInt8 {
  case PrinterDefault = 0      // Printer default
  case Letter                  // 8 1/2 x 11 in
  case LetterSmall             // 8 1/2 x 11 in
  case Tabloid                 // 11 x 17 in
  case Ledger                  // 17 x 11 in
  case Legal                   // 8 1/2 x 14 in
  case Statement               // 5 1/2 x 8 1/2 in
  case Executive               // 7 1/4 x 10 1/2 in
  case A3                      // 297 x 420 mm
  case A4                      // 210 x 297 mm
  case A4Small                 // 210 x 297 mm
  case A5                      // 148 x 210 mm
  case B4                      // 250 x 354 mm
  case B5                      // 182 x 257 mm
  case Folio                   // 8 1/2 x 13 in
  case Quarto                  // 215 x 275 mm
  case unnamed1                // 10x14 in
  case unnamed2                // 11x17 in
  case Note                    // 8 1/2 x 11 in
  case Envelope_9              // 3 7/8 x 8 7/8
  case Envelope_10             // 4 1/8 x 9 1/2
  case Envelope_11             // 4 1/2 x 10 3/8
  case Envelope_12             // 4 3/4 x 11
  case Envelope_14             // 5 x 11 1/2
  case C_size_sheet            // ---
  case D_size_sheet            // ---
  case E_size_sheet            // ---
  case Envelope_DL             // 110 x 220 mm
  case Envelope_C3             // 324 x 458 mm
  case Envelope_C4             // 229 x 324 mm
  case Envelope_C5             // 162 x 229 mm
  case Envelope_C6             // 114 x 162 mm
  case Envelope_C65            // 114 x 229 mm
  case Envelope_B4             // 250 x 353 mm
  case Envelope_B5             // 176 x 250 mm
  case Envelope_B6             // 176 x 125 mm
  case Envelope                // 110 x 230 mm
  case Monarch                 // 3.875 x 7.5 in
  case EnvelopeInch            // 3 5/8 x 6 1/2 in
  case Fanfold                 // 14 7/8 x 11 in
  case German_Std_Fanfold      // 8 1/2 x 12 in
  case German_Legal_Fanfold    // 8 1/2 x 13 in
}
/// Predefined values for common colors.
public enum Color: UInt32 {
  case Black = 0x1000000
  case Blue = 0x0000FF
  case Brown = 0x800000
  case Cyan = 0x00FFFF
  case Gray = 0x808080
  case Green = 0x008000
  case Lime = 0x00FF00
  case Magenta = 0xFF00FF
  case Navy = 0x000080
  case Orange = 0xFF6600
  case Purple = 0x800080
  case Red = 0xFF0000
  case Silver = 0xC0C0C0
  case White = 0xFFFFFF
  case Yellow = 0xFFFF00
}

/// Available chart types.
public enum Chart_type: UInt8 {
  case None
  case Area
  case Area_stacked
  case Area_percentage_stacked
  case Bar
  case Bar_stacked
  case Bar_percentage_stacked
  case Column
  case Column_stacked
  case Column_percentage_stacked
  case Doughnut
  case Line
  case Line_stacked
  case Line_percentage_stacked
  case Pie
  case Scatter
  case Scatter_straight
  case Scatter_straight_with_markers
  case Scatter_smooth
  case Scatter_smooth_with_markers
  case Radar
  case Radar_with_markers
  case Radar_filled
}
