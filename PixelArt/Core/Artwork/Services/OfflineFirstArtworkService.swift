//
//  OfflineFirstArtworkService.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 23/07/2025.
//

import Foundation

final class OfflineFirstArtworkService {
    
    private let firestoreRepository: FirestoreArtworkRepository
    private let coreDataRepository: CoreDataArtworkRepository
    private let syncManager: ArtworkSyncManager
    private let networkMonitor: NetworkMonitor
    
    init(
        firestoreRepository: FirestoreArtworkRepository = FirestoreArtworkRepository(),
        coreDataRepository: CoreDataArtworkRepository = CoreDataArtworkRepository(),
        syncManager: ArtworkSyncManager = ArtworkSyncManager(),
        networkMonitor: NetworkMonitor = .shared
    ) {
        self.firestoreRepository = firestoreRepository
        self.coreDataRepository = coreDataRepository
        self.syncManager = syncManager
        self.networkMonitor = networkMonitor
    }
    
    func fetchArtworks(authorId: String) async throws -> [ArtworkUIModel] {
        let hasUnsynced = try await coreDataRepository.hasUnsyncedArtworks(authorId: authorId)
        
        if !hasUnsynced {
            let local = try await coreDataRepository.fetch(by: .authorId(authorId))
            let unsyncedIds = try await coreDataRepository.fetchUnsyncedIds(authorId: authorId)
            
            
            return local.map { $0.toUIModel(isSynced: !unsyncedIds.contains($0.id)) }
        }
        
        await syncIfNeeded()
        
        let remote = try await firestoreRepository.fetchArtworks(matching: [.authorId(authorId)])
        
        try await coreDataRepository.saveAll(artworks: remote)
        
        let updatedLocal = try await coreDataRepository.fetch(by: .authorId(authorId))
        
        
        return updatedLocal.map { $0.toUIModel(isSynced: true) }
    }
    
    func createArtwork(_ artwork: Artwork) async throws {
        try await coreDataRepository.save(artwork: artwork, source: .ui)
        
        if networkMonitor.isConnected {
            try await firestoreRepository.createArtwork(artwork)
            try await coreDataRepository.markAsSynced(id: artwork.id)
        }
    }
    
    func syncIfNeeded() async {
        if networkMonitor.isConnected {
            await syncManager.syncToRemote()
            await syncManager.syncFromRemote(authorId: "xKl9T1P7KARnBKme4DsVU1YlaNU2")
        }
    }
}
