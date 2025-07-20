//
//  PastCompetitionsViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import Foundation

final class PastCompetitionsViewModel: ObservableObject {
    
    @Published var state: LoadingState<[Competition]> = .none
    
    private let competitionService: CompetitionService
    private weak var appState: AppState?
    
    init(
        appState: AppState,
        competitionService: CompetitionService = DefaultCompetitionService()
    ) {
        self.appState = appState
        self.competitionService = competitionService
    }
    
    func loadPastCompetitions() async {
        state = .loading
        do {
            let pastCompetitions = try await competitionService.fetchPastCompetitions()
            state = .success(pastCompetitions)
        } catch {
            state = .error(error)
        }
    }
    
    func retry() async {
        await loadPastCompetitions()
    }
}
