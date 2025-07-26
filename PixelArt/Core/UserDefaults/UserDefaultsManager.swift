//
//  UserDefaultsManager.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 23/07/2025.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard

    private init() {}
    
    var currentUserId: String? {
        defaults.string(forKey: UserDefaultsKeys.currentUserId)
    }
    
    var currentUserUsername: String? {
        defaults.string(forKey: UserDefaultsKeys.currentUserUsername)
    }
    
    func setUser(id: String, username: String) {
        defaults.set(id, forKey: UserDefaultsKeys.currentUserId)
        defaults.set(username, forKey: UserDefaultsKeys.currentUserUsername)
    }
    
    func clear() {
        defaults.removeObject(forKey: UserDefaultsKeys.currentUserId)
        defaults.removeObject(forKey: UserDefaultsKeys.currentUserUsername)
    }
}
