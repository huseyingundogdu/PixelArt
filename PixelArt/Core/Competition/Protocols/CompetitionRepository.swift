//
//  CompetitionRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import Foundation

protocol CompetitionRepository {
    func fetchActiveCompetition() async throws -> Competition
    func fetchScoringCompetitions() async throws -> [Competition]
    func fetchPastCompetitions() async throws -> [Competition]
}
