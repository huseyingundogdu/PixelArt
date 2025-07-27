//
//  CoreDataArtworkRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 23/07/2025.
//

import Foundation
import CoreData

// Artwok repo protocol needs refactoring
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
    
    func save(artwork: Artwork, source: ArtworkSource) async throws {
        let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", artwork.id)
        
        let results = try context.fetch(request)
        let entity = results.first ?? ArtworkEntity(context: context)
        
        switch source {
        case .ui:
            entity.populateFromUI(with: artwork, context: context)
        case .firebase:
            entity.populateFromFirebase(with: artwork, context: context)
        }
        
        try context.save()
    }
    
    func saveAll(artworks: [Artwork]) async throws {
        for artwork in artworks {
            let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", artwork.id)
            
            let results = try context.fetch(request)
            let entity = results.first ?? ArtworkEntity(context: context)
            entity.populateFromFirebase(with: artwork, context: context)
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
    
    func fetchUnsyncedIds(authorId: String) async throws -> Set<String> {
        let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "authorId == %@ AND isSynced == NO", authorId)
        let entities = try context.fetch(request)
        return Set(entities.map { $0.id })
    }
    
    func hasUnsyncedArtworks(authorId: String) async throws -> Bool {
        let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "authorId == %@ AND isSynced == NO", authorId)
        let count = try context.count(for: request)
        return count > 0
    }
    
    func softDelete(id: String) async throws {
        let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        if let entity = try context.fetch(request).first {
            entity.syncOperation = "delete"
            entity.isSynced = false
            try context.save()
        }
    }
    
    func fetchVisibleArtworks(authorId: String) async throws -> [Artwork] {
        let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
        let authorPredicate = NSPredicate(format: "authorId == %@", authorId)
        let notDeletedPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [
            NSPredicate(format: "syncOperation != %@", "delete"),
            NSPredicate(format: "syncOperation == nil"),
        ])
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            authorPredicate,
            notDeletedPredicate
        ])
        
        let entities = try context.fetch(request)
        return entities.map { $0.toModel() }
    }
    
    func fetchUnsyncedEntities() async throws -> [ArtworkEntity] {
        let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isSynced == NO AND syncOperation != nil")
        
        let entities = try context.fetch(request)
        return entities
    }
    
    func markAsSynced(id: String) async throws {
        let request: NSFetchRequest<ArtworkEntity> = ArtworkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        if let entity = try context.fetch(request).first {
            if entity.syncOperation == "delete" {
                context.delete(entity)
            } else {
                entity.isSynced = true
                entity.syncOperation = nil
            }
            try context.save()
        }
    }
}


enum ArtworkSource {
    case ui
    case firebase
}
