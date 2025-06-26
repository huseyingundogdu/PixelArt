//
//  FirestoreCompetitionRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import Foundation
import FirebaseFirestore

final class FirestoreCompetitionRepository: CompetitionRepository {
    
    private let db = Firestore.firestore()
    
    
    func fetchActiveCompetition() async throws -> Competition {
        let snapshot = try await db.collection("activeCompetitions")
            .whereField("status", isEqualTo: "active")
            .limit(to: 1)
            .getDocuments()
        
        guard let document = snapshot.documents.first else {
            throw NSError(domain: "", code: 404, userInfo: [
                NSLocalizedDescriptionKey: "There is no active competition."
            ])
        }
        
        return try document.data(as: Competition.self)
    }
    
    func createEmptyArtworkRelatedToCompetition(currentUserId: String, currentCompetition: Competition) async throws {
        let artwork = Artwork(
            id: UUID().uuidString,
            authorId: currentUserId,
            data: createEmptyCanvas(size: currentCompetition.size),
            competitionId: currentCompetition.id,
            size: currentCompetition.size,
            topic: currentCompetition.topic
        )
        
        let artworkData: [String: Any] = [
            "id": artwork.id,
            "authorId": artwork.authorId,
            "data": artwork.data,
            "competitionId": artwork.competitionId,
            "size": artwork.size
        ]
        
        do {
            try await db.collection("artworks")
                .document(artwork.id)
                .setData(artworkData)
            
            print("Artwork document created successfully.")
        } catch {
            print("Error creating artwork document: \(error)")
            throw error
        }
    }

    private func createEmptyCanvas(size: [Int]) -> [String] {
        let total = size[0] * size[1]
        var emptyCanvasData: [String] = []
        
        for _ in 0..<total {
            emptyCanvasData.append("ffffff")  // white pixel hex
        }
        
        return emptyCanvasData
    }
    
    func isUserAlreadyCreatedArtworkRelatedToCurrentCompetition(currentUserId: String, currentCompetition: Competition) async throws -> Bool {

        let artworksRef = db.collection("artworks")
        let query = artworksRef.whereField("competitionId", isEqualTo: currentCompetition.id).whereField("authorId", isEqualTo: currentUserId)
        
        do {
            let snapshot = try await query.getDocuments()
            
            if snapshot.documents.isEmpty {
                return false
            } else {
                return true
            }
            
        } catch {
            print("Error bool")
            throw error
        }
    }
    
}
