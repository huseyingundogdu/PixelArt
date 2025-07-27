//
//  ScoringCompetitionsViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import Foundation

@MainActor
final class ScoringCompetitionsViewModel: ObservableObject {
    @Published var state: LoadingState<[CompetitionWithLikeRights]> = .none
    
    private let competitionService: CompetitionService
    private let likeRightsService: LikeRightsService
    private weak var appState: AppState?
    
    init(
        appState: AppState,
        competitionService: CompetitionService = DefaultCompetitionService(),
        likeRightsService: LikeRightsService = LikeRightsService()
    ) {
        self.appState = appState
        self.competitionService = competitionService
        self.likeRightsService = likeRightsService
    }
    
    func loadScoringCompetitions() async {
        state = .loading
        
        guard let userId = UserDefaultsManager.shared.currentUserId else {
            state = .error(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        
        do {
            let competitions = try await competitionService.fetchScoringCompetitions()
            
            let enrichedCompetitions = try await withThrowingTaskGroup(of: CompetitionWithLikeRights.self) { group in
                for competition in competitions {
                    group.addTask {
                        let rights = try await self.likeRightsService.fetchLikeRightsCount(competitionId: competition.id, userId: userId)
                        return CompetitionWithLikeRights(competition: competition, likeRights: rights)
                    }
                }
                
                var result: [CompetitionWithLikeRights] = []
                for try await item in group {
                    result.append(item)
                }
                return result
            }
            
            let sorted = enrichedCompetitions.sorted {
                $0.competition.finishAt.dateValue() < $1.competition.finishAt.dateValue()
            }
            
            state = .success(sorted)
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


struct CompetitionWithLikeRights: Codable, Identifiable, Equatable {
    
    let competition: Competition
    let likeRights: LikeRights?
    
    var id: String {
        competition.id
    }
}
