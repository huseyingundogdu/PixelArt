//
//  AppUserBasedFollowService.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/07/2025.
//

import Foundation

final class AppUserBasedFollowService: FollowService {
    
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func isFollowing(followerId: String, followedId: String) async throws -> Bool {
        let user = try await userService.getAppUser(uid: followerId)
        return user.following.contains(followedId)
    }
    
    func follow(followerId: String, followedId: String) async throws {
        try await userService.follow(followerId: followerId, followedId: followedId)
    }
    
    func unfollow(followerId: String, followedId: String) async throws {
        try await userService.unfollow(followerId: followerId, followedId: followedId)
    }
}
