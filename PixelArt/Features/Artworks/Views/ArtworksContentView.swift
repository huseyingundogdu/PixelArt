//
//  ArtworksContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import SwiftUI

struct ArtworksContentView: View {
    let personal: [ArtworkUIModel]
    let shared: [ArtworkUIModel]
    let active: [ArtworkUIModel]
    let archived: [ArtworkUIModel]
    
    @Binding var selectedArtwork: ArtworkUIModel?
    // Add closures for share and delete
    var onShare: ((ArtworkUIModel) -> Void)? = nil
    var onDelete: ((ArtworkUIModel) -> Void)? = nil
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                SectionView(title: "Personal Artworks", artworks: personal, selectedArtwork: $selectedArtwork, onShare: onShare, onDelete: onDelete)
                SectionView(title: "Shared Artworks", artworks: shared, selectedArtwork: $selectedArtwork, onShare: onShare, onDelete: onDelete)
                SectionView(title: "Active Competition Artworks", artworks: active, selectedArtwork: $selectedArtwork, onShare: onShare, onDelete: onDelete)
                SectionView(title: "Past Competition Artworks", artworks: archived, selectedArtwork: $selectedArtwork, onShare: onShare, onDelete: onDelete)
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
    @EnvironmentObject var router: NavigationRouter
    
    let title: String
    let artworks: [ArtworkUIModel]
    
    @Binding var selectedArtwork: ArtworkUIModel?
    // Add closures for share and delete
    var onShare: ((ArtworkUIModel) -> Void)? = nil
    var onDelete: ((ArtworkUIModel) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.custom("Micro5-Regular", size: 30))
            
            if artworks.isEmpty {
                Text("No artworks available.")
                    .foregroundStyle(.gray)
            } else {
                ForEach(artworks, id: \.self) { artwork in
                    Button {
                        selectedArtwork = artwork
                    } label: {
                        HStack {
                            PixelGridView(
                                data: artwork.data,
                                columns: artwork.size[0],
                                rows: artwork.size[1],
                                availableWidth: K.Artwork.Size.regular.width,
                                availableHeight: K.Artwork.Size.regular.height
                            )
                            VStack(alignment: .leading) {
                                Text(artwork.topic)
                                Text("Size: \(artwork.size[0]) x \(artwork.size[1])")
                                Text("\(artwork.lastUpdated)")
                                Text("IsSynced: \(artwork.isSynced.description)")
                            }
                            Spacer()
                        }
                    }
                    .foregroundStyle(.black)
                    .swipeActions(edge: .trailing) {
                        Button {
                            onShare?(artwork)
                        } label: {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }.tint(.blue)
                        Button(role: .destructive) {
                            onDelete?(artwork)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
        }
    }
}
