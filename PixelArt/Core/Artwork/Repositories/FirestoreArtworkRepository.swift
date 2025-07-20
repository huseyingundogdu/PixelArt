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

    func createArtwork(_ artwork: Artwork) async throws {
        try db.collection("artworks")
            .document(artwork.id)
            .setData(from: artwork)
    }
    
    func fetchArtworks(matching filters: [ArtworkFilter]) async throws ->[Artwork] {
        var query: Query = db.collection(FirestoreCollection.artworks)
        
        for filter in filters {
            query = query.whereField(filter.field, isEqualTo: filter.value)
        }
        
        let snapshot = try await query.getDocuments()
        
        return try snapshot.documents.compactMap { try $0.data(as: Artwork.self) }
    }
    
    func fetchSubmittedArtworks(matching filters: [ArtworkFilter]) async throws -> [Artwork] {
        var query: Query = db.collection(FirestoreCollection.submittedArtworks)
        
        for filter in filters {
            query = query.whereField(filter.field, isEqualTo: filter.value)
        }
        
        let snapshot = try await query.getDocuments()
        
        return try snapshot.documents.compactMap { try $0.data(as: Artwork.self) }
    }
}
