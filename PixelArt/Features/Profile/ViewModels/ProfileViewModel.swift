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
    
    private weak var appState: AppState?
    private let artworkService: ArtworkService
    private let userService: UserService
    private let authService: FirebaseAuthService
    
    var currentUser: User? {
        appState?.currentUser
    }
    
    init(
        appState: AppState,
        artworkService: ArtworkService = DefaultArtworkService(),
        userService: UserService = DefaultUserService(currentUserId: nil),
        authService: FirebaseAuthService = FirebaseAuthService()
    ) {
        self.appState = appState
        self.artworkService = artworkService
        self.userService = userService
        self.authService = authService
    }
    
    func setUserAndLoad() async {
        guard let user = appState?.currentUser else { return }
        await loadUserArtworks(userUid: user.uid)
    }
    
    private func loadUserArtworks(userUid: String) async {
        isLoading = true
        error = nil
        
        async let archived = artworkService.fetchArchived(for: userUid)
        async let shared = artworkService.fetchShared(for: userUid)
        
        do {
            archivedArtworks = try await archived
            sharedArtworks = try await shared
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func logOutButtonTapped() {
        appState?.logOut()
    }
}
