//
//  ArtworkSyncManager.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 23/07/2025.
//

import Foundation

final class ArtworkSyncManager {
    
    private let firestoreRepository: FirestoreArtworkRepository
    private let coreDataRepository: CoreDataArtworkRepository
    
    init(
        firestoreRepository: FirestoreArtworkRepository = FirestoreArtworkRepository(),
        coreDataRepository: CoreDataArtworkRepository = CoreDataArtworkRepository()
    ) {
        self.firestoreRepository = firestoreRepository
        self.coreDataRepository = coreDataRepository
    }
    
    /// Firestore to CoreData sync
    func syncFromRemote(authorId: String) async {
        do {
            let remoteArtworks = try await firestoreRepository.fetchArtworks(matching: [.authorId(authorId)])
            let localArtworks = try await coreDataRepository.fetchAll()
            let localIds = Set(localArtworks.map { $0.id })
            
            for artwork in remoteArtworks {
                if !localIds.contains(artwork.id) {
                    try await coreDataRepository.save(artwork: artwork)
                }
            }
        } catch {
            print("🔴 Sync failed: \(error)")
        }
    }
    
    func syncToRemote() async {
        do {
            let unsyncedArtworks = try await coreDataRepository.fetchUnsynced()
            
            for artwork in unsyncedArtworks {
                try await firestoreRepository.createArtwork(artwork)
                try await coreDataRepository.markAsSynced(id: artwork.id)
            }
        } catch {
            print("🔴 Upload to Firestore failed: \(error)")
        }
    }
    
}

