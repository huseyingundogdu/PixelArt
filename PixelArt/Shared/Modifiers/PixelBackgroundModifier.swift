//
//  PixelBackgroundModifier.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import Foundation
import SwiftUI

struct PixelBackgroundModifier: ViewModifier {
    var paddingEdges: Edge.Set?
    var paddingValue: CGFloat
    
    func body(content: Content) -> some View {
        if let edges = paddingEdges {
            content
                .padding(edges, paddingValue)
                .background(
                    Image("pixil-frame-2")
                        .interpolation(.none)
                        .resizable()
                        .resizable(capInsets: EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16), resizingMode: .stretch)
                )
        } else {
            content
                .padding(paddingValue)
                .background(
                    Image("pixil-frame-2")
                        .interpolation(.none)
                        .resizable()
                        .resizable(capInsets: EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16), resizingMode: .stretch)
                )
        }
    }
}

extension View {
    func pixelBackground(
        paddingEdges: Edge.Set? = nil,
        paddingValue: CGFloat = 24
    ) -> some View {
        self.modifier(PixelBackgroundModifier(paddingEdges: paddingEdges, paddingValue: paddingValue))
    }
}
