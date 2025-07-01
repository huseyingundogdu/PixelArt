//
//  VotingContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 29/06/2025.
//

import SwiftUI

struct VotingContentView: View {
    let competition: Competition
    let artworks: [Artwork]
    
    var body: some View {
        ScrollView {

            Text("\(competition.size[0]) x \(competition.size[1])")
            
            Text("Artworks")
                .font(.custom("Micro5-Regular", size: 35))
            
            
            ForEach(artworks, id: \.self) { artwork in
                HStack {
                    ArtworkViewer(artwork: artwork)
                    
                    VStack(alignment: .leading) {
                        Text(artwork.authorId)
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                        }
                    }
                    
                    Spacer()
            
                }
                .padding(.horizontal)
            }
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity)
        .font(.custom("Micro5-Regular", size: 25))
        .background(Color(hex: "d4d4d4"))
    }
}

#Preview {
    VotingContentView(competition: MockData.competition, artworks: MockData.artworks)
}
