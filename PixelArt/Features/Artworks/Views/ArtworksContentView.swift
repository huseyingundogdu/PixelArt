//
//  ArtworksContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import SwiftUI

struct ArtworksContentView: View {
    
    let personal: [Artwork]
    let shared: [Artwork]
    let active: [Artwork]
    let archived: [Artwork]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                SectionView(title: "Personal Artworks", artworks: personal)
                SectionView(title: "Shared Artworks", artworks: shared)
                SectionView(title: "Active Competition Artworks", artworks: active)
                SectionView(title: "Past Competition Artworks", artworks: archived)
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "d4d4d4"))
        .font(.custom("Micro5-Regular", size: 25))
    }
}

//#Preview {
//    ArtworksContentView(artworks: MockData.artworks)
//}


struct SectionView: View {
    let title: String
    let artworks: [Artwork]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.custom("Micro5-Regular", size: 30))
            
            if artworks.isEmpty {
                Text("No artworks available.")
                    .foregroundStyle(.gray)
            } else {
                ForEach(artworks, id: \.self) { artwork in
                    HStack {
                        ArtworkViewer(artwork: artwork)
                        VStack(alignment: .leading) {
                            if let topic = artwork.topic { Text(topic) }
                            if let competitionId = artwork.competitionId { Text(competitionId) }
                            Text("\(artwork.size[0]) x \(artwork.size[1])")
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}
