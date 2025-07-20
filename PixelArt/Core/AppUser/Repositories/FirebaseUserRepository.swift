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
    
    func follow(followerId: String, followedId: String) async throws {
        let followerRef = db.collection(FirestoreCollection.users).document(followerId)
        let followedRef = db.collection(FirestoreCollection.users).document(followedId)
        
        try await followerRef.updateData([
            "following": FieldValue.arrayUnion([followedId])
        ])
        
        try await followedRef.updateData([
            "following": FieldValue.arrayUnion([followerId])
        ])
    }
    
    func unfollow(followerId: String, followedId: String) async throws {
        let followerRef = db.collection(FirestoreCollection.users).document(followerId)
        let followedRef = db.collection(FirestoreCollection.users).document(followedId)
        
        try await followerRef.updateData([
            "following": FieldValue.arrayRemove([followedId])
        ])
        
        try await followedRef.updateData([
            "following": FieldValue.arrayRemove([followerId])
        ])
    }
}
