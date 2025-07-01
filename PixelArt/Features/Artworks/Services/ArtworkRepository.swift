//
//  ArtworkRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import Foundation

protocol ArtworkRepository {
    func fetchArtworks(by currentUserId: String) async throws -> [Artwork]
    func createArtwork(_ artwork: Artwork) async throws
    
    //MARK: - User-Based Artworks
    func fetchPersonalArtworks(forUserId userId: String) async throws -> [Artwork]
    func fetchSharedArtworks(forUserId userId: String) async throws -> [Artwork]
    func fetchActiveCompetitionArtworks(forUserId userId: String) async throws -> [Artwork]
    func fetchArchivedArtworks(forUserId userId: String) async throws -> [Artwork]
    
    //MARK: - Competition-based Artworks
    func fetchCompetitionArtworks(forCompetitionId competitionId: String) async throws -> [Artwork]
}

/*
case personal = "personal"
case shared = "shared"
case activeCompetition = "activeCompetition"
case archived = "archived"
*/
