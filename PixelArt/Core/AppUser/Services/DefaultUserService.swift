//
//  FirebaseUserService.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 17/07/2025.
//

import Foundation


final class DefaultUserService: UserService {
    
    private let userRepository: UserRepository
    private let currentUserId: String?
    
    init(
        userRepository: UserRepository = FirebaseUserRepository(),
        currentUserId: String?
    ) {
        self.userRepository = userRepository
        self.currentUserId = currentUserId
    }
    
    func registerNewUser(firebaseUid: String, email: String, username: String) async throws {
        guard isUsernameValid(username: username) else {
            throw AppUserError.invalidUsername
        }
            
        let newUser = AppUser(
            id: firebaseUid,
            email: email,
            username: username,
            profilePictureData: createDefaultProfilePicture(),
            followers: [],
            following: [],
            joinedCompetitions: [],
            createdAt: Date()
        )
        
        try await userRepository.createAppUser(newUser)
    }
    
    func getAppUser(uid: String) async throws -> AppUser {
        return try await userRepository.fetchAppUser(uid: uid)
    }
    
    func updateAppUser(_ user: AppUser) async throws {
        guard isAuthorized(user: user) else {
            throw AppUserError.unauthorized
        }
        try await userRepository.updateAppUser(user)
    }
    
    func deleteAppUser(_ user: AppUser) async throws {
        guard isAuthorized(user: user) else {
            throw AppUserError.unauthorized
        }
        try await userRepository.deleteAppUser(user)
    }
    
    private func isAuthorized(user: AppUser) -> Bool {
        if let currentUserId {
            return user.id == currentUserId
        }
        return false
    }
    
    private func createDefaultProfilePicture() -> [String] {
        MockData.personArtwork.data
    }
    
    private func isUsernameValid(username: String) -> Bool {
        !username.isEmpty
    }
    
    func follow(followerId: String, followedId: String) async throws {
        try await userRepository.follow(followerId: followerId, followedId: followedId)
    }
    
    func unfollow(followerId: String, followedId: String) async throws {
        try await userRepository.unfollow(followerId: followerId, followedId: followedId)
    }
}



