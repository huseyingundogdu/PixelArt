//
//  ArtworkUIModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 24/07/2025.
//

import Foundation

struct ArtworkUIModel: Codable, Equatable, Identifiable, Hashable {
    let id: String
    let authorId: String
    let authorUsername: String
    let data: [String]
    let competitionId: String?
    let size: [Int]
    var topic: String
    var status: ArtworkStatus
    var lastUpdated: Date
    var isSynced: Bool
}
