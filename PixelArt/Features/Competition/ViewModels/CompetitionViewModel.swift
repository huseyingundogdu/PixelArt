//
//  CompetitionViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 19/05/2025.
//

import Foundation

@MainActor
final class CompetitionViewModel: ObservableObject {
    
    @Published var state: LoadingState<Competition> = .none
    
    @Published var joinState: JoinButtonState = .idle
    @Published var showJoinConfirmation = false
    
    private let competitionService: CompetitionService
    private let artworkService: ArtworkService
    private weak var appState: AppState?
    
    private var currentUserId: String? {
        appState?.currentUser?.uid
    }
    
    init(
        appState: AppState,
        competitionService: CompetitionService = DefaultCompetitionService(),
        artworkService: ArtworkService = DefaultArtworkService()
    ) {
        self.appState = appState
        self.competitionService = competitionService
        self.artworkService = artworkService
    }
    
    func loadActiveCompetition() async {
        state = .loading
        do {
            let competitions = try await competitionService.fetchActiveCompetitions()
            //FIXME: Simdilik 1. item i alicaz
            state = .success(competitions[0])
            
        } catch {
            state = .error(error)
        }
    }
    
    func retry() {
        Task {
            await loadActiveCompetition()
        }
    }
    
    
    func checkIfUserAlreadyJoined(_ competition: Competition) async {
        guard let user = appState?.currentUser else {
            joinState = .error("Auth Error")
            return
        }
        
        do {
            let artworks = try await artworkService.fetchActiveCompetition(for: user.uid)
            if artworks.contains(where: {$0.competitionId == competition.id }) {
                joinState = .joined
            } else {
                joinState = .idle
            }
        } catch {
            joinState = .error(error.localizedDescription)
        }
    }
    
    func joinCurrentCompetition(_ competition: Competition) async {
        guard joinState == .idle else { return }
        guard let appUser = appState?.currentAppUser else {
            joinState = .error("Auth error.")
            return
        }
        
        joinState = .loading
        
        let artwork = Artwork(
            id: UUID().uuidString,
            authorId: appUser.id,
            authorUsername: appUser.username,
            data: Array(repeating: "ffffff", count: competition.size[0] * competition.size[1]),
            colorPalette: competition.colorPalette,
            competitionId: competition.id,
            size: competition.size,
            topic: competition.topic,
            status: .activeCompetition,
            lastUpdated: .now
        )
        
        do {
            try await artworkService.createArtwork(artwork)
            joinState = .joined
        } catch {
            joinState = .error(error.localizedDescription)
        }
    }

}
