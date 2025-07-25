//
//  AppState.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import Foundation
import FirebaseAuth

final class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User? = nil
    @Published var currentAppUser: AppUser? = nil
    @Published var authError: String? = nil
    @Published var isLoading: Bool = false
    
    private let authService: FirebaseAuthService
    var userService: UserService? = nil
    private let artworkService: OfflineFirstArtworkService
    
    init(
        authService: FirebaseAuthService = FirebaseAuthService(),
        artworkService: OfflineFirstArtworkService = OfflineFirstArtworkService()
    ) {
        self.authService = authService
        self.artworkService = artworkService
        checkAuthStatus()
    }
    
    private func checkAuthStatus() {
        if let user = authService.getCurrentUser() {
            currentUser = user
            isLoggedIn = true
            userService = DefaultUserService(currentUserId: user.uid)
            
            Task { await fetchCurrentAppUser() }
        } else {
            isLoggedIn = false
            currentUser = nil
            currentAppUser = nil
            UserDefaultsManager.shared.clear()
        }
    }
    
    @MainActor
    func fetchCurrentAppUser() async {
        guard let userService = userService else { return }
        do {
            let appUser = try await userService.getAppUser(uid: currentUser!.uid)
            self.currentAppUser = appUser
            
            //UserDefaults
            UserDefaultsManager.shared.setUser(id: appUser.id, username: appUser.username)
            
            await artworkService.syncIfNeeded()
            
        } catch {
            self.authError = error.localizedDescription
        }
    }
    
    func logOut() {
        isLoading = true
        do {
            try authService.signOut()
            self.currentUser = nil
            UserDefaultsManager.shared.clear()
            self.isLoggedIn = false
            self.authError = nil
        } catch {
            self.authError = error.localizedDescription
        }
        isLoading = false
    }
}
