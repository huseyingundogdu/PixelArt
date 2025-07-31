//
//  AppUser.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 17/07/2025.
//

import Foundation

struct AppUser: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let email: String
    let username: String
    var profilePictureData: [String]
    let followers: [String]
    let following: [String]
    let joinedCompetitions: [String]
    let createdAt: Date
}
