//
//  ResultViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 04/07/2025.
//

import Foundation

@MainActor
final class ResultViewModel: ObservableObject {
    
    @Published var state: LoadingState<[ArtworkUIModel]> = .none
    @Published var uiArtworks: [ArtworkUIModel] = []
    
    private let competition: Competition
    private let artworkService: ArtworkService
    private let likeService: DefaultLikeService
    
    init(
        competition: Competition,
        artworkService: ArtworkService = DefaultArtworkService(),
        likeService: DefaultLikeService = DefaultLikeService()
    ) {
        self.competition = competition
        self.artworkService = artworkService
        self.likeService = likeService
    }
    
    func loadCompetitionArtworks() async {
        state = .loading
        do {
            let competitionArtworks = try await artworkService.fetchCompetitionResultArtworks(competition.id)
            
            var enrichedArtworks: [ArtworkUIModel] = []
            
            for artwork in competitionArtworks {
                let likeCount = try await likeService.getLikeCount(artworkId: artwork.id)
                let uiModel = ArtworkUIModel(
                    id: artwork.id,
                    authorId: artwork.authorId,
                    authorUsername: artwork.authorUsername,
                    data: artwork.data,
                    competitionId: artwork.competitionId,
                    size: artwork.size,
                    topic: artwork.topic,
                    status: artwork.status,
                    lastUpdated: artwork.lastUpdated, isSynced: true,
                    likeCount: likeCount
                )
                enrichedArtworks.append(uiModel)
            }
            uiArtworks = enrichedArtworks
            
            enrichedArtworks.sort { $0.likeCount ?? 0 > $1.likeCount ?? 0 }
            print(enrichedArtworks)
            state = .success(enrichedArtworks)
        } catch {
            state = .error(error)
        }
    }
    
    func retry() {
        Task { await loadCompetitionArtworks() }
    }
}
