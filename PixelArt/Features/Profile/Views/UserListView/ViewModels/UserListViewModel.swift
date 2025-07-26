//
//  UserListViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/07/2025.
//

import Foundation

@MainActor
final class UserListViewModel: ObservableObject {
    @Published var state: LoadingState<[AppUser]> = .none
    
    private weak var appState: AppState?
    private let userService: UserService
    
    let idArr: [String]
    
    init(
        appState: AppState,
        userService: UserService = DefaultUserService(currentUserId: nil),
        idArr: [String]
    ) {
        self.appState = appState
        self.userService = userService
        self.idArr = idArr
    }
    
    func loadAppUsers() async {
        var appUsers: [AppUser] = []
        
        state = .loading
        
        do {
            for id in idArr {
                let appUser = try await userService.getAppUser(uid: id)
                appUsers.append(appUser)
            }
            state = .success(appUsers)
        } catch {
            state = .error(error)
        }
    }
    
    func retry() async {
        await loadAppUsers()
    }
}
