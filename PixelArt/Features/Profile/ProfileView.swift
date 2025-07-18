//
//  ProfileView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel: ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            CustomNavBar(
                title: "Profile",
                subtitle: "",
                leadingButtonIcon: "ic_gear",
                leadingButtonAction: {},
                trailingButtonIcon: "ic_logout",
                trailingButtonAction: {
                    appState.logOut()
                }
            )
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading Profile...")
                        .font(.custom("Micro5-Regular", size: 32))
                } else if let error = viewModel.error {
                    VStack(spacing: 16) {
                        Text("Error: \(error.localizedDescription)")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.red)
                        Button("Try Again") {
                            if let user = appState.currentUser {
                                Task { await viewModel.setUserAndLoad(user: user) }
                            }
                        }
                        .pixelBackground(paddingValue: 12)
                    }
                } else {
                    ProfileContentView(
                        user: appState.currentUser,
                        archived: viewModel.archivedArtworks,
                        shared: viewModel.sharedArtworks
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color(hex: "d4d4d4"))
        .onAppear {
            if let user = appState.currentUser {
                Task { await viewModel.setUserAndLoad(user: user) }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppState())
}
