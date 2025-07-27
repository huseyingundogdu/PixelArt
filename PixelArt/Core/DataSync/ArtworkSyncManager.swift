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
            let localArtworkDict = Dictionary(uniqueKeysWithValues: localArtworks.map { ($0.id, $0) })
            
            for remote in remoteArtworks {
                if let local = localArtworkDict[remote.id] {
                    //Conflict resolution: if remote is newer than local
                    if remote.lastUpdated > local.lastUpdated {
                        try await coreDataRepository.save(artwork: remote, source: .firebase)
                    }
                } else {
                    // if there is no on local
                    try await coreDataRepository.save(artwork: remote, source: .firebase)
                }
            }
                
        } catch {
            print("🔴 Sync failed: \(error)")
        }
    }
    
    func syncToRemote() async {
        do {
            let unsyncedEntities = try await coreDataRepository.fetchUnsyncedEntities()
            
            for entity in unsyncedEntities {
                let artwork = entity.toModel()
                
                switch entity.syncOp {
                case .create:
                    try await firestoreRepository.createArtwork(artwork)
                case .update:
                    try await firestoreRepository.updateArtwork(artwork)
                case .delete:
                    try await firestoreRepository.deleteArtwork(id: artwork.id)
                case .none:
                    continue
                }

                try await coreDataRepository.markAsSynced(id: artwork.id)
            }
        } catch {
            print("🔴 Upload to Firestore failed: \(error)")
        }
    }
    
}

enum SyncOperation: String {
    case create
    case update
    case delete
}
