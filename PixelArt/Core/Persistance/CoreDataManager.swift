//
//  CoreDataManager.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 23/07/2025.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "PixelArtModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving Core Data: \(error.localizedDescription)")
            }
        }
    }
}
