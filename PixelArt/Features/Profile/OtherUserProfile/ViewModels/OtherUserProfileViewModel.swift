//
//  OtherUserProfileViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 19/07/2025.
//

import Foundation


final class OtherUserProfileViewModel: ObservableObject {
    
    @Published var state: LoadingState<OtherUserProfileData> = .none
        
    private weak var appState: AppState?
    private let artworkService: ArtworkService
    private let userService: UserService
        
    private let selectedUserId: String
    
    init(
        appState: AppState,
        artworkService: ArtworkService = DefaultArtworkService(),
        userService: UserService = DefaultUserService(currentUserId: nil),
        selectedUserId: String
    ) {
        self.appState = appState
        self.artworkService = artworkService
        self.userService = userService
        self.selectedUserId = selectedUserId
    }
    
    func load() async {
        state = .loading
            
        do {
            let appUser = try await loadSelectedUserInformation()
            let archivedArtworks = try await loadSelectedUserArchivedArtworks()
            let sharedArtworks = try await loadSelectedUserSharedArtworks()
            
            state = .success(OtherUserProfileData(user: appUser, archive: archivedArtworks, shared: sharedArtworks))
        } catch {
            state = .error(error)
        }
    }
    
    private func loadSelectedUserInformation() async throws -> AppUser {
        return try await userService.getAppUser(uid: selectedUserId)
    }
    
    private func loadSelectedUserSharedArtworks() async throws -> [Artwork] {
        return try await artworkService.fetchShared(for: selectedUserId)
    }
    
    private func loadSelectedUserArchivedArtworks() async throws -> [Artwork] {
        return try await artworkService.fetchArchived(for: selectedUserId)
    }
    
}

struct OtherUserProfileData: Codable, Equatable, Hashable {
    let user: AppUser
    let archive: [Artwork]
    let shared: [Artwork]
}
