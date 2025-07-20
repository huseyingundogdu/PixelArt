//
//  CompetitionRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import Foundation

protocol CompetitionRepository {
    func fetchCompetitions(status: CompetitionStatus) async throws -> [Competition]
}
