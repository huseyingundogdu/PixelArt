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
    
    @Published var selectedOperation: Operation = .draw
    @Published var selectedColor: String = "#FFFFFF"
    @Published var profileImage: AppUser?
    
    private weak var appState: AppState?
    private let artworkService: ArtworkService
    private let userService: UserService
    private let authService: FirebaseAuthService
    private let likeService: DefaultLikeService
    
    init(
        appState: AppState,
        artworkService: ArtworkService = DefaultArtworkService(),
        userService: UserService = DefaultUserService(currentUserId: nil),
        authService: FirebaseAuthService = FirebaseAuthService(),
        likeService: DefaultLikeService = DefaultLikeService()
    ) {
        self.appState = appState
        self.artworkService = artworkService
        self.userService = userService
        self.authService = authService
        self.likeService = likeService
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
            
            var archivedUI: [ArtworkUIModel] = []
            for artwork in archivedArtworks {
                let likeCount = try await likeService.getLikeCount(artworkId: artwork.id)
                let uiArtwork = ArtworkUIModel(
                    id: artwork.id,
                    authorId: artwork.authorId,
                    authorUsername: artwork.authorUsername,
                    data: artwork.data,
                    competitionId: artwork.competitionId,
                    size: artwork.size,
                    topic: artwork.topic,
                    status: artwork.status,
                    lastUpdated: artwork.lastUpdated,
                    isSynced: true,
                    likeCount: likeCount
                )
                archivedUI.append(uiArtwork)
            }
            
            archivedUI.sort { $0.lastUpdated > $1.lastUpdated }
            
            state = .success(ProfileViewData(
                user: appUser,
                archived: archivedUI,
                shared: sharedArtworks,
                isFollowing: nil
            ))
        } catch {
            state = .error(error)
        }
    }
    
    func refresh() async {
        await load()
    }
    
//    func updatePixel(at index: Int, to color: String) {
//        guard let entity = entity else { return }
//        guard index >= 0 && index < hexData.count else { return }
//
//        hexData[index] = color
//        entity.setValue(hexData, forKey: "data")
//        entity.lastUpdated = .now
//        entity.isSynced = false
//        entity.syncOp = .update
//        CoreDataManager.shared.save()
//    }
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
