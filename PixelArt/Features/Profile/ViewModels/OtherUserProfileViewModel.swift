//
//  OtherUserProfileViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 19/07/2025.
//

import Foundation

@MainActor
final class OtherUserProfileViewModel: ObservableObject {
    
    @Published var state: LoadingState<ProfileViewData> = .none
    
    @Published var error: Error? = nil
    @Published var isFollowing: Bool? = nil
    
    private weak var appState: AppState?
    private let artworkService: ArtworkService
    private let userService: UserService
    private let followService: FollowService
        
    private let selectedUserId: String
    
    init(
        appState: AppState,
        artworkService: ArtworkService = DefaultArtworkService(),
        userService: UserService = DefaultUserService(currentUserId: nil),
        followService: FollowService,
        selectedUserId: String
    ) {
        self.appState = appState
        self.artworkService = artworkService
        self.userService = userService
        self.followService = followService
        self.selectedUserId = selectedUserId
    }
    
    func load() async {
        state = .loading
            
        do {
            let appUser = try await loadSelectedUserInformation()
            let archivedArtworks = try await loadSelectedUserArchivedArtworks()
            let sharedArtworks = try await loadSelectedUserSharedArtworks()
            isFollowing = try await isFollowing()
            
            state = .success(ProfileViewData(user: appUser, archived: archivedArtworks, shared: sharedArtworks, isFollowing: isFollowing))
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
    
    func isOwnProfile() -> Bool {
        return appState?.currentUser?.uid == selectedUserId
    }
    
    func isFollowing() async throws -> Bool {
        guard let currentUser = appState?.currentUser else {
            throw NSError(domain: "Unauthorized", code: 401, userInfo: [NSLocalizedDescriptionKey: "Unauthorized - Please login first."])
        }
        
        return try await followService.isFollowing(followerId: currentUser.uid, followedId: selectedUserId)
    }
    
    func toggleFollow() async {
        guard let currentUser = appState?.currentUser else { return }
            
        do {
            let isFollowing = try await followService.isFollowing(followerId: currentUser.uid, followedId: selectedUserId)
            
            if isFollowing {
                try await followService.unfollow(followerId: currentUser.uid, followedId: selectedUserId)
                self.isFollowing = false
            } else {
                try await followService.follow(followerId: currentUser.uid, followedId: selectedUserId)
                self.isFollowing = true
            }
            
        } catch {
            self.error = error
            print(error.localizedDescription)
        }
        
        
    }
}


