//
//  ArtworksContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import SwiftUI

struct ArtworksContentView: View {
    @State private var feedbackText: String = ""
    @State private var showFeedbackMessage: Bool = false
    
    let personal: [ArtworkUIModel]
    let shared: [ArtworkUIModel]
    let active: [ArtworkUIModel]
    let archived: [ArtworkUIModel]
    
    @Binding var selectedArtwork: ArtworkUIModel?
    // Add closures for share and delete
    var onShare: ((ArtworkUIModel) -> Void)? = nil
    var onDelete: ((ArtworkUIModel) -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    SectionView(
                        title: "Personal Artworks",
                        artworks: personal,
                        selectedArtwork: $selectedArtwork,
                        showFeedbackMessage: $showFeedbackMessage,
                        feedbackText: $feedbackText
                    )
                    SectionView(
                        title: "Shared Artworks",
                        artworks: shared,
                        selectedArtwork: $selectedArtwork,
                        showFeedbackMessage: $showFeedbackMessage,
                        feedbackText: $feedbackText
                    )
                    SectionView(title: "Active Competition Artworks",
                                artworks: active,
                                selectedArtwork: $selectedArtwork,
                                showFeedbackMessage: $showFeedbackMessage,
                                feedbackText: $feedbackText
                    )
                    SectionView(
                        title: "Past Competition Artworks",
                        artworks: archived,
                        selectedArtwork: $selectedArtwork,
                        showFeedbackMessage: $showFeedbackMessage,
                        feedbackText: $feedbackText
                    )
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity)
            .background(Color(hex: "d4d4d4"))
            
            if showFeedbackMessage {
                Text(feedbackText)
                    .frame(alignment: .center)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .padding(.top, 20)
                    .zIndex(1)
            }
        }
    }
}

#Preview {
    let artworks = MockData.artworks.map { $0.toUIModel(isSynced: true) }
    let personal = artworks.filter { $0.status == .personal }
    let shared = artworks.filter { $0.status == .shared }
    let active = artworks.filter { $0.status == .activeCompetition }
    let archived = artworks.filter { $0.status == .archived }
    
    return ArtworksContentView(
        personal: personal,
        shared: shared,
        active: active,
        archived: archived,
        selectedArtwork: .constant(nil)
    )
}


struct SectionView: View {
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var networkMonitor: NetworkMonitor
    let title: String
    let artworks: [ArtworkUIModel]
    
    @Binding var selectedArtwork: ArtworkUIModel?

    @Binding var showFeedbackMessage: Bool
    @Binding var feedbackText: String
    // Add closures for share and delete
    //    var onShare: ((ArtworkUIModel) -> Void)? = nil
    //    var onDelete: ((ArtworkUIModel) -> Void)? = nil
    
    @GestureState var press = false
    @State var expandedArtworkIds: Set<String> = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.Micro5.medium)
                    .lineLimit(1)
                    .layoutPriority(1)
                Rectangle()
                    .frame(height: 2)
                    .frame(maxWidth: .infinity)
                
            }
            
            if artworks.isEmpty {
                Text("No artworks available.")
                    .foregroundStyle(.gray)
            } else {
                ForEach(artworks, id: \.self) { artwork in
                    VStack(alignment: .leading, spacing: 4) {
                        ZStack {
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
                                        .font(.Micro5.medium)
                                    VStack(alignment: .leading) {
                                        Text("Size: \(artwork.size[0]) x \(artwork.size[1])")
                                        Text("\(artwork.lastUpdated.formatted())")
                                        Text(artwork.competitionId ?? "")
                                        Text("IsSynced: \(artwork.isSynced.description)")
                                    }
                                    .foregroundStyle(.gray)
                                }
                                Spacer()
                            }
                        }
                        .contentShape(Rectangle()) // tüm görünümü dokunulabilir hale getirir
                        .onTapGesture {
                            if artwork.status == .personal || artwork.status == .activeCompetition {
                                selectedArtwork = artwork
                            } else {
                                feedbackText = "You can only select personal or active competition artworks."
                                withAnimation {
                                    showFeedbackMessage = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        showFeedbackMessage = false
                                    }
                                }
                            }
                        }
                        .gesture(
                            LongPressGesture(minimumDuration: 0.5)
                                .updating($press) { current, state, _ in
                                    state = current
                                }
                                .onEnded { _ in
                                    withAnimation(.easeInOut) {
                                        if expandedArtworkIds.contains(artwork.id) {
                                            expandedArtworkIds.remove(artwork.id)
                                        } else {
                                            expandedArtworkIds.insert(artwork.id)
                                        }
                                    }
                                }
                        )
                        
                        if expandedArtworkIds.contains(artwork.id) {
                            HStack(alignment: .center) {
                                switch artwork.status {
                                case .personal:
                                    Group {
                                        Button("Share") { }
                                        .foregroundStyle(.green)
                                        Spacer()
                                        Button("Edit") { }
                                        .foregroundStyle(.blue)
                                        Spacer()
                                        Button("Delete") { }
                                        .foregroundStyle(.red)
                                    }
                                case .shared:
                                    Group {
                                        Button("Unshare") { }
                                        .foregroundStyle(.red)
                                    }
                                case .activeCompetition:
                                    Group {
                                        Button("Submit") { }
                                        .foregroundStyle(.green)
                                    }
                                case .archived:
                                    EmptyView()
                                }
                            }
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .animation(.easeInOut, value: expandedArtworkIds)
                            .padding()
                        }
                        
                    }
                }
            }
        }
    }
}
