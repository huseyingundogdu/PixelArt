//
//  Font+Extension.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 26/07/2025.
//

import SwiftUI

extension Font {
    struct Micro5 {
        static let xxLarge = Font.custom("Micro5-Regular", size: 40)
        static let xLarge = Font.custom("Micro5-Regular", size: 35)
        static let large = Font.custom("Micro5-Regular", size: 30)
        static let medium = Font.custom("Micro5-Regular", size: 25)
        static let small = Font.custom("Micro5-Regular", size: 20)
        static let xSmall = Font.custom("Micro5-Regular", size: 15)
    }
}


#Preview {
    return VStack {
        Text("Large Text")
            .font(Font.Micro5.large)
        Text("Medium Text")
            .font(Font.Micro5.medium)
        Text("Small Text")
            .font(Font.Micro5.small)
        Text("Test Text")
            .font(.Micro5.medium)
    }
}
