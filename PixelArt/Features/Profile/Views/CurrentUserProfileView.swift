//
//  ProfileView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI

enum ProfileTo: Hashable {
    case otherUserProfile(String)
    case follow(String, String, [String])
}

struct CurrentUserProfileView: View {
    let appState: AppState
    @StateObject private var viewModel: CurrentUserProfileViewModel
    
    init(appState: AppState) {
        self.appState = appState
        _viewModel = StateObject(wrappedValue: CurrentUserProfileViewModel(appState: appState))
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                CustomNavBar(
                    title: "Profile",
                    subtitle: "",
                    leadingButtonIcon: "ic_gear",
                    leadingButtonAction: {},
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
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .none, .loading:
            ProgressView("Loading...")
        case .success(let data):
            ProfileContentView(
                user: data.user,
                archived: data.archived,
                shared: data.shared,
                showFollowButton: false,
                isFollowing: .constant(nil),
                onFollowTapped: nil
            )
        case .error(let error):
            VStack {
                Text("\(error.localizedDescription)")
            }
        }
    }
}



//#Preview {
//    ProfileView()
//        .environmentObject(AppState())
//}
