//
//  Artwork.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import Foundation

struct Artwork: Codable, Equatable, Identifiable, Hashable {
    let id: String
    let authorId: String
    let authorUsername: String
    let data: [String]
    var colorPalette: [String]? = nil
    let competitionId: String?
    let size: [Int]
    var topic: String
    var status: ArtworkStatus
    var lastUpdated: Date
}

enum ArtworkStatus: String, Codable, CaseIterable, Hashable {
    case personal = "personal"
    case shared = "shared"
    case activeCompetition = "activeCompetition"
    case archived = "archived"
    case scoring = "scoring"
}

enum ArtworkFilter {
    case authorId(String)
    case status(ArtworkStatus)
    case competitionId(String)
    
    var field: String {
        switch self {
        case .authorId: return "authorId"
        case .status: return "status"
        case .competitionId: return "competitionId"
        }
    }
    
    var value: String {
        switch self {
        case .authorId(let value): return value
        case .status(let value): return value.rawValue
        case .competitionId(let value): return value
        }
    }
}


extension Artwork {
    func toUIModel(isSynced: Bool) -> ArtworkUIModel {
        ArtworkUIModel(
            id: id,
            authorId: authorId,
            authorUsername: authorUsername,
            data: data,
            competitionId: competitionId,
            size: size,
            topic: topic,
            status: status,
            lastUpdated: lastUpdated,
            isSynced: isSynced
        )
    }
}
