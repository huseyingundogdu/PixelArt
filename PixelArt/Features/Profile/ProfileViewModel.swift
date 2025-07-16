//
//  ProfileViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 07/07/2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class ProfileViewModel: ObservableObject {
    
    @Published var isLoading: Bool = true
    @Published var archivedArtworks: [Artwork] = []
    @Published var sharedArtworks: [Artwork] = []
    @Published var error: Error?
    
    private var user: User?
    private let repository: ArtworkRepository
    
    init(repository: ArtworkRepository = FirestoreArtworkRepository()) {
        self.repository = repository
    }
    
    func setUserAndLoad(user: User) async {
        self.user = user
        await loadUserArtworks(userUid: user.uid)
    }
    
    private func loadUserArtworks(userUid: String) async {
        isLoading = true
        error = nil
        
        async let archived = repository.fetchArchivedArtworks(forUserId: userUid)
        async let shared = repository.fetchSharedArtworks(forUserId: userUid)
        
        do {
            archivedArtworks = try await archived
            sharedArtworks = try await shared
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}
