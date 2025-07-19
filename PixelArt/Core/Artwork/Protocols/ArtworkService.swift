//
//  ArtworkService.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 18/07/2025.
//

import Foundation

protocol ArtworkService {    
    func fetchArtworks(matching filters: [ArtworkFilter]) async throws -> [Artwork]
    func fetchSubmittedArtworks(matching filters: [ArtworkFilter]) async throws -> [Artwork]
    
    func fetchArchived(for userId: String) async throws -> [Artwork]
    func fetchPersonal(for userId: String) async throws -> [Artwork]
    func fetchShared(for userId: String) async throws -> [Artwork]
    func fetchActiveCompetition(for userId: String) async throws -> [Artwork]
    
    func fetchCompetitionArtworks(_ id: String) async throws -> [Artwork]
    func fetchScoringArtworks(_ id: String) async throws -> [Artwork]
    
    func createArtwork(_ artwork: Artwork) async throws
    
    
}
