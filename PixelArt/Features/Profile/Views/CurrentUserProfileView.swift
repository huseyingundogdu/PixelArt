//
//  ProfileView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @EnvironmentObject private var router: NavigationRouter
    
    let appState: AppState
    @StateObject private var viewModel: CurrentUserProfileViewModel
    
    init(appState: AppState) {
        self.appState = appState
        _viewModel = StateObject(wrappedValue: CurrentUserProfileViewModel(appState: appState))
    }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                CustomNavBar(
                    title: "Profile",
                    subtitle: "",
                    leadingButtonIcon: "ic_ppeditor",
                    leadingButtonAction: {
                        viewModel.profileImage = appState.currentAppUser
                    },
                    trailingButtonIcon: "ic_logout",
                    trailingButtonAction: {
                        viewModel.logOutButtonTapped()
                    }
                )
                contentView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(Color(hex: "d4d4d4"))
            .onAppear {
                Task { await viewModel.load() }
            }
            .fullScreenCover(item: $viewModel.profileImage, onDismiss: {
                Task { await viewModel.refresh() }
            }, content: { appUser in
                ProfilePictureEditorView(appUser: appUser)
            })
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
                context: .profile,
                showFollowButton: false,
                isFollowing: .constant(nil),
                onFollowTapped: nil
            )
            .environmentObject(router)
            
        case .error(let error):
            VStack {
                Text("\(error.localizedDescription)")
            }
        }
    }
}
