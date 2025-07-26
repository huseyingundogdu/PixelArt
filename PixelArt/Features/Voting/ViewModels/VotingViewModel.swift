//
//  VotingViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 29/06/2025.
//

import Foundation

@MainActor
final class VotingViewModel: ObservableObject {
    @Published var state: LoadingState<[Artwork]> = .none    
    
    private let competition: Competition
    private let artworkService: ArtworkService
    
    init(
        competition: Competition,
        artworkService: ArtworkService = DefaultArtworkService()
    ) {
        self.competition = competition
        self.artworkService = artworkService
    }
    
    func loadScoringArtworks() async {
        state = .loading
        do {
            let artworks = try await artworkService.fetchCompetitionArtworks(competition.id)
            state = .success(artworks)
        } catch {
            state = .error(error)
        }
    }
    
    func retry() {
        Task { await loadScoringArtworks() }
    }
}
