//
//  Mock.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import Foundation
import FirebaseCore

struct MockData {
    static let currentUserId = "user1"
    
    static let competition = Competition(
        id: "competition-city-2025-08-12",
        topic: "Mushrooms",
        colorPalette: ["#FF5733", "#33FF57", "#3357FF", "#FF33A1", "#A133FF", "#33FFF5", "#F5FF33"],
        activatedAt: Timestamp(date: Date()),
        scoringAt: Timestamp(date: Date().addingTimeInterval(3 * 24 * 60 * 60)), // 3 gün sonrası
        finishAt: Timestamp(date: Date().addingTimeInterval(6 * 24 * 60 * 60)),  // 6 gün sonrası
        status: "active",
        size: [16, 16]
    )
    
    static let artwork = Artwork(
        id: "1",
        authorId: "authorId",
        data: ["870058", "a4303f", "f2d0a4", "c8d6af"],
        competitionId: "competitionId",
        size: [2, 2],
        topic: nil,
        status: .personal
    )
    
    static let artwork2 = Artwork(
        id: "3",
        authorId: "authorId",
        data: [
            "ffffff", "f0f0f0", "e0e0e0", "d0d0d0", "c0c0c0", "b0b0b0", "a0a0a0", "909090",
            "808080", "707070", "606060", "505050", "404040", "303030", "202020", "101010",
            "ff0000", "ff7f00", "ffff00", "7fff00", "00ff00", "00ff7f", "00ffff", "007fff",
            "0000ff", "7f00ff", "ff00ff", "ff007f", "ffcccc", "ccffcc", "ccccff", "999999",
            "660000", "006600", "000066", "666600", "660066", "006666", "333300", "003333",
            "330033", "999966", "669999", "996699", "cc6600", "66cc00", "0066cc", "6600cc",
            "00cc66", "cc0066", "cccccc", "9999cc", "cc9999", "99cc99", "ffcc99", "ccff99",
            "99ccff", "cc99ff", "f2f2f2", "e6e6e6", "d9d9d9", "cccccc", "bfbfbf", "b3b3b3"
        ],
        competitionId: "competitionId",
        size: [8, 8],
        topic: nil,
        status: .personal
    )
    
    static let artwork_heart = Artwork(
        id: "7",
        authorId: "authorId",
        data: [
            "ffffff","ffffff","ffffff","ff0000","ff0000","ffffff","ffffff","ffffff","ffffff","ffffff","ff0000","ff0000","ffffff","ffffff","ffffff","ffffff",
            "ffffff","ffffff","ff0000","ff0000","ff0000","ff0000","ffffff","ffffff","ffffff","ff0000","ff0000","ff0000","ff0000","ffffff","ffffff","ffffff",
            "ffffff","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ffffff","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ffffff","ffffff",
            "ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ffffff",
            "ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ffffff",
            "ffffff","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ffffff","ffffff",
            "ffffff","ffffff","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ffffff","ffffff","ffffff",
            "ffffff","ffffff","ffffff","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ffffff","ffffff","ffffff","ffffff",
            "ffffff","ffffff","ffffff","ffffff","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ff0000","ffffff","ffffff","ffffff","ffffff","ffffff",
            "ffffff","ffffff","ffffff","ffffff","ffffff","ff0000","ff0000","ff0000","ff0000","ff0000","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff",
            "ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ff0000","ff0000","ff0000","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff",
            "ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ff0000","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff",
            "ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff",
            "ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff",
            "ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff",
            "ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff","ffffff"
        ],
        competitionId: "competitionId",
        size: [16, 16],
        topic: nil,
        status: .personal
    )
    
    static let artwork_smileyface = Artwork(
        id: "9",
        authorId: "smileyMaster",
        data: [
        "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf",
        "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf",
        "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf",
        "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "103947", "103947", "103947", "103947", "103947", "000000",
        "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "103947", "103947", "103947", "103947", "103947", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "103947", "103947", "103947", "103947", "103947", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "103947", "103947", "103947", "103947", "103947", "000000", "f1f2bf", "f1f2bf", "f1f2bf",
        "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "103947", "103947", "103947", "103947", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "103947", "103947", "103947", "103947", "000000", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "103947", "103947", "103947", "103947", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf",
        "f1f2bf", "f1f2bf", "f1f2bf", "000000", "103947", "103947", "103947", "103947", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "000000", "000000", "000000", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "000000", "000000", "000000", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf",
        "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf",
        "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf",
        "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "000000", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf",
        "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000",
        "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "a1a1a1", "a1a1a1", "a1a1a1", "a1a1a1", "a1a1a1", "a1a1a1", "000000", "a1a1a1", "a1a1a1", "a1a1a1", "a1a1a1", "a1a1a1", "000000", "000000", "a1a1a1", "a1a1a1", "a1a1a1", "a1a1a1", "a1a1a1", "000000", "a1a1a1", "a1a1a1", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf",
        "000000", "000000", "000000", "a1a1a1", "a1a1a1", "a1a1a1", "000000", "000000", "000000", "a1a1a1", "a1a1a1", "a1a1a1", "000000", "000000", "000000", "000000", "a1a1a1", "a1a1a1", "000000", "000000", "000000", "000000", "a1a1a1", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "592b2b", "000000", "000000", "000000", "000000", "000000", "592b2b", "000000", "000000", "000000", "000000", "000000", "592b2b", "592b2b", "000000", "000000", "000000", "000000",
        "592b2b", "592b2b", "000000", "000000", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "592b2b", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "592b2b", "592b2b", "592b2b",
        "000000", "000000", "000000", "000000", "000000", "000000", "000000", "592b2b", "000000", "000000", "000000", "000000", "000000", "592b2b", "592b2b", "592b2b", "000000", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "592b2b", "000000", "000000", "000000", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "000000", "000000", "ad3636", "ad3636", "ad3636", "ad3636", "000000", "000000", "592b2b", "592b2b", "000000", "f1f2bf", "f1f2bf",
        "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "000000", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "000000", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "000000", "000000", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636",
        "ad3636", "ad3636", "000000", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "000000", "ad3636", "ad3636", "ad3636", "000000", "000000", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf",
        "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "ad3636", "000000", "ad3636", "000000", "000000", "000000", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "000000", "f1f2bf",
        "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf",
        "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf",
        "f1f2bf", "f1f2bf", "f1f2bf", "f1f2bf"
        ],
        competitionId: "smile32x32",
        size: [32, 32],
        topic: nil,
        status: .personal
    )
    
    static let artwork_face_avatar = Artwork(
        id: "11",
        authorId: "authorId",
        data: [
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "692b2b", "692b2b", "692b2b", "692b2b", "692b2b", "692b2b", "692b2b", "692b2b", "692b2b", "692b2b", "692b2b", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "692b2b", "692b2b", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c",
        "ab825c", "ab825c", "692b2b", "692b2b", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "692b2b", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "692b2b", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "692b2b", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "692b2b", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "692b2b", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "692b2b",
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "692b2b", "ab825c", "ab825c", "8a5744", "8a5744", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "8a5744", "8a5744", "ab825c", "ab825c", "692b2b", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "692b2b", "ab825c", "8a5744", "f7ba84", "f7ba84", "8a5744", "ab825c",
        "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "8a5744", "f7ba84", "f7ba84", "8a5744", "ab825c", "692b2b", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "692b2b", "8a5744", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "8a5744", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "ab825c", "8a5744", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "8a5744", "692b2b", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "692b2b", "d68c6b", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "ffe1a5", "ffe1a5", "ffe1a5", "ffe1a5", "ffe1a5", "ffe1a5", "ffe1a5", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "d68c6b", "692b2b", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "692b2b", "d68c6b", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "ffe1a5", "ffe1a5", "ffe1a5", "ffe1a5", "ffe1a5", "ffe1a5",
        "ffe1a5", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "d68c6b", "692b2b", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "692b2b", "d68c6b", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "ffe1a5", "ffe1a5", "ffe1a5", "ffe1a5", "ffe1a5", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "d68c6b", "692b2b", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "692b2b", "d68c6b", "d68c6b", "f7ba84", "945552", "945552", "945552", "945552", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "945552", "945552", "945552", "945552", "f7ba84", "d68c6b", "d68c6b", "692b2b", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "945552", "d68c6b", "d68c6b", "945552", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "945552", "d68c6b",
        "d68c6b", "945552", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "d68c6b", "945552", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "945552", "d68c6b", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "f7ba84", "945552", "d68c6b", "d68c6b", "945552", "945552",
        "945552", "945552", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "945552", "945552", "945552", "945552", "d68c6b", "d68c6b", "945552", "f7ba84", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "f7ba84", "945552", "d68c6b", "d68c6b", "999999", "ffffff", "945552", "ffffff", "945552", "f7ba84", "f7ba84", "f7ba84", "945552", "ffffff", "945552", "ffffff", "999999", "d68c6b", "d68c6b", "945552", "f7ba84", "945552", "ffffff", "ffffff", "ffffff",
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "d68c6b", "945552", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "945552", "d68c6b", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "d68c6b", "945552", "f7ba84", "f7ba84", "ffe1a5", "ffe1a5", "ffe1a5", "f7ba84", "d68c6b", "f7ba84", "ffe1a5", "f7ba84",
        "d68c6b", "f7ba84", "ffe1a5", "ffe1a5", "ffe1a5", "f7ba84", "f7ba84", "945552", "d68c6b", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "945552", "d68c6b", "f7ba84", "f7ba84", "ffe1a5", "ffe1a5", "ffe1a5", "f7ba84", "d68c6b", "f7ba84", "ffe1a5", "f7ba84", "d68c6b", "f7ba84", "ffe1a5", "ffe1a5", "ffe1a5", "f7ba84", "f7ba84", "d68c6b", "945552", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "945552", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "ffe1a5", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "945552", "d68c6b", "945552", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84",
        "d68c6b", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "d68c6b", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "d68c6b", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "d68c6b", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "d68c6b", "d68c6b", "d68c6b",
        "d68c6b", "f7ba84", "f7ba84", "f7ba84", "ffe1a5", "ffe1a5", "ffe1a5", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "ffe1a5", "ffe1a5", "ffe1a5", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "945552", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "d68c6b", "d68c6b", "d68c6b", "f7ba84", "945552", "945552", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "945552", "945552", "f7ba84", "d68c6b", "d68c6b", "d68c6b", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "d68c6b", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "ffe1a5", "ffe1a5",
        "ffe1a5", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "d68c6b", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "d68c6b", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "945552", "945552", "945552", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "d68c6b", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "d68c6b", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "945552",
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "d68c6b", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "f7ba84", "d68c6b", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "ffffff", "945552", "945552", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "d68c6b", "945552", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "945552", "945552", "945552", "945552", "945552", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "ffffff", "ffffff", "ffffff"
        ],
        competitionId: "competitionId",
        size: [32, 32],
        topic: nil,
        status: .personal
    )

    static let artwork_skull = Artwork(
        id: "12",
        authorId: "authorId",
        data: [
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "444444", "444444", "444444", "444444", "444444", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "444444", "434343", "d8d8d8", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "d9d9d9",
        "434343", "444444", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "d9d9d9", "d8d8d8", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "d8d8d8", "d8d8d8", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "444444", "d9d9d9", "d8d8d8", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "d8d8d8", "d8d8d8", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "afafaf", "d8d8d8", "d8d8d8", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "d8d8d8", "d8d8d8", "999999", "444444",
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "434343", "afafaf", "d8d8d8", "d8d8d8", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "d8d8d8", "d8d8d8", "afafaf", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "797979", "afafaf", "d8d8d8", "d8d8d8", "ffffff", "ffffff",
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "d8d8d8", "d8d8d8", "afafaf", "797979", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "797979", "afafaf", "afafaf", "d8d8d8", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "d8d8d8", "afafaf", "afafaf", "797979", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "797979", "afafaf", "afafaf", "d8d8d8", "d8d8d8", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "d8d8d8", "d8d8d8", "afafaf", "afafaf", "797979", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "797979", "afafaf", "afafaf", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "afafaf", "afafaf", "797979", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "797979", "afafaf", "afafaf", "afafaf", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "d9d9d9", "afafaf", "afafaf", "afafaf", "797979", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "444444", "797979", "797979", "797979", "afafaf", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "afafaf", "797979", "797979", "797979", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "797979", "afafaf", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "d8d8d8", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "afafaf",
        "797979", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "797979", "d9d9d9", "aeaeae", "434343", "434343", "434343", "434343", "797979", "d9d9d9", "ffffff", "d9d9d9", "797979", "434343", "444444", "434343", "444444", "aeaeae", "d9d9d9", "afafaf", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "d8d8d8", "ffffff", "444444", "434343", "444444",
        "444444", "434343", "797979", "d8d8d8", "ffffff", "d8d8d8", "797979", "434343", "434343", "444444", "444444", "434343", "ffffff", "d9d9d9", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "ffffff", "ffffff", "444444", "444444", "434343", "434343", "444444", "d9d9d9", "ffffff", "ffffff", "ffffff", "d9d9d9", "434343", "434343", "434343", "444444", "444444", "ffffff", "ffffff", "444444", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "ffffff", "ffffff", "7a7a7a", "444444", "434343", "434343", "afafaf", "ffffff", "d9d9d9", "7a7a7a", "d8d8d8", "ffffff", "aeaeae", "444444", "434343", "444444", "7a7a7a", "ffffff", "ffffff", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "d8d8d8", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "d9d9d9", "7a7a7a", "7a7a7a", "7a7a7a",
        "d9d9d9", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "d9d9d9", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "797979", "797979", "aeaeae", "aeaeae", "aeaeae", "aeaeae", "d9d9d9", "d9d9d9", "434343", "434343", "434343", "d9d9d9", "d8d8d8", "aeaeae", "aeaeae", "aeaeae", "aeaeae", "797979", "797979", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "ffffff", "444444", "aeaeae", "797979", "434343", "797979", "d8d8d8", "d9d9d9", "ffffff", "434343", "434343", "444444", "ffffff", "d9d9d9", "d8d8d8", "797979", "434343", "797979", "aeaeae", "434343", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "aeaeae", "797979", "434343", "797979", "d8d8d8", "ffffff", "ffffff", "434343", "afafaf", "434343", "ffffff", "ffffff", "d8d8d8", "797979", "434343", "797979",
        "aeaeae", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "afafaf", "434343", "797979", "d8d8d8", "ffffff", "ffffff", "d8d8d8", "ffffff", "d8d8d8", "ffffff", "ffffff", "d8d8d8", "797979", "434343", "afafaf", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "afafaf", "797979",
        "434343", "434343", "797979", "afafaf", "afafaf", "afafaf", "afafaf", "afafaf", "797979", "434343", "434343", "797979", "aeaeae", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "d9d9d9", "797979", "434343", "afafaf", "d8d8d8", "d8d8d8", "ffffff", "d8d8d8", "ffffff", "d8d8d8", "d8d8d8", "afafaf", "434343", "797979", "d8d8d8", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "d8d8d8", "797979", "434343", "797979", "afafaf", "797979", "afafaf", "afafaf", "afafaf", "797979", "afafaf", "797979", "434343", "797979", "d9d9d9", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "d8d8d8", "aeaeae", "434343", "434343", "434343", "797979", "797979", "797979",
        "797979", "797979", "434343", "434343", "434343", "d8d8d8", "d8d8d8", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "434343", "d9d9d9", "434343", "797979", "d8d8d8", "afafaf", "ffffff", "afafaf", "ffffff", "afafaf", "d9d9d9", "797979", "434343", "d9d9d9", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "aeaeae", "d9d9d9", "797979", "797979", "afafaf", "afafaf", "afafaf", "afafaf", "afafaf", "797979", "797979", "d9d9d9", "afafaf", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "d9d9d9", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "d9d9d9", "444444",
        "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "d9d9d9", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "d9d9d9", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "ffffff", "444444", "434343", "aeaeae", "ffffff", "ffffff", "ffffff", "aeaeae", "444444", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "444444", "444444", "444444", "444444", "444444", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff", "ffffff",
        "ffffff", "ffffff", "ffffff", "ffffff"
        ],
        competitionId: "competitionId",
        size: [32, 32],
        topic: nil,
        status: .personal
    )


    static let artwork_mushroom = Artwork(
        id: "13",
        authorId: "mushroomArtist",
        data: [
        "F7EDE2", "#f7ede2", "#f7EDe2", "#F7EDE2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "d33f49", "d33f49", "f7f6c5", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49",
        "d33f49", "d33f49", "d33f49", "d33f49", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "f7f6c5", "d33f49", "d33f49", "d33f49", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "f7f6c5", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "d33f49", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "a26769", "a26769", "a26769", "a26769", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "a26769", "a26769", "a26769", "a26769", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "a26769", "a26769", "a26769", "a26769", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "a26769", "a26769", "a26769",
        "a26769", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "a26769", "a26769", "a26769", "a26769", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "a26769", "a26769", "a26769", "a26769", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "a26769", "a26769", "a26769", "a26769", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "a26769", "a26769", "a26769", "a26769", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "a26769", "a26769", "a26769", "a26769", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "a26769", "a26769", "a26769", "a26769", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2", "f7ede2",
        "f7ede2", "f7ede2", "f7ede2", "f7ede2"
        ],
        competitionId: "mushroomTheme",
        size: [32, 32],
        status: .personal
    )


    
    static let artworks = [
        Artwork(
            id: "1",
            authorId: "authorId",
            data: ["870058", "a4303f", "f2d0a4", "c8d6af"],
            competitionId: "competitionId",
            size: [2, 2],
            topic: nil,
            status: .personal
        ),
        Artwork(
            id: "2",
            authorId: "authorId",
            data: [
                "ff0000", "ff9900", "ffff00", "99ff00",
                "00ff00", "00ff99", "00ffff", "0099ff",
                "0000ff", "9900ff", "ff00ff", "ff0099",
                "cccccc", "999999", "666666", "333333"
            ],
            competitionId: "competitionId",
            size: [4, 4],
            topic: nil,
            status: .personal
        ),
        Artwork(
            id: "3",
            authorId: "authorId",
            data: [
                "ffffff", "f0f0f0", "e0e0e0", "d0d0d0", "c0c0c0", "b0b0b0", "a0a0a0", "909090",
                "808080", "707070", "606060", "505050", "404040", "303030", "202020", "101010",
                "ff0000", "ff7f00", "ffff00", "7fff00", "00ff00", "00ff7f", "00ffff", "007fff",
                "0000ff", "7f00ff", "ff00ff", "ff007f", "ffcccc", "ccffcc", "ccccff", "999999",
                "660000", "006600", "000066", "666600", "660066", "006666", "333300", "003333",
                "330033", "999966", "669999", "996699", "cc6600", "66cc00", "0066cc", "6600cc",
                "00cc66", "cc0066", "cccccc", "9999cc", "cc9999", "99cc99", "ffcc99", "ccff99",
                "99ccff", "cc99ff", "f2f2f2", "e6e6e6", "d9d9d9", "cccccc", "bfbfbf", "b3b3b3"
            ],
            competitionId: "competitionId",
            size: [8, 8],
            topic: nil,
            status: .personal
        )
    ]
    
    static let personArtwork = Artwork(
        id: "1",
        authorId: "1",
        data: [
            "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4",
            "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#000000", "#000000", "#000000", "#ffffff", "#ffffff",
            "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4",
            "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff",
            "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#000000", "#000000", "#464646", "#464646",
            "#464646", "#000000", "#000000", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff",
            "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4",
            "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#000000", "#000000", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#000000", "#000000", "#b4b4b4", "#b4b4b4",
            "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4",
            "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff",
            "#000000", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#000000", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4",
            "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4",
            "#b4b4b4", "#ffffff", "#000000", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#000000", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff",
            "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff",
            "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#000000", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#000000", "#ffffff", "#b4b4b4",
            "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff",
            "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#000000", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#000000", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff",
            "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff",
            "#b4b4b4", "#000000", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#000000", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4",
            "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4",
            "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#000000", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#000000", "#b4b4b4", "#ffffff", "#ffffff",
            "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4",
            "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#000000", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#000000", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4",
            "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#000000",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#000000", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff",
            "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4",
            "#b4b4b4", "#b4b4b4", "#000000", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#000000", "#b4b4b4", "#b4b4b4", "#b4b4b4",
            "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4",
            "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#000000", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#000000", "#b4b4b4",
            "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#ffffff",
            "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#000000",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#000000", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff",
            "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff",
            "#ffffff", "#b4b4b4", "#b4b4b4", "#000000", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#000000", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4",
            "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff",
            "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#000000", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#000000", "#ffffff", "#ffffff", "#b4b4b4",
            "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4",
            "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff",
            "#000000", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#000000", "#ffffff",
            "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4",
            "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4",
            "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#000000", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#000000", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff",
            "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4",
            "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#000000", "#000000",
            "#464646", "#000000", "#000000", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff",
            "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#ffffff",
            "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#000000", "#000000", "#000000",
            "#ffffff", "#ffffff", "#b4b4b4", "#000000", "#b4b4b4", "#ffffff", "#ffffff", "#000000", "#000000", "#000000",
            "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff",
            "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#000000", "#000000",
            "#464646", "#464646", "#464646", "#000000", "#000000", "#000000", "#b4b4b4", "#000000", "#000000", "#000000",
            "#464646", "#464646", "#464646", "#000000", "#000000", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4",
            "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#000000",
            "#000000", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#000000",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#000000", "#000000",
            "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff",
            "#000000", "#000000", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#000000", "#000000", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#b4b4b4",
            "#b4b4b4", "#b4b4b4", "#000000", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#000000", "#b4b4b4",
            "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#000000", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#000000", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#000000", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#000000", "#ffffff", "#ffffff", "#ffffff", "#ffffff",
            "#000000", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#000000", "#ffffff",
            "#ffffff", "#b4b4b4", "#000000", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#000000", "#b4b4b4", "#b4b4b4", "#000000", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#000000", "#b4b4b4", "#b4b4b4", "#000000", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#000000", "#b4b4b4",
            "#ffffff", "#ffffff", "#000000", "#000000", "#000000", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#464646", "#000000", "#000000",
            "#000000", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#000000", "#000000",
            "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#464646", "#464646", "#464646",
            "#464646", "#464646", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000",
            "#000000", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4",
            "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff",
            "#000000", "#000000", "#000000", "#000000", "#000000", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4",
            "#ffffff", "#ffffff", "#ffffff", "#b4b4b4", "#b4b4b4", "#b4b4b4", "#ffffff", "#ffffff", "#ffffff"
        ],
        competitionId: nil,
        size: [33, 33],
        status: .personal
    )
}
