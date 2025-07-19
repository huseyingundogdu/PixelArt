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
    
    func fetchCompetitions(status: CompetitionStatus) async throws -> [Competition] {
        let snapshot = try await db.collection(FirestoreCollection.competitions)
            .whereField("status", isEqualTo: status.rawValue)
            .getDocuments()
        
        return try snapshot.documents.compactMap { document in
            try document.data(as: Competition.self)
        }
    }
}
