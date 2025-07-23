//
//  UserDefaultsManager.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 23/07/2025.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() {}
    
    func saveUser(id: String, username: String) {
        UserDefaults.standard.set(id, forKey: UserDefaultsKeys.currentUserId)
        UserDefaults.standard.set(username, forKey: UserDefaultsKeys.currentUserUsername)
    }
    
    var currentUserId: String? {
        UserDefaults.standard.string(forKey: UserDefaultsKeys.currentUserId)
    }
    
    var currentUserUsername: String? {
        UserDefaults.standard.string(forKey: UserDefaultsKeys.currentUserUsername)
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.currentUserId)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.currentUserUsername)
    }
}
