//
//  LoginViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 18/07/2025.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var authError: String?
    @Published var isLoading: Bool = false
    
    private let authService: FirebaseAuthService
    private let appState: AppState
    
    init(
        authService: FirebaseAuthService = FirebaseAuthService(),
        appState: AppState
    ) {
        self.authService = authService
        self.appState = appState
    }
    
    func login() async {
        isLoading = true
        do {
            let user = try await authService.login(email: email, password: password)
                self.appState.currentUser = user
                self.appState.isLoggedIn = true
                authError = nil
                isLoading = false
        } catch {
            authError = error.localizedDescription
            isLoading = false
            
        }
    }
}
