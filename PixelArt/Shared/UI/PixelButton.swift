//
//  PixelButton.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI

struct PixelButton: View {
    
    var icon: String = "ic_crown"
    
    var body: some View {
    
        Image(icon)
            .interpolation(.none)
            .resizable()
            .frame(width: 25, height: 25)
            .frame(width: 50, height: 50)
            .pixelBackground(paddingValue: 0)
    }
    
}

#Preview {
    PixelButton()
}
