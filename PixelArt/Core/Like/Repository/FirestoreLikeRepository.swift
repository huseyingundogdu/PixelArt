//
//  FirestoreLikeRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 27/07/2025.
//

import Foundation
import FirebaseFirestore

final class FirestoreLikeRepository {
    
    private let db = Firestore.firestore()
    
    private func usersSubCollection(for artworkId: String) -> CollectionReference {
        db.collection("likes")
            .document(artworkId)
            .collection("users")
    }
    
    func likeArtwork(artworkId: String, userId: String) async throws {
        let userRef = usersSubCollection(for: artworkId).document(userId)
        let like = Like(userId: userId, timestamp: .now)
        try userRef.setData(from: like)
    }
    
    func unlikeArtwork(artworkId: String, userId: String) async throws {
        let userRef = usersSubCollection(for: artworkId).document(userId)
        try await userRef.delete()
    }
    
    func hasUserLiked(artworkId: String, userId: String) async throws -> Bool {
        let userRef = usersSubCollection(for: artworkId).document(userId)
        let snapshot = try await userRef.getDocument()
        return snapshot.exists
    }
    
    func fetchLikeCount(for artworkId: String) async throws -> Int {
        let snapshot = try await usersSubCollection(for: artworkId).getDocuments()
        return snapshot.documents.count
    }
}
