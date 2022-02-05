//
//  Color.swift
//  
//
//  Created by Marcus Rossel on 05.02.22.
//

#if canImport(SwiftUI)
import SwiftUI
#elseif canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public struct Color: Codable {
    
    public var rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    #if canImport(UIKit)
    public typealias Native = UIColor
    #elseif canImport(AppKit)
    public typealias Native = NSColor
    #endif
    
    #if canImport(UIKit) || canImport(AppKit)
    public init?(_ color: Native) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        guard let rgba = color.usingColorSpace(.deviceRGB) else { return nil }
        rgba.getRed(&r, green: &g, blue: &b, alpha: &a)

        rawValue = 0
        rawValue += UInt32((a * 255.0).rounded()) << (3 * 8)
        rawValue += UInt32((r * 255.0).rounded()) << (2 * 8)
        rawValue += UInt32((g * 255.0).rounded()) << (1 * 8)
        rawValue += UInt32((b * 255.0).rounded()) << (0 * 8)
    }
    #endif
    
    #if canImport(SwiftUI)
    @available(macOS 11.0, *)
    public init?(color: SwiftUI.Color) {
        self.init(Native(color))
    }
    #endif
    
    #if canImport(SwiftUI)
    @available(macOS 11.0, *)
    public var swiftUIColor: SwiftUI.Color {
        let alpha = Double((rawValue >> (3 * 8)) & 0xFF) / 255.0
        let red =   Double((rawValue >> (2 * 8)) & 0xFF) / 255.0
        let green = Double((rawValue >> (1 * 8)) & 0xFF) / 255.0
        let blue =  Double((rawValue >> (0 * 8)) & 0xFF) / 255.0
        return SwiftUI.Color(red: red, green: green, blue: blue, opacity: alpha)
    }
    #endif
}

/// Predefined values for common colors.
extension Color {
    public static let black = Color(rawValue: 0x1000000)
    public static let blue = Color(rawValue: 0x0000FF)
    public static let brown = Color(rawValue: 0x800000)
    public static let cyan = Color(rawValue: 0x00FFFF)
    public static let gray = Color(rawValue: 0x808080)
    public static let green = Color(rawValue: 0x008000)
    public static let lime = Color(rawValue: 0x00FF00)
    public static let magenta = Color(rawValue: 0xFF00FF)
    public static let navy = Color(rawValue: 0x000080)
    public static let orange = Color(rawValue: 0xFF6600)
    public static let purple = Color(rawValue: 0x800080)
    public static let red = Color(rawValue: 0xFF0000)
    public static let silver = Color(rawValue: 0xC0C0C0)
    public static let white = Color(rawValue: 0xFFFFFF)
    public static let yellow = Color(rawValue: 0xFFFF00)
}
