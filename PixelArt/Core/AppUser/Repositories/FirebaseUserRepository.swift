//
//  FirebaseUserRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 17/07/2025.
//

import Foundation
import FirebaseFirestore

final class FirebaseUserRepository: UserRepository {
    
    private let db = Firestore.firestore()
    
    func fetchAppUser(uid: String) async throws -> AppUser {
        let doc = try await db.collection("users")
            .document(uid)
            .getDocument()
        
        return try doc.data(as: AppUser.self)
    }
    
    func createAppUser(_ user: AppUser) async throws {
        try db.collection("users")
            .document(user.id)
            .setData(from: user)
    }
    
    func updateAppUser(_ user: AppUser) async throws {
        try db.collection("users")
            .document(user.id)
            .setData(from: user, merge: true)
    }
    
    func deleteAppUser(_ user: AppUser) async throws {
        try await db.collection("users")
            .document(user.id)
            .delete()
    }
}
