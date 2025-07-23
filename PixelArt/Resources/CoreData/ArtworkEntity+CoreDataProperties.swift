//
//  ArtworkEntity+CoreDataProperties.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 23/07/2025.
//

import Foundation
import CoreData

extension ArtworkEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArtworkEntity> {
        return NSFetchRequest<ArtworkEntity>(entityName: "ArtworkEntity")
    }
    
    @NSManaged public var id: String
    @NSManaged public var authorId: String
    @NSManaged public var authorUsername: String
    @NSManaged public var data: [String]
    @NSManaged public var competitionId: String?
    @NSManaged public var topic: String
    @NSManaged public var status: String
    @NSManaged public var width: Int32
    @NSManaged public var height: Int32
    @NSManaged public var lastUpdated: Date
    @NSManaged public var isSynced: Bool
    
}
