//
//  JoinButtonViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 25/06/2025.
//

import Foundation

enum JoinButtonState {
    case idle
    case loading
    case joined
    case error(String)
}

final class JoinButtonViewModel: ObservableObject {
    
    @Published var state: JoinButtonState = .idle
    
    private let repository: ArtworkRepository
    private let userId: String
    private let competition: Competition
    
    init(repository: ArtworkRepository = FirestoreArtworkRepository(), userId: String, competition: Competition) {
        self.repository = repository
        self.userId = userId
        self.competition = competition
    }
 
    func checkIfUserAlreadyJoined() async {
        guard case .idle = state else { return }
        
        state = .loading
        
        do {
            let artworks = try await repository.fetchArtworks(by: userId)

            if artworks.contains(where: { $0.competitionId == competition.id }) {
                state = .joined
            } else {
                state = .idle
            }
        } catch {
            print("Error checking join status: \(error)")
            state = .error(error.localizedDescription)
        }
    }
    
    func joinCompetitionIfNeeded() async {
        guard case .idle = state else { return }
        
        state = .loading
        
        let artwork = Artwork(
            id: UUID().uuidString,
            authorId: userId,
            data: createEmptyCanvas(size: competition.size),
            competitionId: competition.id,
            size: competition.size,
            topic: competition.topic,
            status: .activeCompetition
        )
        
        do {
            try await repository.createArtwork(artwork)
            state = .joined
        } catch {
            print("Error creating artwork: \(error)")
            state = .error(error.localizedDescription)
        }
    }
    
    private func createEmptyCanvas(size: [Int]) -> [String] {
        let total = size[0] * size[1]
        return Array(repeating: "ffffff", count: total)
    }
    
}
