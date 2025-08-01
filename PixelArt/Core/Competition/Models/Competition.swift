//
//  Competition.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 16/05/2025.
//

import Foundation
import FirebaseCore

struct Competition: Identifiable, Hashable, Codable, Equatable {
    let id: String
    let topic: String
    let colorPalette: [String]
    let activatedAt: Timestamp
    let scoringAt: Timestamp
    let finishAt: Timestamp
    let status: CompetitionStatus
    let size: [Int]
}

enum CompetitionStatus: String, Codable, CaseIterable {
    case active
    case scoring
    case past
}
