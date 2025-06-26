//
//  CompetitionRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import Foundation

protocol CompetitionRepository {
    func fetchActiveCompetition() async throws -> Competition
    func createEmptyArtworkRelatedToCompetition(currentUserId: String, currentCompetition: Competition) async throws
    func isUserAlreadyCreatedArtworkRelatedToCurrentCompetition(currentUserId: String, currentCompetition: Competition) async throws -> Bool
}
