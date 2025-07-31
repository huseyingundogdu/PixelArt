//
//  LikeService.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 27/07/2025.
//

import Foundation

final class DefaultLikeService {
    
    private let likeRepository: FirestoreLikeRepository
    private let rightsRepository: FirestoreLikeRightsRepository
    
    init(
        likeRepository: FirestoreLikeRepository = FirestoreLikeRepository(),
        rightsRepository: FirestoreLikeRightsRepository = FirestoreLikeRightsRepository()
    ) {
        self.likeRepository = likeRepository
        self.rightsRepository = rightsRepository
    }
    
    func likeArtwork(artworkId: String, competitionId: String, userId: String) async throws {
        guard let rights = try await rightsRepository.fetchUserRights(competitionId: competitionId, userId: userId) else {
            throw NSError(domain: "LikeService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Like rights not found"])
        }
        
        guard rights.used < rights.total else {
            throw NSError(domain: "LikeService", code: 403, userInfo: [NSLocalizedDescriptionKey: "Like limit reached"])

        }
        
        try await likeRepository.likeArtwork(artworkId: artworkId, userId: userId)
        try await rightsRepository.incrementUsedRights(for: competitionId, userId: userId)
    }
    
    func unlikeArtwork(artworkId: String, competitionId: String, userId: String) async throws {
        try await likeRepository.unlikeArtwork(artworkId: artworkId, userId: userId)
        try await rightsRepository.decrementUsedRights(for: competitionId, userId: userId)
    }
    
    func getLikeCount(artworkId: String) async throws -> Int {
        return try await likeRepository.fetchLikeCount(for: artworkId)
    }
    
    func hasLiked(artworkId: String, userId: String) async throws -> Bool {
        return try await likeRepository.hasUserLiked(artworkId: artworkId, userId: userId)
    }
}
