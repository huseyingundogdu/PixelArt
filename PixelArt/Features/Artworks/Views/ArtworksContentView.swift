//
//  ArtworksContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import SwiftUI

struct ArtworksContentView: View {
    @ObservedObject var viewModel: ArtworkViewModel
    
    let personal: [ArtworkUIModel]
    let shared: [ArtworkUIModel]
    let active: [ArtworkUIModel]
    let archived: [ArtworkUIModel]
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    SectionView(
                        viewModel: viewModel,
                        title: "Personal Artworks",
                        artworks: personal
                    )
                    SectionView(
                        viewModel: viewModel,
                        title: "Shared Artworks",
                        artworks: shared
                    )
                    SectionView(
                        viewModel: viewModel,
                        title: "Active Competition Artworks",
                        artworks: active
                    )
                    SectionView(
                        viewModel: viewModel,
                        title: "Past Competition Artworks",
                        artworks: archived
                    )
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity)
            .background(Color(hex: "d4d4d4"))
            
            if viewModel.showFeedbackMessage {
                Text(viewModel.feedbackText)
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
        .overlayAlert(
            isPresented: $viewModel.editPresented,
            title: "Edit title of artwork",
            confirmText: "Apply Changes") {
                TextField("New Title", text: $viewModel.newTitle)
            } onConfirm: {
                if let editingArtwork = viewModel.editingArtwork {
                    Task {
                        await viewModel.editArtwork(editingArtwork, title: viewModel.newTitle)
                    }
                }
            }

    }
}

//#Preview {
//    let artworks = MockData.artworks.map { $0.toUIModel(isSynced: true) }
//    let personal = artworks.filter { $0.status == .personal }
//    let shared = artworks.filter { $0.status == .shared }
//    let active = artworks.filter { $0.status == .activeCompetition }
//    let archived = artworks.filter { $0.status == .archived }
//    
//    return ArtworksContentView(
//        personal: personal,
//        shared: shared,
//        active: active,
//        archived: archived,
//        selectedArtwork: .constant(nil)
//    )
//}


struct SectionView: View {
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @ObservedObject var viewModel: ArtworkViewModel
    
    let title: String
    let artworks: [ArtworkUIModel]
    
    @GestureState var press = false
    
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
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if artwork.status == .personal || artwork.status == .activeCompetition {
                                viewModel.selectedArtwork = artwork
                            } else {
                                viewModel.showFeedback(.canNotDraw)
                            }
                        }
                        .gesture(
                            LongPressGesture(minimumDuration: 0.5)
                                .updating($press) { current, state, _ in
                                    state = current
                                }
                                .onEnded { _ in
                                    withAnimation(.easeInOut) {
                                        viewModel.toggleExpansion(for: artwork)
                                    }
                                }
                        )
                        
                        if viewModel.expandedArtworkIds.contains(artwork.id) {
                            HStack(alignment: .center) {
                                switch artwork.status {
                                case .personal:
                                    Group {
                                        Button("Share") { Task { await viewModel.shareArtwork(artwork) } }
                                        .foregroundStyle(.green)
                                        Spacer()
                                        Button("Edit") {
                                            viewModel.editingArtwork = artwork
                                            viewModel.newTitle = artwork.topic
                                            viewModel.editPresented = true
                                        }
                                        .foregroundStyle(.blue)
                                        Spacer()
                                        Button("Delete") { Task { await viewModel.deleteArtwork(artwork) } }
                                        .foregroundStyle(.red)
                                    }
                                case .shared:
                                    Group {
                                        Button("Unshare") { Task { await viewModel.unshareArtwork(artwork) } }
                                        .foregroundStyle(.red)
                                    }
                                case .activeCompetition:
                                    Group {
                                        Button("Submit") { Task { await viewModel.submitArtwork(artwork)} }
                                        .foregroundStyle(.green)
                                    }
                                case .archived:
                                    EmptyView()
                                case .scoring:
                                    EmptyView()
                                }
                                
                            }
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .padding()
                        }
                    }
                    
                }
                
            }
        }
    }
}
