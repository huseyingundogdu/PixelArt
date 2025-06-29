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
            Text("Competition")
                .font(.title)
                .bold()
            Text("\(competition.id)")
            Text("\(competition.topic)")
            Text("\(competition.size[0]) x \(competition.size[1])")
            Text("\(competition.status)")
            
            Divider()
            
            Text("Artworks")
                .font(.title)
                .bold()
            
            ForEach(artworks, id: \.self) { artwork in
                VStack {
                    Text(artwork.id)
                    Text(artwork.authorId)
                    Text(artwork.data.description)
                }
                .background(.gray.opacity(0.2))
            }
        }
        
    }
}

#Preview {
    VotingContentView(competition: MockData.competition, artworks: MockData.artworks)
}
