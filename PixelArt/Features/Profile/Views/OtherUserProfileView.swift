//
//  OtherUserProfileView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 19/07/2025.
//

import SwiftUI

struct OtherUserProfileView: View {
    @EnvironmentObject private var router: NavigationRouter
    
    let appState: AppState
    let selectedUserId: String
    let context: RouteContext

    @StateObject private var viewModel: OtherUserProfileViewModel
    
    init(
        appState: AppState,
        selectedUserId: String,
        context: RouteContext
    ) {
        self.appState = appState
        self.selectedUserId = selectedUserId
        self.context = context
        _viewModel = StateObject(wrappedValue: OtherUserProfileViewModel(appState: appState, followService: AppUserBasedFollowService(userService: DefaultUserService(currentUserId: appState.currentUser?.uid)), selectedUserId: selectedUserId))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(
                title: "Profile",
                subtitle: nil,
                leadingButtonIcon: "ic_arrow",
                leadingButtonAction: {
                    switch context {
                    case .competition:
                        router.competitionRoutes.removeLast()
                    case .profile:
                        router.profileRoutes.removeLast()
                    }
                },
                trailingButtonIcon: nil,
                trailingButtonAction: nil
            )
            contentView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color(hex: "d4d4d4"))
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            Task { await viewModel.load() }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .none, .loading:
            ProgressView("Loading Profile...")
        case .success(let data):
            
            ProfileContentView(
                user: data.user,
                archived: data.archived,
                shared: data.shared,
                context: context,
                showFollowButton: !viewModel.isOwnProfile(),
                isFollowing: $viewModel.isFollowing,
                onFollowTapped: {
                    Task { await viewModel.toggleFollow() }
                }
            )
            
        case .error(let error):
            VStack {
                Text("\(error.localizedDescription)")
            }
        }
    }
    
}

