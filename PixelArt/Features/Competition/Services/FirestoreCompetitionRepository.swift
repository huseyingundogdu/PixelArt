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
    
    func fetchScoringCompetitions() async throws -> [Competition] {
        let snapshot = try await db.collection("scoringCompetitions")
            .whereField("status", isEqualTo: "scoring")
            .getDocuments()
        
        return try snapshot.documents.compactMap { document in
            try document.data(as: Competition.self)
        }
    }
    
}
