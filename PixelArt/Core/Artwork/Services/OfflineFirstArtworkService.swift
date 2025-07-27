//
//  OfflineFirstArtworkService.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 23/07/2025.
//

import Foundation

final class OfflineFirstArtworkService {
    
    private let coreDataRepository: CoreDataArtworkRepository
    private let syncManager: ArtworkSyncManager
    private let networkMonitor: NetworkMonitor
    
    init(
        coreDataRepository: CoreDataArtworkRepository = CoreDataArtworkRepository(),
        syncManager: ArtworkSyncManager = ArtworkSyncManager(),
        networkMonitor: NetworkMonitor = .shared
    ) {
        self.coreDataRepository = coreDataRepository
        self.syncManager = syncManager
        self.networkMonitor = networkMonitor
    }
    
    /// For UI
    func fetchArtworks(authorId: String) async throws -> [ArtworkUIModel] {
        if networkMonitor.isConnected {
            //Sync
            await syncIfNeeded(authorId: authorId)
        }
        
        let local = try await coreDataRepository.fetchVisibleArtworks(authorId: authorId)
        let unsyncedIds = try await coreDataRepository.fetchUnsyncedIds(authorId: authorId)        
        return local.map { $0.toUIModel(isSynced: !unsyncedIds.contains($0.id)) }
    }
    
    /// Create a new artwork on local, with sync it sends to Firebase
    func createArtwork(_ artwork: Artwork) async throws {
        var newArtwork = artwork
        newArtwork.lastUpdated = .now
        
        try await coreDataRepository.save(artwork: newArtwork, source: .ui)
    }
    
    
    func updateArtwork(artwork: Artwork, title: String) async throws {
        var updatedArtwork = artwork
        updatedArtwork.topic = title
        updatedArtwork.lastUpdated = .now
        
        try await coreDataRepository.save(artwork: updatedArtwork, source: .ui)
    }
    
    func deleteArtwork(id: String) async throws {
        try await coreDataRepository.softDelete(id: id)
    }
    
    func syncIfNeeded(authorId: String) async {
        guard networkMonitor.isConnected else { return }
        await syncManager.syncToRemote()
        await syncManager.syncFromRemote(authorId: authorId)
    }
}
