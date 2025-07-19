//
//  UserService.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 17/07/2025.
//

import Foundation

protocol UserService {
    func registerNewUser(firebaseUid: String, email: String, username: String) async throws
    func getAppUser(uid: String) async throws -> AppUser
    func updateAppUser(_ user: AppUser) async throws
    func deleteAppUser(_ user: AppUser) async throws
}
