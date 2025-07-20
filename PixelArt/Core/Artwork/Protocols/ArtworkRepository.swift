//
//  ArtworkRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import Foundation

protocol ArtworkRepository {
    func fetchArtworks(matching filters: [ArtworkFilter]) async throws -> [Artwork]
    func fetchSubmittedArtworks(matching filters: [ArtworkFilter]) async throws -> [Artwork]
    func createArtwork(_ artwork: Artwork) async throws
    
    
}
