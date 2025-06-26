//
//  ArtworkViewer.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 05/06/2025.
//

import SwiftUI

struct ArtworkViewer: View {
    
    let artwork: Artwork
    
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<artwork.size[1], id: \.self) { row in
                GridRow {
                    ForEach(0..<artwork.size[0], id: \.self) { col in
                        let index = row * artwork.size[0] + col
                        Rectangle()
                            .fill(Color(hex: artwork.data[index]))
//                            .frame(width: 25, height: 25)
                    }
                }
            }
        }
        .frame(width: 150, height: 150)
        .padding(4)
        .border(.black, width: 4)
        .pixelBackground(paddingValue: 10)

        
        
    }
}

#Preview {
    ArtworkViewer(artwork: MockData.artwork_mushroom)
}

/*
 static let artwork = Artwork(
     id: "1",
     authorId: "authorId",
     data: ["870058", "a4303f", "f2d0a4", "c8d6af"],
     competitionId: "competitionId",
     size: "2x2"
 )
 */
