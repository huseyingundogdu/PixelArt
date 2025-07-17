//
//  FirebaseUserService.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 17/07/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

private enum FirestoreCollection {
    static let users = "users"
}

final class FirebaseUserService {
    
    private let db = Firestore.firestore()
    
    func createUserDocument(user: User, username: String) async throws {
        let newUser = AppUser(
            id: user.uid,
            email: user.email ?? "Error!",
            username: username,
            profilePictureData: createDefaultProfilePictureData(),
            followers: [],
            following: [],
            joinedCompetition: [],
            createdAt: Date()
        )
        
        try db.collection(FirestoreCollection.users)
            .document(user.uid)
            .setData(from: newUser)
    }
    
    private func createDefaultProfilePictureData() -> [String] {
        MockData.personArtwork.data
    }
    
    func fetchUser(uid: String) async throws -> AppUser {
        let snapshot = try await db.collection(FirestoreCollection.users)
            .document(uid)
            .getDocument()
        
        return try snapshot.data(as: AppUser.self)
    }
}


struct AppUser: Identifiable, Codable {
    let id: String
    let email: String
    let username: String
    let profilePictureData: [String]
    let followers: [String]
    let following: [String]
    let joinedCompetition: [String]
    let createdAt: Date
}
