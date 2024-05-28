//
//  Format.swift
//  Created by Daniel Müllenborn on 31.12.20.
//

import libxlsxwriter

/// Struct to represent the formatting properties of an Excel format.
public struct Format {
  let lxw_format: UnsafeMutablePointer<lxw_format>
  init(_ lxw_format: UnsafeMutablePointer<lxw_format>) { self.lxw_format = lxw_format }
  /// Turn on bold for the format font.
  @discardableResult public func bold() -> Format {
    format_set_bold(lxw_format)
    return self
  }
  /// Turn on italic for the format font.
  @discardableResult public func italic() -> Format {
    format_set_italic(lxw_format)
    return self
  }
  /// Set the cell border style.
  @discardableResult public func border(style: Border) -> Format {
    format_set_border(lxw_format, style.rawValue)
    return self
  }
  /// Set the cell top border style.
  @discardableResult public func top(style: Border) -> Format {
    format_set_top(lxw_format, style.rawValue)
    return self
  }
  /// Set the cell bottom border style.
  @discardableResult public func bottom(style: Border) -> Format {
    format_set_bottom(lxw_format, style.rawValue)
    return self
  }
  /// Set the cell left border style.
  @discardableResult public func left(style: Border) -> Format {
    format_set_left(lxw_format, style.rawValue)
    return self
  }
  /// Set the cell right border style.
  @discardableResult public func right(style: Border) -> Format {
    format_set_right(lxw_format, style.rawValue)
    return self
  }
  /// Set the horizontal alignment for data in the cell.
  @discardableResult public func align(horizontal: HorizontalAlignment) -> Format {
    format_set_align(lxw_format, horizontal.rawValue)
    return self
  }
  /// Set the vertical alignment for data in the cell.
  @discardableResult public func align(vertical: VerticalAlignment) -> Format {
    format_set_align(lxw_format, vertical.rawValue)
    return self
  }
  /// Set the vertical alignment and horizontal alignment to center.
  @discardableResult public func center() -> Format {
    format_set_align(lxw_format, HorizontalAlignment.center.rawValue)
    format_set_align(lxw_format, VerticalAlignment.center.rawValue)
    return self
  }
  /// Set the number format for a cell.
  @discardableResult public func set(num_format: String) -> Format {
    num_format.withCString { format_set_num_format(lxw_format, $0) }
    return self
  }
  /// Set the Excel built-in number format for a cell.
  @discardableResult public func set(num_format index: Int) -> Format {
    format_set_num_format_index(lxw_format, UInt8(index))
    return self
  }
  /// Turn on the text "shrink to fit" for a cell.
  @discardableResult public func shrink() -> Format {
    format_set_shrink(lxw_format)
    return self
  }
  /// Set the font used in the cell.
  @discardableResult public func font(name: String) -> Format {
    name.withCString { format_set_font_name(lxw_format, $0) }
    return self
  }
  /// Set the color of the cell border.
  @discardableResult public func border(color: Color) -> Format {
    format_set_border_color(lxw_format, color.hex)
    return self
  }
  /// Set the color of the font used in the cell.
  @discardableResult public func font(color: Color) -> Format {
    format_set_font_color(lxw_format, color.hex)
    return self
  }
  /// Set the pattern background color for a cell.
  @discardableResult public func background(color: Color) -> Format {
    format_set_pattern(lxw_format, 1)
    format_set_bg_color(lxw_format, color.hex)
    return self
  }
  /// Set the rotation of the text in a cell.
  @discardableResult public func rotation(angle: Int) -> Format {
    format_set_rotation(lxw_format, Int16(angle))
    return self
  }
  /// Set the size of the font used in the cell.
  @discardableResult public func font(size: Double) -> Format {
    format_set_font_size(lxw_format, size)
    return self
  }
  /// Set the text wrap to cell. This is required which cell's text contains line break to show correctly.
  @discardableResult public func setTextWrap() -> Format {
      format_set_text_wrap(lxw_format)
      return self
  }
}

/// Structure for color which contains common colors.
public struct Color {
  public var hex: UInt32
  public init(hex: UInt32) {
      self.hex = hex
  }
  
  public static var black: Self = Self(hex: 0x1000000)
  public static var blue: Self = Self(hex: 0x0000FF)
  public static var brown: Self = Self(hex: 0x800000)
  public static var cyan: Self = Self(hex: 0x00FFFF)
  public static var gray: Self = Self(hex: 0x808080)
  public static var green: Self = Self(hex: 0x008000)
  public static var lime: Self = Self(hex: 0x00FF00)
  public static var magenta: Self = Self(hex: 0xFF00FF)
  public static var navy: Self = Self(hex: 0x000080)
  public static var orange: Self = Self(hex: 0xFF6600)
  public static var purple: Self = Self(hex: 0x800080)
  public static var red: Self = Self(hex: 0xFF0000)
  public static var silver: Self = Self(hex: 0xC0C0C0)
  public static var white: Self = Self(hex: 0xFFFFFF)
  public static var yellow: Self = Self(hex: 0xFFFF00)
}

