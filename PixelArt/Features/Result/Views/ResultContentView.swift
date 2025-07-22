//
//  ResultContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 04/07/2025.
//

import SwiftUI

private enum StringItems {
    static let colorsTitle = "Colors of Competition"
    static let winnersTitle = "Winner Artworks"
}

struct ResultContentView: View {
    @EnvironmentObject private var router: NavigationRouter
    
    let competition: Competition
    let artworks: [Artwork]
    
    var body: some View {
        ScrollView {
            
            VStack {
                Text(StringItems.colorsTitle)
                    .font(.custom("Micro5-Regular", size: 35))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ColorGridView(colorPalette: competition.colorPalette)
                
                
                Text(StringItems.winnersTitle)
                    .font(.custom("Micro5-Regular", size: 35))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ForEach(artworks, id: \.self) { artwork in
                    HStack {
                        
                        PixelGridView(
                            data: artwork.data,
                            columns: artwork.size[0],
                            rows: artwork.size[1],
                            availableWidth: K.Artwork.Size.regular.width,
                            availableHeight: K.Artwork.Size.regular.height
                        )
                        
                        Button {
                            router.competitionRoutes.append(.userProfile(userId: artwork.authorId))
                        } label: {
                            Text(artwork.authorUsername)
                        }
                        
                        Spacer()
                        
                    }
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity)
        .font(.custom("Micro5-Regular", size: 25))
        .background(Color(hex: "d4d4d4"))
    }
}

#Preview {
    ResultContentView(competition: MockData.competition, artworks: MockData.artworks)
}
