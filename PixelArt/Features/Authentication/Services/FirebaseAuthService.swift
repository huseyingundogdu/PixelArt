//
//  FirebaseAuthRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 06/07/2025.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws -> User
    func signUp(email: String, password: String) async throws -> User
    func signOut() throws
    func getCurrentUser() -> User?
}

final class FirebaseAuthService: AuthServiceProtocol {
    func login(email: String, password: String) async throws -> User {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return result.user
    }
    
    func signUp(email: String, password: String) async throws -> User {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return result.user
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func getCurrentUser() -> FirebaseAuth.User? {
        return Auth.auth().currentUser
    }
    
    
}
