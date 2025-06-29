//
//  ArtworkRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import Foundation

protocol ArtworkRepository {
    func fetchArtworks(by currentUserId: String) async throws -> [Artwork]
    func fetchCompetitionArtworks(competitionId: String) async throws -> [Artwork]
    func createArtwork(_ artwork: Artwork) async throws
}
