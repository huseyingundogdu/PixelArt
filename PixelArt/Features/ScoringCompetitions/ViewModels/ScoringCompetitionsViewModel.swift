//
//  ScoringCompetitionsViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import Foundation

final class ScoringCompetitionsViewModel: ObservableObject {
    @Published var state: LoadingState<[Competition]> = .none
    
    private let repository: CompetitionRepository
    
    init(repository: CompetitionRepository = FirestoreCompetitionRepository()) {
        self.repository = repository
    }
    
    func loadScoringCompetitions() async {
        state = .loading
        do {
            let competitions = try await repository.fetchScoringCompetitions()
            state = .success(competitions)
        } catch {
            state = .error(error)
        }
    }
    
    func retry() {
        Task {
            await loadScoringCompetitions()
        }
    }
}
