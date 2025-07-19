//
//  ArtworkViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import Foundation
import FirebaseAuth

final class ArtworkViewModel: ObservableObject {
    
    @Published var isLoading: Bool = true
    @Published var personalArtworks: [Artwork] = []
    @Published var sharedArtworks: [Artwork] = []
    @Published var activeCompetitionArtworks: [Artwork] = []
    @Published var archivedArtworks: [Artwork] = []
    @Published var error: Error?
    @Published var hasSizeError: Bool = false
    @Published var freeformArtworkTopic: String = ""
    @Published var width: Int = 0
    @Published var height: Int = 0
    @Published var isSizeLocked: Bool = false
    @Published var showCreateConfirmation: Bool = false
    
    private weak var appState: AppState?
    private let artworkService: ArtworkService
    private var currentUserId: String? {
        appState?.currentUser?.uid
    }
    
    init(
        appState: AppState,
        artworkService: ArtworkService = DefaultArtworkService()
    ) {
        self.appState = appState
        self.artworkService = artworkService
    }
    
    
    func loadUserArtworks() async {
        guard let currentUserId else {
            self.error = NSError(domain: "no-user", code: 401, userInfo: [NSLocalizedDescriptionKey: "There is no auth."])
            return
        }
        
        isLoading = true
        error = nil
        
        async let personal = try await artworkService.fetchPersonal(for: currentUserId)
        async let shared = try await artworkService.fetchShared(for: currentUserId)
        async let activeCompetition = try await artworkService.fetchActiveCompetition(for: currentUserId)
        async let archived = try await artworkService.fetchArchived(for: currentUserId)
        
        
        do {
            personalArtworks = try await personal
            sharedArtworks = try await shared
            activeCompetitionArtworks = try await activeCompetition
            archivedArtworks = try await archived

        } catch {
            self.error = error
        }
        isLoading = false
    }
    
    func retry() async {
        if let currentUserId {
            await loadUserArtworks()
        }
    }
    
    func createPersonalArtwork(width: Int, height: Int) async {
        guard let currentUserId else {
            self.error = NSError(domain: "no-user", code: 401, userInfo: [NSLocalizedDescriptionKey: "There is no auth."])
            return
        }
        
        guard width != 0 && height != 0 else {
            hasSizeError = true
            return
        }
        
        isLoading = true
        error = nil
        
        let artwork = Artwork(
            id: UUID().uuidString,
            authorId: currentUserId,
            data: createCanvasByGivenSize(size: isSizeLocked
                                          ? [width, width]
                                          : [width , height]),
            competitionId: nil,
            size: [width, height],
            topic: freeformArtworkTopic == "" ? "Empty Title" : freeformArtworkTopic,
            status: .personal
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
}
