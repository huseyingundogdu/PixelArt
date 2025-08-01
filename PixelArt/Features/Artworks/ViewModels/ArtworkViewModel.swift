//
//  ArtworkViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import Foundation
import SwiftUI
import FirebaseAuth

@MainActor
final class ArtworkViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var personalArtworks: [ArtworkUIModel] = []
    @Published var sharedArtworks: [ArtworkUIModel] = []
    @Published var activeCompetitionArtworks: [ArtworkUIModel] = []
    @Published var archivedArtworks: [ArtworkUIModel] = []
    @Published var error: Error?
    @Published var hasSizeError: Bool = false
    @Published var freeformArtworkTopic: String = ""
    @Published var width: Int = 0
    @Published var height: Int = 0
    @Published var isSizeLocked: Bool = false
    @Published var showCreateConfirmation: Bool = false
    @Published var selectedArtwork: ArtworkUIModel? = nil
    
    private weak var appState: AppState?
    private let artworkService: OfflineFirstArtworkService
    private var currentUserId: String? {
        appState?.currentUser?.uid
    }
    
    init(
        appState: AppState,
        artworkService: OfflineFirstArtworkService = OfflineFirstArtworkService()
    ) {
        self.appState = appState
        self.artworkService = artworkService
    }
    
    
    func loadUserArtworks() async {
        isLoading = true
        error = nil
        
        guard let userId = UserDefaultsManager.shared.currentUserId else {
            self.error = NSError(domain: "no-user", code: 401, userInfo: [NSLocalizedDescriptionKey: "There is no auth."])
            return
        }
        
        
        
//        await syncIfNeeded()
        async let artworks = try await artworkService.fetchArtworks(authorId: userId)
        
        
        /*
        async let personal = try await artworkService.fetchPersonal(for: currentUserId)
        async let shared = try await artworkService.fetchShared(for: currentUserId)
        async let activeCompetition = try await artworkService.fetchActiveCompetition(for: currentUserId)
        async let archived = try await artworkService.fetchArchived(for: currentUserId)
        */
        
        do {
            personalArtworks = try await artworks.filter { $0.status == .personal }
            sharedArtworks = try await artworks.filter { $0.status == .shared }
            activeCompetitionArtworks = try await artworks.filter { $0.status == .activeCompetition }
            archivedArtworks = try await artworks.filter { $0.status == .archived }

        } catch {
            self.error = error
        }
        isLoading = false
    }
    
    func retry() async {
        await loadUserArtworks()
    }
    
    func createArtwork(width: Int, height: Int) async {
        guard
            let userId = UserDefaultsManager.shared.currentUserId,
            let username = UserDefaultsManager.shared.currentUserUsername
        else {
            self.error = NSError(domain: "auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in."])
            return
        }
        
        let newArtwork = Artwork(
            id: UUID().uuidString,
            authorId: userId,
            authorUsername: username,
            data: createCanvasByGivenSize(size: [width, height]),
            competitionId: nil,
            size: [width, height],
            topic: freeformArtworkTopic,
            status: .personal,
            lastUpdated: .now
        )
        
        do {
            try await artworkService.createArtwork(newArtwork)
            await refreshArtworks()
        } catch {
            self.error = error
        }
    }
    
    func refreshArtworks() async {
        await loadUserArtworks()
    }
    
    func createPersonalArtwork(width: Int, height: Int) async {
        guard let appUser = appState?.currentAppUser else {
            self.error = NSError(domain: "no-user", code: 401, userInfo: [NSLocalizedDescriptionKey: "There is no auth."])
            return
        }
        
        guard width != 0 && height != 0 else {
            hasSizeError = true
            return
        }
        
        isLoading = true
        error = nil
        
        if freeformArtworkTopic == "" {
            freeformArtworkTopic = "Empty Title"
        }
        
        let artwork = Artwork(
            id: UUID().uuidString,
            authorId: appUser.id,
            authorUsername: appUser.username,
            data: createCanvasByGivenSize(size: isSizeLocked
                                          ? [width, width]
                                          : [width , height]),
            competitionId: nil,
            size: [width, height],
            topic: freeformArtworkTopic,
            status: .personal,
            lastUpdated: .now
        )
        
        do {
            try await artworkService.createArtwork(artwork)
        } catch {
            self.error = error
        }
        
        clearCreateArtworkInputs()
        await retry()
    }
    
    private func createCanvasByGivenSize(size: [Int]) -> [String] {
        let total = size[0] * size[1]
        return Array(repeating: "ffffff", count: total)
    }
    
    private func clearCreateArtworkInputs() {
        freeformArtworkTopic = ""
        width = 0
        height = 0
        isSizeLocked = false
        hasSizeError = false
    }
    
    //MARK: - Content/Section
    @Published var feedbackText: String = ""
    @Published var showFeedbackMessage: Bool = false
    @Published var expandedArtworkIds: Set<String> = []
    @Published var editPresented: Bool = false
    @Published var newTitle: String = ""
    @Published var editingArtwork: ArtworkUIModel?
    
    func toggleExpansion(for artwork: ArtworkUIModel) {
        if expandedArtworkIds.contains(artwork.id) {
            expandedArtworkIds.remove(artwork.id)
        } else {
            expandedArtworkIds.insert(artwork.id)
        }
    }
    
    func showFeedback(_ feedback: FeedbackSituation) {
        feedbackText = feedback.rawValue
        withAnimation {
            showFeedbackMessage = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.showFeedbackMessage = false
            }
        }
    }

    func shareArtwork(_ artwork: ArtworkUIModel) async {
        var domainArtwork = artwork.toDomainModel()
        domainArtwork.status = .shared
        
        do {
            try await artworkService.updateArtwork(artwork: domainArtwork, title: domainArtwork.topic)
            await refreshArtworks()
        } catch {
            self.error = error
        }
    }
    func unshareArtwork(_ artwork: ArtworkUIModel) async { 
        var domainArtwork = artwork.toDomainModel()
        domainArtwork.status = .personal
        
        do {
            try await artworkService.updateArtwork(artwork: domainArtwork, title: domainArtwork.topic)
            await refreshArtworks()
        } catch {
            self.error = error
        }
    }
    func deleteArtwork(_ artwork: ArtworkUIModel) async {
        do {
            try await artworkService.deleteArtwork(id: artwork.id)
            await refreshArtworks()
        } catch {
            self.error = error
        }
    }
    func editArtwork(_ artwork: ArtworkUIModel, title: String) async { 
        do {
            let domainArtwork = artwork.toDomainModel()
            try await artworkService.updateArtwork(artwork: domainArtwork, title: title)
            await refreshArtworks()
        } catch {
            self.error = error
        }
    }
    func submitArtwork(_ artwork: ArtworkUIModel) async { 
        var domainArtwork = artwork.toDomainModel()
        domainArtwork.status = .scoring
        
        do {
            try await artworkService.updateArtwork(artwork: domainArtwork, title: domainArtwork.topic)
            await refreshArtworks()
        } catch {
            self.error = error
        }
    }
}


enum FeedbackSituation: String {
    case canNotDraw = "You can only draw personal or active competition artworks."
    case noInternet = "You need to access internet for this operation."
}
