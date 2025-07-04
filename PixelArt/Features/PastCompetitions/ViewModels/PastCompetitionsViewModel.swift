//
//  PastCompetitionsViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import Foundation

final class PastCompetitionsViewModel: ObservableObject {
    
    @Published var state: LoadingState<[Competition]> = .none
    
    private let repository: FirestoreCompetitionRepository
    
    init(repository: FirestoreCompetitionRepository = FirestoreCompetitionRepository()) {
        self.repository = repository
    }
    
    func loadPastCompetitions() async {
        state = .loading
        do {
            let pastCompetitions = try await repository.fetchPastCompetitions()
            state = .success(pastCompetitions)
        } catch {
            state = .error(error)
        }
    }
    
    func retry() async {
        await loadPastCompetitions()
    }
}
