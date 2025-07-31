//
//  VotingViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 29/06/2025.
//

import Foundation
import SwiftUI

@MainActor
final class VotingViewModel: ObservableObject {
    @Published var state: LoadingState<[Artwork]> = .none    
    @Published var likeCounts: [String: Int] = [:]
    @Published var userLikedArtworkIds: Set<String> = []
    @Published var totalLike: Int = 0
    @Published var usedLike: Int = 0
    @Published var feedbackText: String = ""
    @Published var showFeedbackMessage: Bool = false
    
    private let competition: Competition
    private let artworkService: ArtworkService
    private let likeService: DefaultLikeService
    private let rightsService: LikeRightsService
    
    init(
        competition: Competition,
        artworkService: ArtworkService = DefaultArtworkService(),
        likeService: DefaultLikeService = DefaultLikeService(),
        rightsService: LikeRightsService = LikeRightsService()
    ) {
        self.competition = competition
        self.artworkService = artworkService
        self.likeService = likeService
        self.rightsService = rightsService
    }
    
//    func loadTotalRights(userId: String) async -> LikeRights? {
//        rightsService.fetchLikeRightsCount(competitionId: competitionId, userId: userId)
//    }
    
    func loadScoringArtworks() async {
        state = .loading
        
        guard let userId = UserDefaultsManager.shared.currentUserId else {
            state = .error(NSError(domain: "VotingVM", code: 401, userInfo: [NSLocalizedDescriptionKey: "You need to login - auth error"]))
            return
        }
        
        

        do {
            let artworks = try await artworkService.fetchCompetitionArtworks(competition.id)
            
            state = .success(artworks)
            
            if let totalRights = try await rightsService.fetchLikeRightsCount(competitionId: competition.id, userId: userId) {
                totalLike = totalRights.total
                usedLike = totalRights.used
            }
            
            for artwork in artworks {
                let hasLiked = try await likeService.hasLiked(artworkId: artwork.id, userId: userId)
                if hasLiked {
                    userLikedArtworkIds.insert(artwork.id)
                }
                let count = try await likeService.getLikeCount(artworkId: artwork.id)
                self.likeCounts[artwork.id] = count
            }
        } catch {
            state = .error(error)
        }
    }
    
    func toggleLike(for artwork: Artwork) async {
        guard let userId = UserDefaultsManager.shared.currentUserId else {
            state = .error(NSError(domain: "VotingVM", code: 401, userInfo: [NSLocalizedDescriptionKey: "You need to login - auth error"]))
            return
        }
        
        do {
            let hasLiked = try await likeService.hasLiked(artworkId: artwork.id, userId: userId)
            
            if hasLiked {
                try await likeService.unlikeArtwork(artworkId: artwork.id, competitionId: competition.id, userId: userId)
                userLikedArtworkIds.remove(artwork.id)
                self.likeCounts[artwork.id, default: 0] -= 1
                self.usedLike -= 1
            } else {
                if usedLike < totalLike {
                    try await likeService.likeArtwork(artworkId: artwork.id, competitionId: competition.id, userId: userId)
                    userLikedArtworkIds.insert(artwork.id)
                    self.likeCounts[artwork.id, default: 0] += 1
                    self.usedLike += 1
                } else {
                    showFeedback("You reached the like limit, you can not like more artwork.")
                }
            }
            
            
        } catch {
            state = .error(error)
        }
    }
    
    func showFeedback(_ feedback: String) {
        feedbackText = feedback
        withAnimation {
            showFeedbackMessage = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.showFeedbackMessage = false
            }
        }
    }
    
    func retry() {
        Task { await loadScoringArtworks() }
    }
}
