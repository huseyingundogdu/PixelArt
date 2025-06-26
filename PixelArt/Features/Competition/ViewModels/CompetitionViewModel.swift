//
//  CompetitionViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 19/05/2025.
//

import Foundation

final class CompetitionViewModel: ObservableObject {
    
    @Published var state: LoadingState<Competition> = .none
    
    private let repository: CompetitionRepository
    
    init(repository: CompetitionRepository = FirestoreCompetitionRepository()) {
        self.repository = repository
    }
    
    func loadActiveCompetition() async {
        state = .loading
        do {
            let competition = try await repository.fetchActiveCompetition()
            state = .success(competition)
        } catch {
            state = .error(error)
        }
    }
    
    func retry() {
        Task {
            await loadActiveCompetition()
        }
    }

}
