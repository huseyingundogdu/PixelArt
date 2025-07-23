//
//  CoreDataArtworkRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 23/07/2025.
//

import Foundation
import CoreData

// Artwok repo needs refactoring
final class CoreDataArtworkRepository {
    
    private let context: NSManagedObjectContext
    
    init(
        context: NSManagedObjectContext = CoreDataManager.shared.context
    ) {
        self.context = context
    }
    
    func fetchAll() async throws -> [Artwork] {
        let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
        let entities = try context.fetch(request)
        return entities.map { $0.toModel() }
    }
    
    func fetch(by filter: ArtworkFilter) async throws -> [Artwork] {
        let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", filter.field, filter.value)
        
        let entities = try context.fetch(request)
        return entities.map { $0.toModel() }
    }
    
    func save(artwork: Artwork) async throws {
        let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", artwork.id)
        
        let results = try context.fetch(request)
        let entity = results.first ?? ArtworkEntity(context: context)
        entity.populate(with: artwork, context: context)
        
        try context.save()
    }
    
    func saveAll(artworks: [Artwork]) async throws {
        for artwork in artworks {
            let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", artwork.id)
            
            let results = try context.fetch(request)
            let entity = results.first ?? ArtworkEntity(context: context)
            entity.populate(with: artwork, context: context)
        }
        try context.save()
    }
    
    func delete(id: String) async throws {
        let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        let results = try context.fetch(request)
        results.forEach { context.delete($0) }
        try context.save()
    }
    
    func fetchUnsynced() async throws -> [Artwork] {
        let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isSynced == NO")
        
        let entities = try context.fetch(request)
        return entities.map { $0.toModel() }
    }
    
    func markAsSynced(id: String) async throws {
        let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        if let entity = try context.fetch(request).first {
            entity.isSynced = true
            try context.save()
        }
    }
    
    func hasUnsyncedArtworks(authorId: String) async throws -> Bool {
        let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "authorId == %@ AND isSynced == NO", authorId)
        let count = try context.count(for: request)
        return count > 0
    }
    
}
