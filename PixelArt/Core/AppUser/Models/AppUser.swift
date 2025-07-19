//
//  AppUser.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 17/07/2025.
//

import Foundation

struct AppUser: Identifiable, Codable {
    let id: String
    let email: String
    let username: String
    let profilePictureData: [String]
    let followers: [String]
    let following: [String]
    let joinedCompetition: [String]
    let createdAt: Date
}
