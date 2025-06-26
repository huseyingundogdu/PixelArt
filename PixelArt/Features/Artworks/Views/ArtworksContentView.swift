//
//  ArtworksContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import SwiftUI

struct ArtworksContentView: View {
    
    let artworks: [Artwork]
    
    var body: some View {
        ScrollView {
            // Personal artwork not submitted - use local db
            VStack(alignment: .leading) {
                Text("Personal Artworks")
                    .font(.custom("Micro5-Regular", size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("There is no personal artwork, create one.")
                    .foregroundStyle(.gray)
            }
            .padding()
            
            
            Rectangle()
                .frame(height: 3)
                .padding(.horizontal)
            
            
            // Current active competition artwork
            VStack(alignment: .leading) {
                Text("Active Competition Artwork")
                    .font(.custom("Micro5-Regular", size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("There is no active competition artwork.")
                    .foregroundStyle(.gray)
                
            }
            .padding()
            
            
            Rectangle()
                .frame(height: 3)
                .padding(.horizontal)
            
            // Archived submitted competition related artworks from firebase
            VStack(alignment: .leading) {
                
                Text("Past Competition Artworks")
                    .font(.custom("Micro5-Regular", size: 30))
                
                ForEach(artworks, id: \.self) { artwork in
                    
                    // Artwork Cell
                    HStack {
                        ArtworkViewer(artwork: artwork)
                        
                        VStack(alignment: .leading) {
                            if let topic = artwork.topic {
                                Text(topic)
                            }
                            if let competitionId = artwork.competitionId {
                                Text(competitionId)
                            }
                            Text("\(artwork.size[0]) x \(artwork.size[1])")
                        }
                        
                        Spacer()
                    }
                    
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "d4d4d4"))
        .font(.custom("Micro5-Regular", size: 25))
    }
}

#Preview {
    ArtworksContentView(artworks: MockData.artworks)
}
