//
//  UserRepository.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 17/07/2025.
//

import Foundation

protocol UserRepository {
    func fetchAppUser(uid: String) async throws -> AppUser
    func createAppUser(_ user: AppUser) async throws
    func updateAppUser(_ user: AppUser) async throws
    func deleteAppUser(_ user: AppUser) async throws
    
    func follow(followerId: String, followedId: String) async throws
    func unfollow(followerId: String, followedId: String) async throws
}
