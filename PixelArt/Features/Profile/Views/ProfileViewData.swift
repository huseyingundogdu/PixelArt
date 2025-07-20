//
//  ProfileViewData.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/07/2025.
//

import Foundation

struct ProfileViewData: Codable, Equatable, Hashable {
    let user: AppUser
    let archived: [Artwork]
    let shared: [Artwork]
    let isFollowing: Bool?
}
