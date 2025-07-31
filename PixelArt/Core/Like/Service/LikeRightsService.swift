//
//  LikeRightsService.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 27/07/2025.
//

import Foundation


final class LikeRightsService {
    
    private let repository: FirestoreLikeRightsRepository
    
    init(
        repository: FirestoreLikeRightsRepository = FirestoreLikeRightsRepository()
    ) {
        self.repository = repository
    }
    
    func fetchLikeRightsCount(competitionId: String, userId: String) async throws -> LikeRights? {
        return try await repository.fetchUserRights(competitionId: competitionId, userId: userId)
    }
    
//    func incrementUsedRights(for competitionId: String, userId: String) async throws {
//        try await repository.incrementUsedRights(for: competitionId, userId: userId)
//    }
//    
//    func decrementUsedRights(for competitionId: String, userId: String) async throws {
//        try await repository.decrementUsedRights(for: competitionId, userId: userId)
//    }
}
