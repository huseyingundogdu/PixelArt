//
//  FirestoreArtworkRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import Foundation
import FirebaseFirestore

final class FirestoreArtworkRepository: ArtworkRepository {
    
    
    private let db = Firestore.firestore()
    
    func fetchArtworks(by currentUserId: String) async throws -> [Artwork] {
        let snapshot = try await db.collection("artworks")
            .whereField("authorId", isEqualTo: currentUserId)
            .getDocuments()
        
        return try snapshot.documents.compactMap { document in
            try document.data(as: Artwork.self)
        }
    }
    
    func createArtwork(_ artwork: Artwork) async throws {
        try db.collection("artworks")
            .document(artwork.id)
            .setData(from: artwork)
    }
    
    func fetchCompetitionArtworks(competitionId: String) async throws -> [Artwork] {
        let snapshot = try await db.collection("submittedArtworks")
            .whereField("competitionId", isEqualTo: competitionId)
            .getDocuments()
        
        return try snapshot.documents.compactMap { document in
            try document.data(as: Artwork.self)
        }
    }
}
