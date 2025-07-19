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
    @Published var authError: String? = nil
    @Published var isLoading: Bool = false
    
    private let authService: FirebaseAuthService
    
    init(authService: FirebaseAuthService = FirebaseAuthService()) {
        self.authService = authService
        checkAuthStatus()
    }
    
    private func checkAuthStatus() {
        if let user = authService.getCurrentUser() {
            currentUser = user
            isLoggedIn = true
        }
    }
    
    func logOut() {
        isLoading = true
        do {
            try authService.signOut()
            self.currentUser = nil
            self.isLoggedIn = false
            self.authError = nil
        } catch {
            self.authError = error.localizedDescription
        }
        isLoading = false
    }
}
