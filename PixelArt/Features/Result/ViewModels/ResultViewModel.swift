//
//  ResultViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 04/07/2025.
//

import Foundation

@MainActor
final class ResultViewModel: ObservableObject {
    
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
    
    func loadCompetitionArtworks() async {
        state = .loading
        do {
            let competitionArtworks = try await artworkService.fetchCompetitionArtworks(competition.id)
            state = .success(competitionArtworks)
        } catch {
            state = .error(error)
        }
    }
    
    func retry() {
        Task { await loadCompetitionArtworks() }
    }
}
