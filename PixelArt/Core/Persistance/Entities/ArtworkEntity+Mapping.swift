//
//  ArtworkEntity+Mapping.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 23/07/2025.
//

import CoreData

extension ArtworkEntity {
    
    /// Entity -> Domain Model ( for UI)
    func toModel() -> Artwork {
        return Artwork(
            id: id,
            authorId: authorId,
            authorUsername: authorUsername,
            data: data,
            competitionId: competitionId,
            size: [Int(width), Int(height)],
            topic: topic,
            status: ArtworkStatus(rawValue: status) ?? .personal,
            lastUpdated: lastUpdated
        )
    }
    
    /// Domain Model -> Entity (for Firestore or UI)
    func populate(with model: Artwork, context: NSManagedObjectContext) {
        self.id = model.id
        self.authorId = model.authorId
        self.authorUsername = model.authorUsername
        self.data = model.data
        self.competitionId = model.competitionId
        self.topic = model.topic ?? "emmmppyyyt"
        self.status = model.status.rawValue
        self.width = Int32(model.size.first ?? 0)
        self.height = Int32(model.size.last ?? 0)
        self.lastUpdated = model.lastUpdated ?? .now
        self.isSynced = false
    }
    
    /// Create new entity
    static func from(model: Artwork, context: NSManagedObjectContext) -> ArtworkEntity {
        let entity = ArtworkEntity(context: context)
        entity.populate(with: model, context: context)
        return entity
    }
}
