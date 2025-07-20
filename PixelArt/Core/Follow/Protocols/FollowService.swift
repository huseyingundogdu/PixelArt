//
//  FollowService.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/07/2025.
//

import Foundation

protocol FollowService {
    func isFollowing(followerId: String, followedId: String) async throws -> Bool
    func follow(followerId: String, followedId: String) async throws
    func unfollow(followerId: String, followedId: String) async throws
}
