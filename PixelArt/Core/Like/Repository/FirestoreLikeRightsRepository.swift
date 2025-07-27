//
//  FirestoreLikeQuotaRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 27/07/2025.
//

import Foundation
import FirebaseFirestore

final class FirestoreLikeRightsRepository {
    
    private let db = Firestore.firestore()
    
    private var likeRightsCollection: CollectionReference {
        db.collection(FirestoreCollection.likeRights)
    }
    
    func fetchUserRights(competitionId: String, userId: String) async throws -> LikeRights? {
        let docRef = likeRightsCollection
            .document(competitionId)
            .collection("users")
            .document(userId)
        
        let snapshot = try await docRef.getDocument()
        return try? snapshot.data(as: LikeRights.self)
    }
    
    func incrementUsedRights(for competitionId: String, userId: String) async throws {
        let docRef = likeRightsCollection
            .document(competitionId)
            .collection("users")
            .document(userId)
        
        _ = try await db.runTransaction { transaction, errorPointer in
            do {
                let snapshot = try transaction.getDocument(docRef)
                let rights = try snapshot.data(as: LikeRights.self)
                
                if rights.used >= rights.total {
                    throw NSError(domain: "LikeRightsError", code: 403, userInfo: [NSLocalizedDescriptionKey: "Rights exceeded"])
                }
                
                var updatedRights = rights
                updatedRights.used += 1
                try transaction.setData(from: updatedRights, forDocument: docRef)
            } catch {
                errorPointer?.pointee = error as NSError
            }
            return nil
        }
    }
    
    func decrementUsedRights(for competitionId: String, userId: String) async throws {
        let docRef = likeRightsCollection
            .document(competitionId)
            .collection("users")
            .document(userId)
        
        _ = try await db.runTransaction { transaction, errorPointer in
            do {
                let snapshot = try transaction.getDocument(docRef)
                var rights = try snapshot.data(as: LikeRights.self)
                
                if rights.used <= 0 {
                    throw NSError(
                        domain: "LikeRightsError",
                        code: 400,
                        userInfo: [NSLocalizedDescriptionKey: "No used rights to revert"]
                    )
                }
                
                rights.used -= 1
                try transaction.setData(from: rights, forDocument: docRef)
            } catch {
                errorPointer?.pointee = error as NSError
            }
            return nil
        }
    }
}
