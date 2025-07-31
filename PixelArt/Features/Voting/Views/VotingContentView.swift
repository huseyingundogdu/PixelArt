//
//  VotingContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 29/06/2025.
//

import SwiftUI

struct VotingContentView: View {
    @EnvironmentObject private var router: NavigationRouter

    @ObservedObject var viewModel: VotingViewModel
    
    let competition: Competition
    let artworks: [Artwork]
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                Text(competition.topic)
                    .font(.Micro5.xxLarge)
                Text("\(competition.size[0]) x \(competition.size[1])")
                    .font(.Micro5.large)
                
                HStack {
                    Text("Artworks")
                        .font(.Micro5.medium)
                        .lineLimit(1)
                        .layoutPriority(1)
                    
                    Rectangle()
                        .frame(height: 2)
                }
                .padding()
                
                ScrollView {
                    ForEach(artworks, id: \.self) { artwork in
                        HStack(alignment: .center) {
                            PixelGridView(
                                data: artwork.data,
                                columns: artwork.size[0],
                                rows: artwork.size[1],
                                availableWidth: K.Artwork.Size.regular.width,
                                availableHeight: K.Artwork.Size.regular.height
                            )
                            
                            HStack {
                                Button {
                                    router.competitionRoutes.append(.userProfile(userId: artwork.authorId))
                                } label: {
                                    Text(artwork.authorUsername)
                                }
                                .foregroundStyle(.black)
                                
                                Spacer()
                                
                                Text("\(viewModel.likeCounts[artwork.id, default: 0])")
                                
                                Button {
                                    Task { await viewModel.toggleLike(for: artwork) }
                                } label: {
                                    Image(
                                        viewModel.userLikedArtworkIds.contains(artwork.id)
                                        ? "ic_heart_fill"
                                        : "ic_heart"
                                    )
                                    .interpolation(.none)
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .animation(.easeInOut, value: viewModel.userLikedArtworkIds.contains(artwork.id))
                                    
                                }
                                .foregroundStyle(.black)
                            }
                            
                            Spacer()
                            
                        }
                        .padding(.horizontal)
                    }
                }
                .scrollIndicators(.hidden)
                .frame(maxWidth: .infinity)
            }
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
    }
}

//#Preview {
//    VotingContentView(competition: MockData.competition, artworks: MockData.artworks)
//        .font(.Micro5.small)
//}
