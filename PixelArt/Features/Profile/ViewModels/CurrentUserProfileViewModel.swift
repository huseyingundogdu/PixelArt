//
//  ProfileViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 07/07/2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class CurrentUserProfileViewModel: ObservableObject {
    
    @Published var state: LoadingState<ProfileViewData> = .none
    
    private weak var appState: AppState?
    private let artworkService: ArtworkService
    private let userService: UserService
    private let authService: FirebaseAuthService
    
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
    
    func load() async {
        guard let user = appState?.currentUser else {
            state = .error(NSError(domain: "Unauthorized", code: 401, userInfo: [NSLocalizedDescriptionKey: "Unauthorized - Please login first."]))
            return
        }
        
        state = .loading
        
        do {
            let appUser = try await userService.getAppUser(uid: user.uid)
            let archivedArtworks = try await artworkService.fetchArtworks(matching: [.authorId(user.uid), .status(.archived)])
            let sharedArtworks = try await artworkService.fetchArtworks(matching: [.authorId(user.uid), .status(.shared)])
            
            state = .success(ProfileViewData(
                user: appUser,
                archived: archivedArtworks,
                shared: sharedArtworks,
                isFollowing: nil
            ))
        } catch {
            state = .error(error)
        }
    }
    
//    func setUserAndLoad() async {
//        guard let user = appState?.currentUser else { return }
//        
//        isLoading = true
//        error = nil
//        
//        await loadUserInformation(userId: user.uid)
//        await loadUserArtworks(userUid: user.uid)
//        
//        isLoading = false
//    }
//    
//    private func loadUserInformation(userId: String) async {
//        async let user = userService.getAppUser(uid: userId)
//        do {
//            appUser = try await user
//        } catch {
//            self.error = error
//        }
//    }
//    
//    private func loadUserArtworks(userUid: String) async {
//        async let archived = artworkService.fetchArchived(for: userUid)
//        async let shared = artworkService.fetchShared(for: userUid)
//        
//        do {
//            archivedArtworks = try await archived
//            sharedArtworks = try await shared
//        } catch {
//            self.error = error
//        }
//    }
    
    func logOutButtonTapped() {
        appState?.logOut()
    }
}
