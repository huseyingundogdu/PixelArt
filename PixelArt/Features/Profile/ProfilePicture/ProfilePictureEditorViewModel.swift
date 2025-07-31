//
//  ProfilePictureEditorViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/07/2025.
//

import Foundation

@MainActor
final class ProfilePictureEditorViewModel: ObservableObject {
    @Published var appUser: AppUser
    @Published var data: [String] = []
    @Published var selectedColor: String = "#FFFFFF"
    @Published var operation: Operation = .draw
    @Published var showGrid: Bool = false
    @Published var isColorSheetPresenting: Bool = false
    
    private let userService: DefaultUserService
    
    init(
        appUser: AppUser,
        userService: DefaultUserService = DefaultUserService(currentUserId: UserDefaultsManager.shared.currentUserId)
    ) {
        self.appUser = appUser
        self.userService = userService
        self.data = appUser.profilePictureData
    }
    
    func saveUser() async {
        if let userId = UserDefaultsManager.shared.currentUserId {
            appUser.profilePictureData = data
            do {
                try await userService.updateAppUser(appUser)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
