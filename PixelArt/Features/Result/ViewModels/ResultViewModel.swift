//
//  ResultViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 04/07/2025.
//

import Foundation


final class ResultViewModel: ObservableObject {
    
    @Published var state: LoadingState<[Artwork]> = .none
    
    private let competition: Competition
    private let repository: ArtworkRepository
    
    init(competition: Competition, repository: ArtworkRepository = FirestoreArtworkRepository()) {
        self.competition = competition
        self.repository = repository
    }
    
    func loadArchivedArtworks() async {
        state = .loading
        do {
            let archivedArtworks = try await repository.fetchCompetitionArtworks(forCompetitionId: self.competition.id)
            state = .success(archivedArtworks)
        } catch {
            state = .error(error)
        }
    }
    
    func retry() {
        Task { await loadArchivedArtworks() }
    }
}
