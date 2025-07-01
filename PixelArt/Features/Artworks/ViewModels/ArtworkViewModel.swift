//
//  ArtworkViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import Foundation

final class ArtworkViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var personalArtworks: [Artwork] = []
    @Published var sharedArtworks: [Artwork] = []
    @Published var activeCompetitionArtworks: [Artwork] = []
    @Published var archivedArtworks: [Artwork] = []
    @Published var error: Error?
    
    /*
     NSError(
         domain: "Test",
         code: 999,
         userInfo: [NSLocalizedDescriptionKey: "Bu bir test hatasıdır."]
     )
     */
    
    private let repository: ArtworkRepository
    private let userId: String
    
    init(repository: ArtworkRepository = FirestoreArtworkRepository(), userId: String = "user1") {
        self.repository = repository
        self.userId = userId
    }
    
    func loadUserArtworks() async {
        isLoading = true
        error = nil
        
//      Basic Error Test
        /*
        self.error = NSError(
            domain: "com.pixelart",
            code: 500,
            userInfo: [NSLocalizedDescriptionKey: "Sunucuya bağlanılamadı."]
        )
        */
        
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
    
    func retry() {
        Task {
            await loadUserArtworks()
        }
    }
    
}
