//
//  ProfileRoute.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 21/07/2025.
//

import SwiftUI

enum ProfileRoutes: Hashable {
    case follower(username: String, followerIds: [String])
    case following(username: String, followingIds: [String])
    case result(competition: Competition)
    case profile
    case userProfile(userId: String)
    
    @ViewBuilder
    func destination(appState: AppState) -> some View {
        switch self {
        case .follower(let username, let followerIds):
            UserListView(
                appState: appState,
                usersIds: followerIds,
                title: "Followers",
                subtitle: username,
                context: .profile
            )
        case .following(let username, let followingIds):
            UserListView(
                appState: appState,
                usersIds: followingIds,
                title: "Following",
                subtitle: username,
                context: .profile
            )
        case .result(let competition):
            ResultView(competition: competition)
        case .profile:
            CurrentUserProfileView(appState: appState)
        case .userProfile(let userId):
            OtherUserProfileView(
                appState: appState,
                selectedUserId: userId,
                context: .profile
            )
        }
    }
}
