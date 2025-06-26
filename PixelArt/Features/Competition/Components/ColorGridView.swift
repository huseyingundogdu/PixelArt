//
//  ColorGridView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI

struct ColorGridView: View {
    
    var colorPalette: [String] = ["ffffff", "6afff8", "57d8ff", "2e2e49", "f34cff", "b200ff", "7600e5", "53355e", "ff4a97", "ff156b", "d90070", "a30054", "f0ff5c", "62ff89", "26dd7b", "227f5e"]
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 40))
                ],
                spacing: 10,
                content: {
                
                    ForEach(colorPalette, id: \.self) { color in
                        Color.init(hex: color)
                            .frame(width:30, height: 30)
                            .pixelBackground(paddingValue: 6)
                    }
                    
            })
        }
        .pixelBackground(paddingValue: 12)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ColorGridView()
}
