//
//  Color+Extension.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI

//extension Color {
//    init?(hex: String, opacity: Double = 1) {
//        // Remove leading "#" if present
//        let hexString = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
//        
//        // Ensure the string is valid (6 or 8 characters for RGB or ARGB)
//        guard hexString.count == 6 || hexString.count == 8,
//              let hexValue = Int(hexString, radix: 16) else {
//            return nil
//        }
//        
//        let red, green, blue: Double
//        if hexString.count == 6 {
//            // RGB format
//            red = Double((hexValue >> 16) & 0xff) / 255
//            green = Double((hexValue >> 8) & 0xff) / 255
//            blue = Double(hexValue & 0xff) / 255
//        } else {
//            // ARGB format (alpha is ignored, use `opacity` instead)
//            red = Double((hexValue >> 16) & 0xff) / 255
//            green = Double((hexValue >> 8) & 0xff) / 255
//            blue = Double(hexValue & 0xff) / 255
//        }
//        
//        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
//    }
//}


extension Color {
    init(hex: String, opacity: Double = 1) {
        // Remove leading "#" if present
        let hexString = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex

        // Ensure the string is valid (6 or 8 characters for RGB or ARGB)
        guard hexString.count == 6 || hexString.count == 8,
              let hexValue = Int(hexString, radix: 16) else {
            fatalError("Invalid hex string")
        }

        let red, green, blue: Double
        if hexString.count == 6 {
            // RGB format
            red = Double((hexValue >> 16) & 0xff) / 255
            green = Double((hexValue >> 8) & 0xff) / 255
            blue = Double(hexValue & 0xff) / 255
        } else {
            // ARGB format (alpha is ignored, use `opacity` instead)
            red = Double((hexValue >> 16) & 0xff) / 255
            green = Double((hexValue >> 8) & 0xff) / 255
            blue = Double(hexValue & 0xff) / 255
        }

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
