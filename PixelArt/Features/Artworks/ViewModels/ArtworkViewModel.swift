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
    
    private let repository: ArtworkRepository
    private var userId: String?
    
    init(repository: ArtworkRepository = FirestoreArtworkRepository()) {
        self.repository = repository
    }
    
    func setUserAndLoad(user: User) async {
        self.userId = user.uid
        await loadUserArtworks()
    }
    
    func loadUserArtworks() async {
        guard let userId else {
            self.error = NSError(domain: "no-user", code: 401, userInfo: [NSLocalizedDescriptionKey: "There is no auth."])
            return
        }
        
        isLoading = true
        error = nil
        
        async let personal = repository.fetchPersonalArtworks(forUserId: userId)
        async let shared = repository.fetchSharedArtworks(forUserId: userId)
        async let activeCompetition = repository.fetchActiveCompetitionArtworks(forUserId: userId)
        async let archived = repository.fetchArchivedArtworks(forUserId: userId)
        
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
        if let userId {
            await loadUserArtworks()
        }
    }
    
}
