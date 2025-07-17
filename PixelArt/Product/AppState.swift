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
    private let userService: FirebaseUserService
    
    init(
        authService: FirebaseAuthService = FirebaseAuthService(),
        userService: FirebaseUserService = FirebaseUserService()
    ) {
        self.authService = authService
        self.userService = userService
        checkAuthStatus()
    }
    
    func login(email: String, password: String) async {
        DispatchQueue.main.async { self.isLoading = true }
        do {
            let user = try await authService.login(email: email, password: password)
            DispatchQueue.main.async {
                self.currentUser = user
                self.isLoggedIn = true
                self.authError = nil
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.authError = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func register(email: String, username: String, password: String) async {
        DispatchQueue.main.async { self.isLoading = true }
        do {
            let user = try await authService.signUp(email: email, password: password)
            
            try await userService.createUserDocument(user: user, username: username)
            
            DispatchQueue.main.async {
                self.currentUser = user
                self.isLoggedIn = true
                self.authError = nil
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.authError = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func logOut() {
        do {
            try authService.signOut()
            DispatchQueue.main.async {
                self.currentUser = nil
                self.isLoggedIn = false
                self.authError = nil
            }
        } catch {
            print("Logout failed: \(error)")
        }
    }
    
    private func checkAuthStatus() {
        if let user = authService.getCurrentUser() {
            currentUser = user
            isLoggedIn = true
        }
    }
}
