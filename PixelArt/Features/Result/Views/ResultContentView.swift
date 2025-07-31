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
    let artworks: [ArtworkUIModel]
    
    var body: some View {
        ScrollView {
            
            VStack {
                Text(StringItems.colorsTitle)
                    .font(.Micro5.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ColorGridView(colorPalette: competition.colorPalette)
                
                
                Text(StringItems.winnersTitle)
                    .font(.Micro5.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ForEach(artworks.indices, id: \.self) { index in
                    HStack {
                        Text("#\(index + 1)")
                            .font(.Micro5.xxLarge)
                        
                        
                        PixelGridView(
                            data: artworks[index].data,
                            columns: artworks[index].size[0],
                            rows: artworks[index].size[1],
                            availableWidth: K.Artwork.Size.regular.width,
                            availableHeight: K.Artwork.Size.regular.height
                        )
                        
                        Button {
                            router.competitionRoutes.append(.userProfile(userId: artworks[index].authorId))
                        } label: {
                            Text(artworks[index].authorUsername)
                        }
                        .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Text("\(artworks[index].likeCount ?? 0)")
                        Image("ic_heart_fill")
                            .interpolation(.none)
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity)
        
        .background(Color(hex: "d4d4d4"))
    }
}

//#Preview {
//    ResultContentView(competition: MockData.competition, artworks: MockData.artworks)
//}
