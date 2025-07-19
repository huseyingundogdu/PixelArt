//
//  SignupViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 18/07/2025.
//

import Foundation


final class SignupViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var username: String = ""
    @Published var password: String = ""

    private let authService: FirebaseAuthService // change to protocol
    private let userService: UserService
    private let appState: AppState
    
    init(
        authService: FirebaseAuthService = FirebaseAuthService(),
        userService: UserService = DefaultUserService(currentUserId: nil),
        appState: AppState
    ) {
        self.userService = userService
        self.authService = authService
        self.appState = appState
    }
    
    func signUp() async {
        await MainActor.run { appState.isLoading = true }
        
        do {
            let user = try await authService.signUp(email: email, password: password)
            try await userService.registerNewUser(firebaseUid: user.uid, email: email, username: username)
            await MainActor.run {
                appState.currentUser = user
                appState.isLoggedIn = true
                appState.authError = nil
                appState.isLoading = false
            }
        } catch {
            await MainActor.run {
                appState.authError = error.localizedDescription
                appState.isLoading = false
            }
        }
        
    }
}
