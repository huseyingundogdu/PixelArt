//
//  DefaultCompetitionService.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 18/07/2025.
//

import Foundation


final class DefaultCompetitionService: CompetitionService {
    
    private let repository: CompetitionRepository
    
    init(
        repository: CompetitionRepository = FirestoreCompetitionRepository()
    ) {
        self.repository = repository
    }
    
    func fetchActiveCompetitions() async throws -> [Competition] {
        try await repository.fetchCompetitions(status: .active)
    }
    
    func fetchPastCompetitions() async throws -> [Competition] {
        try await repository.fetchCompetitions(status: .past)
    }
    
    func fetchScoringCompetitions() async throws -> [Competition] {
        try await repository.fetchCompetitions(status: .scoring)
    }
    
    
}
