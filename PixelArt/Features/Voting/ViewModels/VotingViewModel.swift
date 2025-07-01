//
//  VotingViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 29/06/2025.
//

import Foundation

final class VotingViewModel: ObservableObject {
    @Published var state: LoadingState<[Artwork]> = .none    
    
    private let competition: Competition
    private let artworkRepository: ArtworkRepository
    
    init(competition: Competition, artworkRepository: ArtworkRepository = FirestoreArtworkRepository()) {
        self.competition = competition
        self.artworkRepository = artworkRepository
    }
    
    func loadArtworks() async {
        state = .loading
        do {
            let artworks = try await artworkRepository.fetchCompetitionArtworks(forCompetitionId: self.competition.id)
            state = .success(artworks)
        } catch {
            state = .error(error)
        }
    }
    
    func retry() {
        Task {
            await loadArtworks()
        }
    }
}
