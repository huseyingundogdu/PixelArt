//
//  CompetitionService.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 18/07/2025.
//

import Foundation

protocol CompetitionService {
    func fetchActiveCompetitions() async throws -> [Competition]
    func fetchPastCompetitions() async throws -> [Competition]
    func fetchScoringCompetitions() async throws -> [Competition]
}
