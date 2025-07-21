//
//  CompetitionRoute.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 21/07/2025.
//

import Foundation
import SwiftUI

enum CompetitionRoutes: Hashable {
    case pastCompetitions
    case result(competition: Competition)
    case scoringCompetitions
    case voting(competition: Competition)
    case userProfile(userId: String)
    case followers(username: String, folllowerIds: [String])
    case following(username: String, followingIds: [String])
    
    @ViewBuilder
    func destination(appState: AppState) -> some View {
        switch self {
        case .pastCompetitions:
            PastCompetitionsView(appState: appState)
        case .result(let competition):
            ResultView(competition: competition)
        case .scoringCompetitions:
            ScoringCompetitionsView(appState: appState)
        case .voting(let competition):
            VotingView(competition: competition)
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
            
        case .followers(let username, let followerIds):
            UserListView(appState: appState, usersIds: followerIds, title: "Followers", subtitle: username)
        case .following(let username, let followingIds):
            UserListView(appState: appState, usersIds: followingIds, title: "Following", subtitle: username)
        }
    }
}
