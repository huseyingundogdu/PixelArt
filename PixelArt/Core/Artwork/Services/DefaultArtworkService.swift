//
//  DefaultArtworkService.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 18/07/2025.
//

import Foundation

final class DefaultArtworkService: ArtworkService {
    
    private let repository: ArtworkRepository
    
    init(
        repository: ArtworkRepository = FirestoreArtworkRepository()
    ) {
        self.repository = repository
    }
    
    func fetchArtworks(matching filters: [ArtworkFilter]) async throws -> [Artwork] {
        try await repository.fetchArtworks(matching: filters)
    }
    
    func fetchSubmittedArtworks(matching filters: [ArtworkFilter]) async throws -> [Artwork] {
        try await repository.fetchSubmittedArtworks(matching: filters)
    }
    
    
    func createArtwork(_ artwork: Artwork) async throws {
        try await repository.createArtwork(artwork)
    }
    
    
    func fetchArchived(for userId: String) async throws -> [Artwork] {
        try await fetchArtworks(matching: [
            .authorId(userId),
            .status(.archived)
        ])
    }
    
    func fetchPersonal(for userId: String) async throws -> [Artwork] {
        try await fetchArtworks(matching: [
            .authorId(userId),
            .status(.personal)
        ])
    }
    
    func fetchShared(for userId: String) async throws -> [Artwork] {
        try await fetchArtworks(matching: [
            .authorId(userId),
            .status(.shared)
        ])
    }
    
    func fetchActiveCompetition(for userId: String) async throws -> [Artwork] {
        try await fetchArtworks(matching: [
            .authorId(userId),
            .status(.activeCompetition)
        ])
    }
    
    func fetchCompetitionArtworks(_ id: String) async throws -> [Artwork] {
        try await fetchSubmittedArtworks(matching: [
            .competitionId(id),
            .status(.archived)
        ])
    }
    
    func fetchScoringArtworks(_ id: String) async throws -> [Artwork] {
        try await fetchArtworks(matching: [
            .competitionId(id),
            .status(.archived)
        ])
    }
    
}
