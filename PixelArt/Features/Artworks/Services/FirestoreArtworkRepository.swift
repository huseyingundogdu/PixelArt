//
//  FirestoreArtworkRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import Foundation
import FirebaseFirestore

private enum FirestoreCollection {
    static let artworks = "artworks"
    static let submittedArtworks = "submittedArtworks"
}

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
    
    func fetchPersonalArtworks(forUserId userId: String) async throws -> [Artwork] {
        try await fetchArtworks(
            from: FirestoreCollection.artworks,
            filters: [
                ("authorId", userId),
                ("status", ArtworkStatus.personal.rawValue)
            ]
        )
    }
    
    func fetchSharedArtworks(forUserId userId: String) async throws -> [Artwork] {
        try await fetchArtworks(
            from: FirestoreCollection.artworks,
            filters: [
                ("authorId", userId),
                ("status", ArtworkStatus.shared.rawValue)
            ]
        )
    }
    
    func fetchActiveCompetitionArtworks(forUserId userId: String) async throws -> [Artwork] {
        try await fetchArtworks(
            from: FirestoreCollection.artworks,
            filters: [
                ("authorId", userId),
                ("status", ArtworkStatus.activeCompetition.rawValue)
            ]
        )
    }
    
    func fetchArchivedArtworks(forUserId userId: String) async throws -> [Artwork] {
        try await fetchArtworks(
            from: FirestoreCollection.submittedArtworks,
            filters: [
                ("authorId", userId),
                ("status", ArtworkStatus.archived.rawValue)
            ]
        )
    }
    
    func fetchCompetitionArtworks(forCompetitionId competitionId: String) async throws -> [Artwork] {
        try await fetchArtworks(
            from: FirestoreCollection.artworks,
            filters: [
                ("competitionId", competitionId),
                ("status", ArtworkStatus.activeCompetition.rawValue)
            ]
        )
    }
    
    private func fetchArtworks(from collection: String, filters: [(String, Any)]) async throws ->[Artwork] {
        var query: Query = db.collection(collection)
        
        for (field, value) in filters {
            query = query.whereField(field, isEqualTo: value)
        }
        
        let snapshot = try await query.getDocuments()
        return try snapshot.documents.compactMap { try $0.data(as: Artwork.self) }
    }
    
}
