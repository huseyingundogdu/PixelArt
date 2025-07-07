//
//  ProfileViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 07/07/2025.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    
    private var authRepository: FirebaseAuthService
    
    init(authRepository: FirebaseAuthService = FirebaseAuthService()) {
        self.authRepository = authRepository
    }
    
    func signOut() async {
        do {
            try authRepository.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}
