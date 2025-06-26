//
//  PixelBackgroundModifier.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import Foundation
import SwiftUI

struct PixelBackgroundModifier: ViewModifier {
    var paddingValue: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(paddingValue)
            .background(
                Image("pixil-frame-2")
                    .interpolation(.none)
                    .resizable(capInsets: EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16), resizingMode: .stretch)
            )
    }
}

extension View {
    func pixelBackground(paddingValue: CGFloat = 24) -> some View {
        self.modifier(PixelBackgroundModifier(paddingValue: paddingValue))
    }
}
