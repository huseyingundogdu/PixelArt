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
    case userProfile(userId: String)
    
    @ViewBuilder
    func destination(appState: AppState) -> some View {
        switch self {
        case .follower(let username, let followerIds):
            UserListView(appState: appState, usersIds: followerIds, title: "Followers", subtitle: username)
        case .following(let username, let followingIds):
            UserListView(appState: appState, usersIds: followingIds, title: "Following", subtitle: username)
        case .result(let competition):
            ResultView(competition: competition)
        case .userProfile(let userId):
            
            if let currentUser = appState.currentUser {
                if currentUser.uid == userId {
                    CurrentUserProfileView(appState: appState)
                } else {
                    OtherUserProfileView(appState: appState, selectedUserId: userId)
                }
            } else {
                EmptyView()
            }
            
        }
    }
}
