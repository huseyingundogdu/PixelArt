//
//  MockArtworkRepository.swift
//  PixelArtTests
//
//  Created by Hüseyin Gündoğdu on 02/07/2025.
//

import Foundation
@testable import PixelArt


final class MockArtworkRepository: ArtworkRepository {

    var personalArtworksShouldReturn: [Artwork] = []
    var sharedArtworksShouldReturn: [Artwork] = []
    var activeCompetitionArtworksShouldReturn: [Artwork] = []
    var archivedArtworksShouldReturn: [Artwork] = []
    var shouldThrowError: Bool = false
    
    
    func fetchPersonalArtworks(forUserId userId: String) async throws -> [PixelArt.Artwork] {
        if shouldThrowError { throw URLError(.badServerResponse) }
        return personalArtworksShouldReturn
    }
    
    func fetchSharedArtworks(forUserId userId: String) async throws -> [PixelArt.Artwork] {
        if shouldThrowError { throw URLError(.badServerResponse) }
        return sharedArtworksShouldReturn
    }
    
    func fetchActiveCompetitionArtworks(forUserId userId: String) async throws -> [PixelArt.Artwork] {
        if shouldThrowError { throw URLError(.badServerResponse) }
        return activeCompetitionArtworksShouldReturn
    }
    
    func fetchArchivedArtworks(forUserId userId: String) async throws -> [PixelArt.Artwork] {
        if shouldThrowError { throw URLError(.badServerResponse) }
        return archivedArtworksShouldReturn
    }
    
    func fetchArtworks(by currentUserId: String) async throws -> [PixelArt.Artwork] { [] }
    func createArtwork(_ artwork: PixelArt.Artwork) async throws {}
    func fetchCompetitionArtworks(forCompetitionId competitionId: String) async throws -> [PixelArt.Artwork] { [] }
}
