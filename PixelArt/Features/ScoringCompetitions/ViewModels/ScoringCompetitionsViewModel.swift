//
//  ScoringCompetitionsViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import Foundation

@MainActor
final class ScoringCompetitionsViewModel: ObservableObject {
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
    
    func loadScoringCompetitions() async {
        state = .loading
        do {
            let competitions = try await competitionService.fetchScoringCompetitions()
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
