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
    let data: [String]
    let competitionId: String?
    let size: [Int]
    var topic: String?
    var status: ArtworkStatus
}

enum ArtworkStatus: String, Codable, CaseIterable, Hashable{
    case personal = "personal"
    case shared = "shared"
    case activeCompetition = "activeCompetition"
    case archived = "archived"
}
